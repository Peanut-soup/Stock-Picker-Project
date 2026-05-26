function [tickers, dates, stockCloses] = extractData(priceHistory)

    stockTable = struct2table(priceHistory); 

    tickers = categorical(string(stockTable.Ticker));

    dates = [stockTable.Date{:,:}]';
    numStocks = numel(tickers);
    numDates = width(dates);

    stockCloses = zeros(numStocks,numDates);
    for ii = 1:numStocks
        stockCloses(ii,:) = stockTable{ii,"AdjClose"}{1,1}';
    end
end