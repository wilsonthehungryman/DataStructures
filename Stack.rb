#
class Stack
  attr_reader :size

  def initialize
    @size = 0
    @head = nil
  end

  def push(element)
    @head = Node.new(element, @head)
    @size += 1
  end

  def top
    raise ArgumentError, 'NoSuchElementException' if @head.nil?
    @head.element
  end

  def pop
    raise ArgumentError, 'NoSuchElementException' if @head.nil?
    return_value = @head.element
    @head = @head.previous
    @size -= 1
    return_value
  end

  def empty?
    @size.zero?
  end

  private

  #
  class Node
    attr_reader :element, :previous
    def initialize(element, previous = nil)
      @element = element
      @previous = previous
    end
  end
end
