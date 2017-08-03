                                                                                                                                                                                                                                                                                                                                                              #include<iostream>

using namespace std;

template <class E>
class Node{
  public:
    Node(E data);
    Node(E data, Node *prev);
    E getData();
  private:
    E element;
    Node<E>* previous;
};

template <class E>
Node<E>::Node(E data, Node<E>* prev){
  element = data;
  previous = prev;
}

template <class E>
E Node<E>::getData(){
  return element;
}

int main(){
  Node<int> node(10, 0);
  Node<int> node2(20, &node);
  cout << node.getData() << endl << node2.getData();
  return 0;
}
