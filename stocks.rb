require 'csv'

=begin
The Stocks class contains methods to get the percentage difference corresponding to each stock during
each week, find the buy/sell pattern to attain maximum profit, get the data of a stock and get the data
of a particular stock on a particular date.

The class contains instance variables to hold the stock data, the stocks concerning the data and the 
days on which the data for the stocks is available.
=end

class Stocks
    attr_accessor :data, :stocks, :days # Instance variables

    # Method to initialize the instance variables
    def initialize(filename)
        @data = CSV.read(filename, :headers => true, header_converters: :symbol, converters: :all)
        @stocks = []
        @days  = []
        self.parseData()  # To initialize stocks, days and parse the data from the file
    end

    # The data is stored as a nested hash where the key is the name of the stock and value is an array of hashes containing the stock data
    def parseData()
        stockData = Hash.new # Desired hash containing the data
        stock = @data[:stock][0]
        @data.each do |row|
            row[:close] = row[:close].to_s.sub('$','') # Remove the dollar sign from closing price
            closeData = {}
            stock = row[:stock]
            if !stockData.key?(stock) # Checks if the key already exists
                stockData[stock] = []
            end
            closeData[:date] = row[:date]
            closeData[:close] = row[:close]
            stockData[stock] << closeData           # Pushes data to the final resultant hash
            if !@days.include?(row[:date].to_s) 
                @days << row[:date].to_s       # Populates days array if date not already present
            end
            if !@stocks.include?(row[:stock].to_s)
                @stocks << row[:stock].to_s         # Populates stocks array if stock not already present
            end
        end
        @data = stockData
    end

    # Returns all the data corresponding to the passed stock variable
    def getStockData(stock)
        stock = stock.upcase
        if !@stocks.include?(stock)         # Checks if stock exists
            puts "Invalid stock entered"
            return
        end
        @data.each do |key, value|
            if key.to_s == stock.to_s           # If match is found for that stock
                puts "Stock data for #{stock}:"
                value.each_with_index do |curr, i|
                    weekData = {}
                    weekData[:date] = curr[:date]
                    weekData[:price] = curr[:close]
                    puts "#{weekData[:date]} - #{weekData[:price]}"
                end
                break
            end
        end
    end

    # Returns the closing stock price for a stock on a specified date
    def getStockDataOnSpecificDate(stock, date)
        stock = stock.upcase
        if !@stocks.include?(stock)             # Checks if stock exists
            return "Invalid stock entered"
        elsif !@days.include?(date)             # Checks if date exists
            return "Invalid date entered"
        end
        @data.each do |key, value|
            if key.to_s == stock.to_s
                value.each_with_index do |curr, i|
                    if curr[:date].to_s == date         # If match is found for that date for the stock
                        return "Closing stock price for #{stock} on #{date} is #{curr[:close]}"
                        break
                    end
                end
                break
            end
        end
    end

    # Returns the percentage difference between two values
    def getPercentageDifference(value1, value2)
        if value1 == 0
            return 0
        end
        result = ((value2 - value1)/value1)*100
        result
    end

    # Calculates the the percentage difference from close of trading to close of trading each week and prints the output
    def computeClosingPriceDifference()
        @data.each do |key, value|
            value.each_with_index do |curr, i|
                curr[:percentageDifference] = i == 0 ? 0.0 : getPercentageDifference(value[i-1][:close].to_f, curr[:close].to_f).round(5)
                puts "#{curr[:date].to_s} #{key.to_s} #{curr[:percentageDifference].to_s}" 
            end
        end
    end

    # Finds the most profitable stock by comparing the price differences (between week[i+1] and week[i]) of each stock 
    def getMostProfitableStock(weeklyValues)
        max = -1.0/0.0 
        mostProfitableStock = ""
        weeklyValues.each do |row|      # Traverses through array of hashes to find maximum value
            if row[:difference] > max
                max = row[:difference]
                mostProfitableStock = row[:stock]
            end
        end
        mostProfitableStock
    end

    # Computes and prints the sequence in which stocks should be bought/sold/hold to maximize profit
    def computeBuySellToMaximizeProfit()
        currentStock = ""
        i = 0 # Loop counter
        while i < @days.size do # Traverse the data for each date to find price differences
            if i == @days.size - 1 # For the final week
                puts "#{@days[i]} SELL #{currentStock}"
                break
            end
            weeklyDifferences = [] # Stores the price differences between closing prices for all stocks in a particular week
            @data.each_with_index do |(key, value), index| # Traverse the data corresponding to current date for each key (stock)
                stockDifferences = {} # Stores the price difference between closing prices for a stock in a particular week
                stockDifferences[:stock] = key
                stockDifferences[:difference] = (value[i+1][:close].to_f - value[i][:close].to_f).round(5) # value[i+1] represents the next date for the stock data
                weeklyDifferences << stockDifferences
            end
            mostProfitableStock = getMostProfitableStock(weeklyDifferences)
            if i == 0 # For week 1
                puts "#{@days[i]} BUY #{mostProfitableStock}"
                currentStock = mostProfitableStock
            elsif mostProfitableStock == currentStock # If the stock already bought is more profitable
                puts "#{@days[i]} HOLD #{mostProfitableStock}"
            else
                puts "#{@days[i]} SELL #{currentStock}, BUY #{mostProfitableStock}"
                currentStock = mostProfitableStock  
            end
            i = i + 1
        end
    end
end



