# Represents a stack.
# Utilizes first in last out.
# All operations are constant time
class Stack
  attr_reader :size

  # No arg Constructor
  def initialize
    clear
  end

  # adds an item to the stack
  def push(element)
    @head = Node.new(element, @head)
    @size += 1
  end

  # Returns the item at the top
  def top
    raise ArgumentError, 'NoSuchElementException' if @head.nil?
    @head.element
  end

  # Returns the item at the top and removes it from the stack
  def pop
    raise ArgumentError, 'NoSuchElementException' if @head.nil?
    return_value = @head.element
    @head = @head.previous
    @size -= 1
    return_value
  end

  def clear
    @head = nil
    @size = 0
  end

  # Returns true if the stack is empty
  def empty?
    @size.zero?
  end

  private

  # Represents a single node in a stack
  class Node
    attr_reader :element, :previous
    def initialize(element, previous = nil)
      @element = element
      @previous = previous
    end
  end
end
