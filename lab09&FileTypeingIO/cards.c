#include <vector>
#include <assert.h>
#include <iostream>
#include <ctime>
#include <cstdlib>
#include <algorithm>

using namespace std;


// Returns the rank of a card
unsigned char getRank( unsigned char c )
{
  return c / 4;
}

// Returns the suit of a card
unsigned char getSuit( unsigned char c )
{
  return c % 4;
}

// Prints a card to stdout
void printCard( unsigned char c )
{
  static const char *suits = "shdc";
  static const char *ranks = "23456789TJQKA";
  const unsigned char rank = getRank(c);
  assert(rank < 13);
  const unsigned char suit = getSuit(c);
  assert(suit < 4);
  cout << ranks[rank] << suits[suit];
}

int main()
{
  //vector creation
  vector<int> deck(52);
  fill(deck.begin(),deck.end(),0);
  //fill vector
  for(unsigned int i = 1; i < deck.size(); i++)
  {
    deck[i] = i;
  }
  //random call of STL
  random_shuffle ( deck.begin(), deck.end() );
  //dealing of hand
   for(unsigned int i = 1; i < 6; i++)
  {
    printCard((char)deck[i]);
  }
   cout << endl << "there is your hand,player" << endl;
  
  return 1;
}
