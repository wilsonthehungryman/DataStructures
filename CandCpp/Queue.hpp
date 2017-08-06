#ifndef QUEUE_H
#define QUEUE_H
template <class E>
class Queue {
  public:
    Queue();
    int getSize();
    bool isEmpty();
    void clear();

    void enqueue(E element);
    bool add (E element);
    bool offer(E element);

    E front();
    E element();
    E* peek();

    E dequeue();
    E remove();
    E* poll();
  private:
    class Node {
    public:
      Node(E data, Node *nextNode);
      E getData();
      Node * getNext();
      void setNext(Node* newNext);
    private:
      E element;
      Node* next;
    };
    int size;
    Node* head, tail;
};
#endif

template <class E>
Queue<E>::Node::Node(E data, Node* nextNode){
  element = data;
  next = nextNode;
}

template <class E>
E Queue<E>::Node::getData(){
  return element;
}

template <class E>
void Queue<E>::Node::setNext(Node* newNext){
  next = newNext;
}

template <class E>
typename Queue<E>::Node * Queue<E>::Node::getNext(){
  return next;
}

template <class E>
Queue<E>::Queue(){
  size = 0;
  head = 0;
  tail = 0;
}

template <class E>
int Queue<E>::getSize(){
  return size;
}

template <class E>
bool Queue<E>::isEmpty(){
  return size == 0;
}

template <class E>
void Queue<E>::clear(){

}

template <class E>
void Queue<E>::enqueue(E element){
  Node newNode = new Node(element, 0);
  if(size == 0){
    head = &newNode;
  }else{
    tail -> setNext(&newNode);
  }

  tail = &newNode;
  size++;
}

template <class E>
bool Queue<E>::add(E element){
  enqueue(element);
  return true;
}

template <class E>
bool Queue<E>::offer(E element){
  enqueue(element);
  return true;
  // Catch exception and return false
}

template <class E>
E Queue<E>::front(){
  if(size == 0){
    // throw exception
  }

  return head -> getData();
}

template <class E>
E Queue<E>::element(){
  return front();
}

template <class E>
E * Queue<E>::peek(){
  if(size == 0){
    return 0;
  }else{
    return &(head -> getData());
  }
}

template <class E>
E Queue<E>::dequeue(){
  if(size == 0){
    // TODO throw exception
  }

  E data = head -> getData();

  head = head -> getNext();

  size--;

  if(size <= 1){
    tail = head;
  }

  return data;
}

template <class E>
E Queue<E>::remove(){
  return dequeue();
}

template <class E>
E * Queue<E>::poll(){
  if(size == 0){
    return 0;
  }else{
    return &dequeue();
  }
}
