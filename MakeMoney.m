function [transTable, graphs] = MakeMoney(priceHistory, makeGraph) 

    [tickers, dates, stockCloses] = extractData(priceHistory);
    [buyDates, sellDates, graphs] = findTransactionDates(tickers, stockCloses, makeGraph);
    transTable = createTransactionTable(dates, tickers, buyDates, sellDates);

end