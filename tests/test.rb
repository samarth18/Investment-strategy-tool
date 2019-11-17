# Some basic unit tests for the Stocks class

require_relative '../stocks.rb'
require 'test/unit'

class StocksTest < Test::Unit::TestCase
    def test_objectCreatedSuccessfully
        filename = '../stock_prices_test.csv'
        stockData = Stocks.new(filename)
        assert(stockData.data.size == 4)
        assert(stockData.stocks === ["AA", "AB", "AC", "AD"])
        assert(stockData.days === ["1/7/2011", "1/14/2011", "1/21/2011", "1/28/2011"])
    end
    def test_parseData
        filename = '../stock_prices_test.csv'
        stockData = Stocks.new(filename)
        assert(stockData.data.size == 4)
    end

    def test_getPercentageDifference
        filename = '../stock_prices_test.csv'
        stockData = Stocks.new(filename)
        result = stockData.getPercentageDifference(10.15,20.92)
        assert(result == 106.10837438423646)
    end

    def test_getPercentageDifferenceWhenDenominatorZero
        filename = '../stock_prices_test.csv'
        stockData = Stocks.new(filename)
        result = stockData.getPercentageDifference(0,20.92)
        assert(result == 0)
    end

    def test_getMostProfitableStock
        filename = '../stock_prices_test.csv'
        stockData = Stocks.new(filename)
        weeklyDifferences = []
        stockData.data.each do |key, value|
            stockDifferences = {}
            stockDifferences[:stock] = key
            stockDifferences[:difference] = (value[1][:close].to_f - value[0][:close].to_f).round(5)
            weeklyDifferences << stockDifferences
        end
        result = stockData.getMostProfitableStock(weeklyDifferences)
        assert(result == "AD")
    end

    def test_getStockPriceOnGivenDate
        filename = '../stock_prices_test.csv'
        stockData = Stocks.new(filename)
        assert(stockData.getStockDataOnSpecificDate("AA", "1/21/2011") == "Closing stock price for AA on 1/21/2011 is 15.00")
    end

    def test_invalidStockForGettingData
        filename = '../stock_prices_test.csv'
        stockData = Stocks.new(filename)
        assert(stockData.getStockDataOnSpecificDate("AAB", "1/21/2011") == "Invalid stock entered")
    end

    def test_invalidDateForGettingData
        filename = '../stock_prices_test.csv'
        stockData = Stocks.new(filename)
        assert(stockData.getStockDataOnSpecificDate("AA", "1-21-2011") == "Invalid date entered")
    end
end
