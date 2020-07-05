//
// Created by zode on 2020/6/29.
//

#ifndef KLEE_MODIFYLLVM_H
#define KLEE_MODIFYLLVM_H

#include <cstring>
#include <set>
#include <string>
#include <vector>
#include <thread>

using namespace std;

class ModifyLLVM {
public:
  ModifyLLVM();
  void configArgv(const string&argv2);
  void configFunNames(const string &newPath, const string &llName);
  static void getFiles(const string &newPath, vector<string> &fileNames);
  void parseJson(const string &newPath, const string &llName);
  void threadControl();
  void ModifyLLFile(const pair<string, set<vector<string>>>& func);

private:
  string newPath;

  vector<string> newLLPath;
  vector<string> fileLines;
  vector<pair<string, set<vector<string>>>> funcs;

public:
  char *newArgvs[10]{};
};

vector<string> split(const string &str, const string &delim);

#endif // KLEE_MODIFYLLVM_H
