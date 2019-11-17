# Report

Some of my design choices for the tool and the algorithm used to predict the maximum profit:

### Approach to store the data from the CSV:

I have chosen a nested hash to store the CSV data. The keys for the hash are the different stocks available,
and each key has an array containing hashes that store the actual data. In these hashes, there are two keys:
date and the closing price of that stock.

### Algorithm to maximize the profit:

For every week, I check the differences in the closing prices for each stock and make a decision to either
buy/sell/hold a stock on the highest price difference

- If the stock that I have right now has the highest positive difference - HOLD
- If a new stock has a higher positive difference - SELL current stock and BUY the new stock
  The time complexity of this algorithm is O(w\*s) time, where w = number of weeks and s = number of stocks

The final output for the BUY/SELL sequence has been displayed to the user directly.
However, an array of hashes can be created to store the most profitable stock corresponding to every week
and hence could be used to find the most profitable stock given a specific week.
I think this depends on the problem description and for this case, it was sufficient to just display the optimum
output to the user.

I have created a class called "Stocks" that captures some characteristics of the stocks given as per
the problem description. The class variables store the data, stocks concerned with the data and the dates when the
stock prices are available.
