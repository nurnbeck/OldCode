#pragma once

// stack data structure based on SList
// DON'T CHANGE!

#include "SList.h"

class Stack
{
public:
  // public interface

  // constructor
  // nothing to do, list (below) is constructed automatically
  Stack() { } 
  
  // destructor
  // nothing to do, list (below) is destroyed automatically
  ~Stack() { }

  // return true iff stack is empty
  bool empty();

  // return top element
  // pre-cond: not empty
  int top();

  // add new element on top
  void push(int x);

  // remove topmost element
  // pre-cond: not empty
  void pop();

private:
  // private data
  SList list;
};
