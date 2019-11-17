# Investment Strategy Tool

- This tool helps the user to develop a strategy to buy/sell a stock every week for a given duration of time in order to maximize the profit
- It takes values from a CSV that contains the name of the stock, date, opening, high, low and closing prices for the stock and the volume
- It can calculate the the percentage difference from close of trading to close of trading each week
- It can also be used to get the closing price of a stock in a given week
- The CSV used for the program is named "stock_prices_1Q_2011" and is located in the root directory
- The file contains a total of 30 stocks and has the stock data for the first quarter of the year 2011

## Run the application:

To run it using a basic CLI

```
ruby run.rb
```

Enter a relative path for the CSV file when prompted

## Run the tests:

```
cd tests
ruby test.rb
```
