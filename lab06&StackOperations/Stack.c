//file inclusions
#include "Stack.h"
#include <assert.h>

//creates list to act as stack

//checks if there are nodes in stack
//list.size() returns resulting bool 
bool Stack::empty()
{
  return (list.size() == 0);
}
//adds a head node to stack
//with SList functin add_head
void Stack::push(int x)
{
  list.add_head(x);
}
//removes top element of stack
//by calling remove_head()
void Stack::pop()
{
  assert(list.size() > 0);
  list.remove_head();
}
//returns top(head) element of stack
//by creating a copy node of .get_head()
//and calling .get() on resulting node
int Stack::top()
{
  assert(list.size() > 0 );
  Node T = *list.get_head();
  int q = T.get();
  return (q);
}
