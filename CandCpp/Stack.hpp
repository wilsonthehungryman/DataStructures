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

template <class E>
Stack<E>::Node::Node(E data, Node* prev){
  element = data;
  previous = prev;
}

template <class E>
E Stack<E>::Node::getData(){
  return element;
}

template <class E>
typename Stack<E>::Node * Stack<E>::Node::getPrevious(){
  return previous;
}

template <class E>
Stack<E>::Stack(){
  size = 0;
}

template <class E>
int Stack<E>::getSize(){
  return size;
}

template <class E>
bool Stack<E>::isEmpty(){
  return size == 0;
}

template <class E>
void Stack<E>::push(E data){
  Node* previous;
  if(size == 0){
    previous = 0;
  }else{
    previous = topNode;
  }
  topNode = new Node(data, previous);
  size++;
}

template <class E>
E Stack<E>::top(){
  Node node = *topNode;
  return node.getData();
}

template <class E>
E Stack<E>::pop(){
  E data = top();
  Node current = *topNode;
  topNode = current.getPrevious();
  delete &current;
  size--;

  return data;
}

template <class E>
void Stack<E>::clear(){
  while(topNode -> getPrevious() != 0){
    pop();
  }
  if(topNode -> getPrevious() == 0){
    delete &topNode;
  }
  size = 0;
}

#endif
