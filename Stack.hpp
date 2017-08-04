#ifndef STACK_H
#define STACK_H
template <class E>
class Stack {
  public:
    Stack();
    int getSize();
    bool isEmpty();
    void push(E data);
    E top();
    E pop();
    void clear();
    // void outputState();
  private:
    class Node {
    public:
      Node(E data);
      Node(E data, Node *prev);
      E getData();
      Node * getPrevious();
    private:
      E element;
      Node* previous;
    };
    int size;
    Node* topNode;
};
#endif
