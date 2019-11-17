# Very basic CLI to interact with the program

require_relative 'stocks'

while true do
    puts "Enter the relative path of the file in which the stock data is held"
    filename = gets.chomp
    if !FileTest.exist?(filename)
        puts "Please enter a valid relative path for the file"
    else
        break
    end
end
puts

input = 0
while input != 5 do
    puts "Enter 1 to get the percentage difference from close of trading to close of trading each week for each stock"
    puts "Enter 2 to get the pattern of BUY/SELL/HOLD to maximize profit"
    puts "Enter 3 to get the stock data of a particular stock"
    puts "Enter 4 to get the stock data of a particular stock at a given date"
    puts "Enter 5 to exit out of the program"
    puts
    input = gets.chomp.to_i
    if input == 1
        stocks = Stocks.new(filename)
        stocks.computeClosingPriceDifference()
    elsif input == 2
        stocks = Stocks.new(filename)
        stocks.computeBuySellToMaximizeProfit()
    elsif input == 3
        puts "Enter the name of the stock"
        stock = gets.chomp
        puts
        stocks = Stocks.new(filename)
        stocks.getStockData(stock)
    elsif input == 4
        puts "Enter the name of the stock"
        stock = gets.chomp
        puts "Enter the date in the following format - M/DD/YYYY"
        date = gets.chomp
        puts
        stocks = Stocks.new(filename)
        puts stocks.getStockDataOnSpecificDate(stock, date)
    elsif input == 5
        break
    else
        puts "Please enter a valid input"
        puts
        next
    end
    puts
end