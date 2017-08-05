#
class Queue
  attr_reader :size
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def empty?
    @size.zero?
  end

  def enqueue(element)
    to_add = Node.new(element)
    if @size.zero?
      @head = to_add
    else
      @tail.next = to_add
    end
    @tail = to_add
    @size += 1
  end

  def add(element)
    enqueue(element)
    true
  end

  def offer(element)
    begin
      enqueue(element)
      return true
    rescue
      return false
    end
  end

  def front
    raise ArgumentError, 'NoSuchElementException' if @size.zero?
    @head.element
  end

  def element
    front
  end

  def peek
    return nil if @size.zero?
    @head.element
  end

  def dequeue
    raise ArgumentError, 'NoSuchElementException' if @size.zero?
    return_value = @head.element
    @head = @head.next
    @size -= 1
    @tail = @head if @size <= 1
    return_value
  end

  def remove
    dequeue
  end

  def poll
    return nil if @size.zero?
    dequeue
  end

  #
  class Node
    attr_reader :element
    attr_accessor :next

    def initialize(element, next_node = nil)
      @element = element
      @next = next_node
    end
  end
end
