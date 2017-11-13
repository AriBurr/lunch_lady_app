require 'pry'
require 'colorize'

class Order

  attr_accessor :order

  def initialize()
    @order = self
    @bill = Bill.new(@order)

    @main_dishes = [
      Dish.new('Pizza', 5.49, 500),
      Dish.new('Chicken', 4.49, 300),
      Dish.new('Soup', 3.49, 200),
      Dish.new('Burger', 6.49, 700)
    ]

    @side_dishes = [
      Dish.new('Fries', 2.49, 450),
      Dish.new('Fruit', 1.49, 100),
      Dish.new('Coleslaw', 2.49, 350),
    ]

    @dessert = [
      Dish.new('Pie', 2.49, 650),
      Dish.new('Cake', 2.49, 750),
    ]

    @list_items = Proc.new { |dish, i| puts "[#{i + 1}] #{dish.item} | $#{dish.price} | #{dish.calories} calories" }

    welcome()

  end

  def welcome()
    puts "===== WELCOME TO THE DEVPOINT DINER =====".cyan
    puts "Hiya there, sugar! What's your name?".yellow
    name = gets.strip
    puts "What can I get for ya, #{name}?".yellow
    init_main_dishes
  end

  def init_main_dishes

    while true

      puts "Press [1] to select a main dish or press [2] to continue".red
      print "> "
      action = gets.to_i
      case action
        when 1
          puts "===============".cyan
          puts "| Main Dishes |".cyan
          puts "===============".cyan
          @main_dishes.each_with_index(&@list_items)
          puts "Please select your main dish".red
          print "> "
          item_num = gets.to_i
          puts "You have added #{@main_dishes[item_num - 1].item} to your bill".yellow
          @bill.add_to_bill(@main_dishes[item_num - 1])
        when 2
          init_side_dishes()
        else
          puts "Invalid input -- please try again!"
      end

    end

  end

  def init_side_dishes

    while true

      puts "Press [1] to select a side dish or press [2] to continue".red
      print "> "
      action = gets.to_i
      case action
        when 1
          puts "===============".cyan
          puts "| Side Dishes |".cyan
          puts "===============".cyan
          @side_dishes.each_with_index(&@list_items)
          puts "Please select your side dish".red
          print "> "
          item_num = gets.to_i
          puts "You have added #{@side_dishes[item_num - 1].item} to your bill".yellow
          @bill.add_to_bill(@side_dishes[item_num - 1])
        when 2
          init_dessert()
        else
          puts "Invalid input -- please try again!"
      end

    end

  end

  def init_dessert

    while true

      puts "Press [1] to select a dessert or press [2] to continue".red
      print "> "
      action = gets.to_i
      case action
        when 1
          puts "===========".cyan
          puts "| Dessert |".cyan
          puts "===========".cyan
          @dessert.each_with_index(&@list_items)
          puts "Please select your dessert".red
          print "> "
          item_num = gets.to_i
          puts "You have added #{@dessert[item_num - 1].item} to your bill".yellow
          @bill.add_to_bill(@dessert[item_num - 1])
        when 2
          @bill.get_final_bill()
        else
          puts "Invalid input -- please try again!"
      end

    end

  end

end

class Dish

  attr_accessor :item, :price, :calories

  def initialize(item, price, calories)
    @item = item
    @price = price
    @calories = calories
  end

end

class Bill

  attr_accessor :bill

  def initialize(order)
    @order = order
    @bill = []
  end

  def add_to_bill(item)
    @bill << item
  end

  def get_final_bill

    puts "===================".cyan
    puts "| Your Final Bill |".cyan
    puts "===================".cyan

    @bill.each { |dish| puts "* #{dish.item} | $#{dish.price} | #{dish.calories} calories" }

    puts "This look good to you?\n[1] Yes\n[2] No".red
    action = gets.to_i

    if action === 1

      items = []
      total_price = 0
      total_calories = 0

      @bill.each do |dish|
        items << dish.item
        total_price += dish.price
        total_calories += dish.calories
      end

      count = Hash.new 0
      items.each { |word| count[word] += 1 }

      puts "So that'll be...".yellow
      items.uniq.each { |item| puts "#{count[item]} #{item}" }
      puts "and your total is...$#{total_price.round(2)} and #{total_calories} calories, but who's counting?!".yellow

      exit(0)

    elsif action === 2
      revise_bill()
    else
      puts "Invalid input -- please try again!"
    end

  end

  def revise_bill()
    puts "What do you want to do?\n[1] Add\n[2] Remove\n[3] Nevermind".red
    revise_action = gets.to_i
    if revise_action === 1
      puts "What would you like to add?\n[1] Main dish\n[2] Side dish\n[3] Dessert".red
      add_action = gets.to_i
      case add_action
        when 1
          binding.pry
          @order.init_main_dishes()
        when 2
          @order.init_side_dishes()
        when 3
          @order.init_dessert()
        else
          puts "Invalid input -- please try again!"
      end
    elsif revise_action === 2
      @bill.each_with_index(&@list_items)
      puts "Select item number you'd like to remove:".red
      item_num = gets.to_i
      @bill.delete_at(item_num - 1)
      get_final_bill()
    else
      get_final_bill()
    end

  end

end

Order.new()
