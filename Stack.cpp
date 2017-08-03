                                                                                                                                                                                                                                                                                                                                                              #include<iostream>

using namespace std;

// template <class E>
// class Node {
//   public:
//     Node(E data);
//     Node(E data, Node *prev);
//     E getData();
//   private:
//     E element;
//     Node* previous;
// };

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
    void outputState();
    // template <class E>
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
  private:
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
}

template <class E>
void Stack<E>::outputState(){
  cout << isEmpty() << endl;
  cout << size << endl;
  cout << "Top address " << topNode << endl;
  cout << "Top data " << topNode -> getData() << endl;
  cout << "Top previous address " << topNode -> getPrevious() << "\n\n";
}

int main(){
  // Node<int> node(10, 0);
  // Node<int> node2(20, &node);
  // cout << node.getData() << endl << node2.getData() << endl;
  Stack<int> stack;
  stack.outputState();
  stack.push(10);
  stack.outputState();
  stack.push(20);
  stack.push(123);
  stack.outputState();
  cout << stack.pop() << endl;
  stack.outputState();
  cout << stack.top() << endl;
  stack.clear();
  stack.outputState();

  return 0;
}
