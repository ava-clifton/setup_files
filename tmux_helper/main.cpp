#include <vector>
#include <map>
#include <set>
#include <list>
#include <cassert>
#include <stdlib.h> 
#include <string>
#include <sstream>
#include <cstdlib>

#include <iterator>
#include <iomanip>
#include <iostream>
#include <sstream>

using namespace std;

string last(char* path){
  //cout << "DEALING WITH " << string(path) << endl;
  int i=0;
  int last_slash = -1;
  while (path[i]) {
    //cout << path[i] << endl;
    if (path[i] == '/') last_slash = i;
    i++;
  }
  //cout << last_slash << endl;
  if (last_slash == -1) return string(path);
  else return string(path+1+last_slash);
}

bool in(char* arg, string str) {
  string arg_string = string(arg);
  //cout << "in" << arg_string.find(str) << "/" << string::npos << " ";
  //cout << " ret:" << (arg_string.find(str) != string::npos);
  return arg_string.find(str) != string::npos;
}

bool in(int argc, char** argv, string str) {
  for (int i=0; i<argc; i++) {
    if (in(argv[i], str)) return true;
  }
  return false;
};

int main(int argc, char **argv) {
  //for(int i=0; i<argc; i++) cout << argv[i] << " ";
  string before_after = string(argv[1]);
  string use_colour = string(argv[2]);
  string num = string(argv[3]);
  string path = string(argv[4]);
  string command = string(argv[5]);
  vector<string> args;
  //for (int arg_num=0; 
  //args = string(argv[6:])

  string yellow="#[bg=#505000]";
  string light_yellow="#[bg=#f0f000, fg=#101010]";

  string blue="#[bg=#202050]";
  string light_blue="#[bg=#b0b0ff, fg=#101010]"; // 9

  string green="#[bg=#204020]";
  string light_green="#[bg=#90f090, fg=#101010]"; // 7, c

  string light_bash="#[bg=#e0e0e0, fg=#101010]";

  if (before_after == "0") {
    if (use_colour == "0") cout << "#[fg=colour34]";

    if (command == "vim") {
      if (use_colour == "0") cout << light_green;
      else                   cout << green;
    } else if (command == "bash") {
      if (use_colour == "0") cout << light_bash;

    } else if (command == "ssh") {
      if (use_colour == "0") cout << light_blue;
      else                   cout << blue;
    } else {
      // default case
      if (use_colour == "0") cout << light_yellow;
      else                   cout << yellow;
    }
  } else {
    if (command == "vim") {

      string accumulated_string = "";
      for (int arg=7; arg<argc; arg++) accumulated_string += string(argv[arg]) + " ";
      if (accumulated_string.size() > 40) {
        accumulated_string.resize(40);
        accumulated_string += "... ";
      }
      cout << accumulated_string;

      //for (int arg=7; arg<argc; arg++) cout << string(argv[arg]) << " ";
    } else if (command == "bash") {
      cout << last(argv[4]) << " "; //("/")[-1] + " ")
    } else if (command == "ssh") {
      // manual, for all the hosts I use
      if (in(argc, argv, "goedel")) cout << "goedel ";
      else if (in(argc, argv, "bulwark")) cout << "etna ";
      else if (in(argc, argv, "dolphin")) cout << "dolphin ";
      else if (in(argc, argv, "whale")) cout << "whale ";
      else if (in(argc, argv, "gadi")) cout << "gadi ";
      else cout << "??? ";
      //for (int arg=7; arg<argc; arg++) cout << string(argv[arg]) << " ";
    } else {
    }
  }
}


/*
  if (use_colour == "0") cout << "#[fg=colour34]";

  if (command == "vim") {
    if (use_colour == "1") {
      cout << green;
    }
    cout << " vim ";

    for (int arg=7; arg<argc; arg++) cout << string(argv[arg]) << " ";
  } else if (command == "bash") {
    cout << " bash ";
    cout << last(argv[4]) << " "; //("/")[-1] + " ")
  } else if (command == "ssh") {
    if (use_colour == "1") {
      cout << blue;
    }
    cout << " ssh ";
  } else {
    // default case
    if (use_colour == "1") {
      cout << yellow;
    }
    cout << " " << command << " ";
  }
*/
