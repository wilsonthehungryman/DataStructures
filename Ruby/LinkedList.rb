#
class LinkedList
  attr_reader :size

  def initialize
    clear
  end

  def empty?
    @size.zero?
  end

  def clear
    @head = nil
    @tail = nil
    @size = 0
  end

  def add(data)
    link_head(data)
  end

  # def get
  #   validate(1)
  #   @head.element
  # end

  def get_first
    validate(1)
    @head.element
  end

  def get_last
    validate(1)
    @tail.element
  end

  def get(arg)
    if args.nil
      return get_first
    else arg.is_a? Integer
      result = find_position(arg)
      return  result.nil?
    end
  end

  def remove
    validate(1)
    unlink_head
  end

  def remove_first
    validate(1)
    unlink_head
  end

  def remove_last
    validate(1)
    unlink_tail
  end

  def set(data)
    validate(1)
    set_data(data)
  end

  def set_first(data)
    validate(1)
    set_data(data, @head)
  end

  def set_last(data)
    validate(1)
    set_data(data, @tail)
  end


  private

  # private Node<E> find(int position)
  # {
  #     // Create the node to be returned, starts off as the head
  #     Node<E> current = head;
  #
  #     // i is the counter
  #     int i = 1;
  #
  #     // While i is less than position get the next node
  #     while(i < position){
  #         // Get the next node
  #         current = current.getNext();
  #
  #         // increment the counter
  #         ++i;
  #     }
  #
  #     //return the found node
  #     return current;
  # }

  def find(data)
    result = find_position
  end

  def find_position(i)
    current = @head

    i.each { current = current.next }

    current
  end

  def find_data(data)
    current = @head
    until current.nil? || current.element == data { current = current.next }
    current
  end

  def set_data(data, current)
    old_data = current.element
    current.element = data
    old_data
  end

  def link_head(data)
    to_add = Node.new({element: data, previous: nil, next: @head})

    if @head.nil?
      @tail = to_add
    else
      @head.previous = to_add
    end

    @head = to_add

    @size += 1
  end

  def link_tail(data)
    to_add = Node.new({element: data, previous: @tail, next: nil})
    if @tail.nil?
      @head = to_add
    else
      @tail.next = to_add
    end

    @head = to_add

    @size += 1
  end

  def unlink_head
    current = @head

    @head = @head.next
    if @head.nil?
      @tail = nil
    else
      @head.previous = nil
    end
    @size -= 1
    current.element
  end

  def unlink_tail
    current = @tail

    @tail = @tail.next

    if @tail.nil?
      @head = nil
    else
      @tail.next = nil
    end

    @size -= 1

    current.element
  end

  def validate(i)
    raise ArgumentError, 'No such element' if (i > @size)
  end

  class Node
    attr_accessor :element, :next, :previous
    def initialize(args = nil)
      @element = nil
      @next = nil
      @previous = nil

      unless args.nil?
        @element = args[:element] if args.key? :element
        @next = args[:next] if args.key? :next
        @prevouse = args[:previous] if args.key? :previous
      end
    end
  end
end
