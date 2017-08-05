#include "Stack.hpp"
#include <iostream>

using namespace std;

void checkEquality(int value1, int value2, string operation);

int main(void){
  Stack<int> stack;
  if(stack.isEmpty()){
    stack.push(10);
    if(!stack.isEmpty()){
      stack.push(22);
      stack.push(33);
      stack.push(44);
      checkEquality(44, stack.top(), "top");

      int temp = stack.pop();
      checkEquality(44, temp, "pop");
      checkEquality(33, stack.top(), "top after pop");
      checkEquality(3, stack.getSize(), "size check");
      stack.clear();
      // check exception on top/pop, once coded
      checkEquality(0, stack.getSize(), "size check");
    }
  }else{
    cout << "stack started off not empty";
  }

  cout << "\nFinished execution\n";

  return 0;
}

void checkEquality(int value1, int value2, string operation){
  if(value1 != value2){
    cout << operation << " should be " << value1 << " but is " << value2 << endl;
  }
}
