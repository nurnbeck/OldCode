#pragma once

// Node data structure
// struct = class with public members

// DON'T CHANGE

struct Node
{
  // data
  int data;     // data associated with node
  Node *succ;   // pointer to successor node

  // member functions
  void set(int data);
  int  get() const;
  Node *next();
};


// SList data structure
class SList
{
public:
  // public interface

  // constructor: no nodes
  SList();

  // destructor
  ~SList();

  // free all nodes and empty list
  void free();

  // add node containing data at front
  void add_head(int data);

  // returns pointer to head node
  Node *get_head();

  // removes head node
  void remove_head();

  // return number of nodes
  int size();

private:
  // private data
  Node *head; // pointer to head node
  int n;      // number of nodes
};
