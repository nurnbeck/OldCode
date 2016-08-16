#include "SList.h"
#include <stdlib.h>
#include <stdio.h>
  
// set node data
void Node::set(int x)
{
  data = x;
}

// return node data
int Node::get() const
{
  return data;
}

// return pointer to next node
Node *Node::next()
{
  return succ;
}


// constructor: initialize list, no nodes
SList::SList()
{
  head = 0;
  n = 0;
}

// destructor: free all nodes
SList::~SList()
{
  free();
}

// frees all node memory and empties list
void SList::free()
{
  while (head) {
    remove_head();
  }
}

// return number of nodes
int SList::size()
{
  return n;
}

// add node containing data at front
void SList::add_head(int data)
{
  Node *q = new Node;   // new node
  q->data = data;       // store data in new node
  q->succ = head;       // old head is q successor
  head = q;             // new node is head
  n++;                  // one more node
}

// returns pointer to head node
Node *SList::get_head()
{
  return head;
}

// removes head node
void SList::remove_head()
{
  if (!head) {          // no node?
    printf("can't remove head from empty list!\n");
    exit(1);            // stop program
  }
  n--;                  // one less node
  Node *q = head->succ; // save pointer to successor
  delete head;          // free head node
  head = q;             // head successor now head
}
