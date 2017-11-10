require 'pry'
require 'colorize'

class Order

  attr_accessor :items, :price, :calories

  def initialize()
    @items = []
    @price = 0
    @calories = 0
    welcome()
  end

  def welcome()
    puts "===== WELCOME TO THE DEVPOINT DINER =====".colorize(:blue)
    puts "Hiya there, sugar! What's your name?"
    name = gets.strip
    puts "What can I get for ya, #{name}?"
    init_main_dishes
  end

  def init_main_dishes
    while true
      puts "===== Main Dishes =====".colorize(:blue)

      main_dishes = [
        {item: "Cheeseburger", price: 3.99, calories: 450},
        {item: "Tacos", price: 2.99, calories: 350}
      ]

      main_dishes.each_with_index { |hash, i| puts "[#{i + 1}] #{hash[:item].colorize(:red)} $#{hash[:price].to_s.colorize(:yellow)}" }

      puts "Choose Your Main Dish:"
      print "> "
      choice = gets.strip

      if choice.to_i === 1 || choice.include?("burger")
        @main_dish = MainDish.new("Cheeseburger", 3.99, 450)
        puts "Cheeseburger coming up!"
      elsif choice.to_i === 2 || choice.include?("taco")
        @main_dish = MainDish.new("Taco", 2.99, 350)
        puts "Taco train!"
      else
        puts "Not on the menu today!"
        init_main_dishes
      end

      @main_item = @main_dish.instance_variable_get(:@item)
      @main_price = @main_dish.instance_variable_get(:@price)
      @main_cal = @main_dish.instance_variable_get(:@calories)

      @items << @main_item
      @price += @main_price
      @calories += @main_cal

      puts "So do ya want anything else?\n[1] Yes\n[2] No"
      action = gets.strip.to_i

      if action === 1
        init_main_dishes
      else
        init_side_dishes
      end

    end
  end

  def init_side_dishes

    while true

      puts "===== Side Dishes =====".colorize(:blue)

      side_dishes = [
        {item: "Frites", price: 1.99, calories: 450},
        {item: "Fruit", price: 1.49, calories: 99}
      ]

      side_dishes.each_with_index { |hash, i| puts "[#{i + 1}] #{hash[:item].colorize(:red)} $#{hash[:price].to_s.colorize(:yellow)}" }

      puts "Choose Your Side Dish:"
      print "> "
      choice = gets.strip

      if choice.to_i === 1 || choice.include?("frites")
        @side_dish = MainDish.new("Frites", 1.99, 450)
        puts "What are frites, anyway?"
      elsif choice.to_i === 2 || choice.include?("fruit")
        @side_dish = MainDish.new("Fruit", 1.49, 99)
        puts "Fruit, healthy choice!"
      else
        puts "Fresh out!"
        init_side_dishes
      end

      @side_item = @side_dish.instance_variable_get(:@item)
      @side_price = @side_dish.instance_variable_get(:@price)
      @side_cal = @side_dish.instance_variable_get(:@calories)

      @items << @side_item
      @price += @side_price
      @calories += @side_cal

      puts "So do ya want anything else?\n[1] Yes\n[2] No"
      action = gets.strip.to_i

      if action === 1
        init_side_dishes
      else
        init_dessert
      end

    end
  end

  def init_dessert

    while true

      puts "===== Desert =====".colorize(:blue)

      dessert = [
        {item: "Lava Cake", price: 3.49, calories: 750},
        {item: "Tiramasu", price: 4.99, calories: 600}
      ]

      dessert.each_with_index { |hash, i| puts "[#{i + 1}] #{hash[:item].colorize(:red)} $#{hash[:price].to_s.colorize(:yellow)}" }

      puts "Choose Your Dessert:"
      print "> "
      choice = gets.strip

      if choice.to_i === 1 || choice.include?("cake")
        @dessert = MainDish.new("Lava Cake", 3.49, 750)
        puts "Lava Cake!"
      elsif choice.to_i === 2 || choice.include?("tiramasu")
        @dessert = MainDish.new("Tiramasu", 4.99, 600)
        puts "Tiramasu! Good choice!"
      else
        puts "Wow! Our selection is really limited, huh?"
        init_dessert
      end

      @dessert_item = @dessert.instance_variable_get(:@item)
      @dessert_price = @dessert.instance_variable_get(:@price)
      @dessert_cal = @dessert.instance_variable_get(:@calories)

      @items << @dessert_item
      @price += @dessert_price
      @calories += @dessert_cal

      puts "So do ya want anything else?\n[1] Yes\n[2] No"
      action = gets.strip.to_i
      if action === 1
        init_dessert
      else
        get_total_bill
      end

    end
  end

  def get_total_bill()

    counts = Hash.new 0

    items.each { |word| counts[word] += 1 }

    puts "===== Your Bill =====".colorize(:blue)

    puts "So that'll be..."

    items.uniq.each { |item| puts "#{counts[item]} #{item}" }

    puts "Your total comes to $#{@price.round(2)} and that'll be about #{@calories} calories, but who's counting!?"

    puts "You ate that fast! Want to make another order?\n[1] Yes\n[2] No"
    choice = gets.strip.to_i

    return choice == 1 ? new_order = Order.new() : exit(0)

  end

end

class MenuItems

  attr_accessor :name, :price, :calories

  def initialize(item, price, calories)
    @item = item
    @price = price
    @calories = calories
  end

end

class MainDish < MenuItems
  def initialize(item, price, calories)
    super(item, price, calories)
  end

end

class SideDish < MenuItems
  def initialize(item, price, calories)
    super(item, price, calories)
  end
end

class Dessert < MenuItems
  def initialize(item, price, calories)
    super(item, price, calories)
  end
end

new_order = Order.new()
