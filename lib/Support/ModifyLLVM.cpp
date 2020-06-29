//
// Created by zode on 2020/6/29.
//
#include "klee/ModifyLLVM.h"

#include <dirent.h>
#include <unistd.h>
#include <cstring>
#include <sys/stat.h>
#include <fstream>
#include <iostream>
#include <rapidjson/document.h>
#include <rapidjson/filereadstream.h>
#include <regex>

vector<string> split(const string &str, const string &delim) {
  vector<string> res;
  if (str.empty())
    return res;
  //先将要切割的字符串从string类型转换为char*类型
  char *strs = new char[str.length() + 1]; //不要忘了
  strcpy(strs, str.c_str());

  char *d = new char[delim.length() + 1];
  strcpy(d, delim.c_str());

  char *p = strtok(strs, d);
  while (p) {
    string s = p; //分割得到的字符串转换为string类型
    res.push_back(s);  //存入结果数组
    p = strtok(nullptr, d);
  }

  return res;
}

vector<pair<string, set<vector<string>>>>
parseJson(const string &newPath) {
  //从文件中读取，保证当前文件夹有.json文件
  string jsonPath = newPath + "/" + "test.json";
  ifstream inFile(jsonPath, ios::in);
  if (!inFile.is_open()) {
    cout << "Error opening file\n";
    exit(0);
  }

  // 以二进制形式读取json文件内容
  ostringstream buf;
  char ch;
  while (buf && inFile.get(ch))
    buf.put(ch);

  // 文件流指针重置
  inFile.clear();
  inFile.seekg(0, ios::beg);

  // 扫描所有json中的函数名字
  string thisLine;
  vector<string> funNames;
  while (getline(inFile, thisLine)) {
    regex pattern(R"( +\"(\w+)\": \[)");
    smatch regResult;

    if (regex_match(thisLine, regResult, pattern)) {
      funNames.push_back((++regResult.begin())->str());
    }
  }

  // 解析json及inst
  vector<pair<string, set<vector<string>>>>
      instructions;
  rapidjson::Document document;
  document.Parse(buf.str().c_str());
  for (const auto &funName : funNames) {
    const rapidjson::Value &jsonArray = document[funName.c_str()];
    // 处理每个函数中的算数指令
    set<vector<string>> tmpSet;
    pair<string, set<vector<string>>> tmpPair;
    for (auto &inst : jsonArray.GetArray()) {
      regex pattern(R"((%\w+) = (\w+) (\w+) (%\w+), (.+))");
      smatch regResult;
      vector<string> tmp(5);
      string instStr = inst.GetString();
      if (regex_match(instStr, regResult, pattern))
        for (int i = 0; i < 5; ++i)
          tmp[i] = regResult[i + 1].str();

      tmpSet.insert(tmp);
    }

    tmpPair = make_pair(funName, tmpSet);
    instructions.push_back(tmpPair);
  }

  return instructions;
}

void getFiles(const string &newPath, vector<string> &fileNames) {
  DIR *dir;
  struct dirent *ptr;
  char base[1000];

  if ((dir = opendir(newPath.c_str())) == nullptr) {
    perror("Open dir error...");
    exit(1);
  }

  while ((ptr = readdir(dir)) != nullptr) {
    if (strcmp(ptr->d_name, ".") == 0 ||
        strcmp(ptr->d_name, "..") == 0) /// current dir OR parrent dir
      continue;
    else if (ptr->d_type == 8) /// file
      fileNames.emplace_back(ptr->d_name);
    else if (ptr->d_type == 10) /// link file
      // printf("d_name:%s/%s\n",basePath,ptr->d_name);
      continue;
    else if (ptr->d_type == 4) /// dir
      fileNames.emplace_back(ptr->d_name);
  }
  closedir(dir);
}

string modifyLLVM(const string &newPath, const string &llName) {
  ifstream inLLFile;
  ofstream outLLfile;

  vector<string> fileNames;
  getFiles(newPath, fileNames);
  // open .ll file
  string llvmPath = newPath + "/" + llName;
  inLLFile.open(llvmPath, ios::in);
  if (!inLLFile.is_open()) {
    cout << "no `.ll` files" << endl;
    exit(0);
  }

  vector<string> fileLines;
  string thisLine;
  while (getline(inLLFile, thisLine))
    fileLines.push_back(thisLine);

  inLLFile.close();

  vector<pair<string, set<vector<string>>>>
      funNames;
  funNames = parseJson(newPath);

  // measure all Functions
  // each fun should be measured independent
  vector<string> globalDeclares;
  vector<string> symbolicLines;
  pair<string, set<vector<string>>> funName;
  for (const auto &tmpfunName : funNames) {
    // find if this function has figured
    if (find(fileNames.begin(), fileNames.end(), funName.first) !=
        fileNames.end())
      continue;

    funName = tmpfunName;
  }

  if (!funName.first.empty()) {
    // configure llvm lines
    int gCount = 0; // count global declares
    for (auto instructions : funName.second) {
      regex varReg_1(" *" + instructions[3] +
                          R"( = load i32, i32\* (@\w+).*)");
      regex varReg_2(" *" + instructions[4] +
                          R"( = load i32, i32\* (@\w+).*)");
      regex resReg(R"( *store i32 )" + instructions[0] +
                        R"(, i32\* ([@%]\w+).*)");
      smatch loadResult;
      string varName_1, varName_2, resName;
      vector<string> vars;
      // FIXME 这边需要先确定.ll文件中的最初声明位置
      bool inFunBlock = false;
      for (const auto &fileLine : fileLines) {
        if (inFunBlock && fileLine.find('}') != string::npos) {
          inFunBlock = false;
          break;
        }
        if (!inFunBlock) {
          regex funDeclarePattern(".*@" + funName.first + R"(.*\{)");
          smatch regFunDeclareResult;
          inFunBlock = regex_match(fileLine, regFunDeclareResult,
                                        funDeclarePattern);
          continue;
        }

        varName_1 = regex_match(fileLine, loadResult, varReg_1) &&
                    varName_1.empty()
                    ? loadResult[1].str()
                    : varName_1;
        varName_2 = regex_match(fileLine, loadResult, varReg_2) &&
                    varName_2.empty()
                    ? loadResult[1].str()
                    : varName_2;
        resName =
            regex_match(fileLine, loadResult, resReg) && resName.empty()
            ? loadResult[1].str()
            : resName;
      }
      // FIXME 我注释了算数操作的结果的符号化 但运行时可能需要
      //      vars.push_back(resName);
      vars.push_back(varName_1);
      vars.push_back(varName_2);

      // ! 非全局变量的命名为数字
      // FIXME 暂时不符号化函数内变量
      for (auto & var : vars) {
        string tmpGol = R"(@.str)";
        string tmpSym =
            R"(call void @klee_make_symbolic(i8* bitcast (i32* )" + var +
            R"( to i8*), i64 4, i8* getelementptr inbounds ([)" +
            to_string(var.size()) + R"( x i8], [)" +
            to_string(var.size()) + R"( x i8]* @.str)";
        if (gCount == 0) {
          tmpGol += " = private unnamed_addr constant [" +
                    to_string(var.size()) + R"( x i8] c")" +
                    var.substr(1) + R"(\00", align 1)";
          tmpSym += R"(, i64 0, i64 0)))";
        } else {
          tmpGol += "." + to_string(gCount) +
                    " = private unnamed_addr constant [" +
                    to_string(var.size()) + R"( x i8] c")" +
                    var.substr(1) + R"(\00", align 1)";
          tmpSym += "." + to_string(gCount) + R"(, i64 0, i64 0)))";
        }

        globalDeclares.push_back(tmpGol);
        symbolicLines.push_back(tmpSym);
        gCount++;
      }
      globalDeclares.emplace_back(
          "declare void @klee_make_symbolic(i8*, i64, i8*)");
    }

    // FIXME 局部变量无法使用`bitcast (%struct.str* @global to i8*)`
    bool inGlobalDeclare = false;
    regex funDeclarePattern(R"(define.*@.*\{)");
    regex thisFunPattern(".*@" + funName.first + R"(.*\{)");
    smatch regFunDeclareResult;
    smatch regThisFunResult;
    for (int i = 0; i < fileLines.size(); i++) {
      string fileLine = fileLines[i];
      if (fileLine.find(R"(target triple = "x86_64-pc-linux-gnu")") !=
          string::npos) {
        inGlobalDeclare = true;
        continue;
      }
      if (inGlobalDeclare &&
          fileLine.find("; Function Attrs:") != string::npos) {
        for (int j = 0; j < globalDeclares.size(); j++) {
          fileLines.insert(fileLines.begin() + i + j - 1,
                           globalDeclares[j]);
        }
        i += globalDeclares.size();
        inGlobalDeclare = false;
        continue;
      }

      if (!inGlobalDeclare &&
          regex_match(fileLine, regFunDeclareResult, thisFunPattern)) {
        for (int j = 0; j < symbolicLines.size(); ++j) {
          fileLines.insert(fileLines.begin() + i + j + 1,
                           "  " + symbolicLines[j]);
        }
        i += symbolicLines.size();
        break;
      }
    }
  }

  // output .ll file
  outLLfile.open(newPath + "/" + funName.first + ".ll");
  for (auto fileLine : fileLines)
    outLLfile << fileLine << endl;
  outLLfile.close();

  // 生成 .bc文件
  string command = "llvm-as " + newPath + "/" + funName.first + ".ll";
  system(command.c_str());

  return newPath + "/" + funName.first;
}

vector<string> configArgv(string argv1) {
  vector<string> result;
  string path = getcwd(nullptr, 0);
  vector<string> filePaths = split(argv1, "/");

  vector<string>::const_iterator first = filePaths.begin();
  vector<string>::const_iterator last =
      filePaths.begin() + filePaths.size() - 1;
  vector<string> cutPath(first, last);
  for (const auto &tmpPath : cutPath)
    path += "/" + tmpPath;

  vector<string> fileNames = split(filePaths.back(), ".");
  string newPath = path + "/" + fileNames.front();
  //  puts(newPath.c_str());

  if (access(newPath.c_str(), 0) != 0)
    mkdir(newPath.c_str(), S_IRUSR | S_IWUSR | S_IXUSR | S_IRWXG | S_IRWXO);

  // copy *.bc to tmp folder
  string copyPath = newPath + "/" + filePaths.back();
  string sourcePath = path + "/" + filePaths.back();
  string command = "cp " + sourcePath + " " + copyPath;
  system(command.c_str());

  // translate to .ll file
  command = "llvm-dis " + copyPath;
  system(command.c_str());

  // return new XX.bc path
  string llName = fileNames.front() + ".ll";
  string thisFunPath = modifyLLVM(newPath, llName);
  vector<string> thisFunName = split(thisFunPath, "/");

  argv1 = thisFunPath + ".bc";

  result.push_back(argv1);
  result.push_back("--entry-point=" + thisFunName.back());
  // TODO 修改argv2 为当前函数
  return result;
}