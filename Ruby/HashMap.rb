#
class HashMap
  attr_reader :size, :table
  def initialize(default_capacity = 11, default_load_factor = 0.9)
    raise ArgumentError, 'Invalid load factor' if default_load_factor <= 0 ||
                                                  default_load_factor >= 1

    @load_factor = default_load_factor
    @table = Array.new(default_capacity)
    @size = 0
    @table_size = 0
    @available = Entry.new
    set_threshold
  end

  def empty?
    @size.zero?
  end

  def clear
    @table.map { |_b| b = nil }
    @size = 0
    @table_size = 0
  end

  def put(key, value)
    raise ArgumentError, 'Both key and value must have a value' if key.nil? ||
                                                                   value.nil?
    if rehash?
      rehash
      return put(key, value)
    else
      array = find_array(key)
      # ya...
      if array.is_a? Numeric
        @table[array] = SubArray.new(key, value)
        @table_size += 1
        @size += 1
      elsif array.full?
        rehash
        return put(key, value)
      elsif array.put(key, value)
        @size += 1
      end
    end
  end

  def remove(key)
    array = find_array(key)
    return nil if array.nil?
    old_value = array.remove(key)
    @size -= 1 if old_value.nil?
    old_value
  end

  def get(key)
    array = find_array(key)
    return nil if array.nil?
    array.get(key)
  end

  def each(&block)
    @table.each do |a|
      unless a.nil?
        if block_given?
          a.each(&block)
        else
          a.each
        end
      end
    end
  end

  def each_key(&block)
    @table.each do |a|
      unless a.nil?
        if block_given?
          a.each_key(&block)
        else
          a.each_key
        end
      end
    end
  end

  def each_value(&block)
    @table.each do |a|
      unless a.nil?
        if block_given?
          a.each_value(&block)
        else
          a.each_value
        end
      end
    end
  end

  def to_s
    puts '{'
    each { |k, v| puts "#{k} => #{v}" }
    puts '}'
  end

  def hash_code(key)
    return key % @table.length if key.is_a? Numeric
    i = 0
    total = 0
    key.each_char do |c|
      total += c.ord * 11**i
      i += 1
    end
    total
  end

  def prime?(n)
    2.upto(n / 2) { |i| return false if (n % i).zero? }
    true
  end

  private

  def rehash?
    @table_size >= @threshold
  end

  def rehash
    old_table = @table
    @table = Array.new(resize)
    set_threshold
    old_table.each do |chain|
      chain.each { |k, v| put(k, v) unless k.nil? } unless chain.nil?
    end
  end

  def resize
    new_size = @table.length * 2
    new_size -= 1 if new_size.even?
    new_size += 2 until prime? new_size
    new_size
  end

  def compress(key)
    hash_code(key).abs % @table.length
  end

  def set_threshold
    @threshold = @table.length * @load_factor
    @threshold -= 1 if @threshold == @table.length + 1
  end

  def find_array(key)
    compressed_value = compress(key)
    return @table[compressed_value] unless @table[compressed_value].nil?
    compressed_value
  end

  #
  class SubArray
    include Enumerable
    attr_reader :full, :filled_before
    attr_reader :array
    def initialize(key = nil, value = nil)
      @array = Array.new(3)
      @full = false
      @array[0] = Entry.new(key, value) unless key.nil?
    end

    def full?
      @full
    end

    def get(key)
      index = get_index(key)
      return nil if index.nil?
      @array[index]
    end

    def put(key, value)
      index = get_available_index(key)
      if @array[index].nil?
        @array[index] = Entry.new(key, value)
        resize unless @array.last.nil?
        true
      else
        @array[index].value = value
        false
      end
    end

    def remove(key)
      index = get_index(key)
      return nil if index.nil?
      old_value = @array[index].value
      @array[index] = nil
      @array[index] = @array[index += 1] until @array[index + 1].nil?
      @array[index] = nil
      @full = false
      old_value
    end

    def get_index(key)
      @array.each_with_index do |e, i|
        return nil if e.nil?
        return i if e.key == key
      end
    end

    def get_available_index(key)
      @array.each_with_index do |e, i|
        return i if e.nil? || e.key == key
      end
    end

    def resize
      # do math to figure out how this should relate to actual hash table
      # and/or pehaps make it a user choice
      case @array.length
      when 1..10
        @array += Array.new(4)
      when 11
        @full = true
      end
    end

    def each
      @array.each do |e|
        if block_given?
          yield(e.key, e.value) unless e.nil?
        else
          yield(e.key, e.value) unless e.nil?
        end
      end
    end

    def each_key
      @array.each do |e|
        if block_given?
          yield(e.key) unless e.nil?
        else
          yield(e.key) unless e.nil?
        end
      end
    end

    def each_value
      @array.each do |e|
        if block_given?
          yield(e.value) unless e.nil?
        else
          yield(e.value) unless e.nil?
        end
      end
    end
  end

  #
  class Entry
    attr_reader :key
    attr_accessor :value
    def initialize(key = nil, value = nil)
      @key = key
      @value = value
    end

    def to_s
      "#{@key} #{@value}"
    end
  end
end
