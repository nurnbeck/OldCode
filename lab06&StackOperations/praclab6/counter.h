#pragma once

// as simple counter class

class Counter
{
public:

  // initialize value with i
  Counter(unsigned int i);

  // clean up - nothing to do
  ~Counter();

  // pre-cond: value > 0
  // decrement value
  void tick();

  // return true iff value == 0
  bool done() const;

private:

  // implementation details ...
  
  // current value
  unsigned int value;
};