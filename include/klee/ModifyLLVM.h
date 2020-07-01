//
// Created by zode on 2020/6/29.
//

#ifndef KLEE_MODIFYLLVM_H
#define KLEE_MODIFYLLVM_H

#include <cstring>
#include <set>
#include <string>
#include <vector>

using namespace std;

// class ModifyLLVM {
// public:
//
//};

vector<string> split(const string &str, const string &delim);

vector<pair<string, set<vector<string>>>> parseJson(const string &newPath, const string &llName);

void getFiles(const string &newPath, vector<string> &fileNames);

string modifyLLVM(const string &newPath, const string &llName);

vector<string> configArgv(string argv1);

#endif // KLEE_MODIFYLLVM_H
