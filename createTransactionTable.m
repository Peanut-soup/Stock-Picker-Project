function transTable = createTransactionTable(dates, tickers, buyDates, sellDates)
    transTable = table('Size', [0 5], 'VariableTypes',{'datetime','categorical','categorical','categorical','double'},'VariableNames',{'Timestamp', 'EmailAddress', 'Ticker', 'Type', 'Shares'});

%My next change is here where I changed the stocks bought and sold from ten
%to five.

    for stockrow = 1:numel(buyDates)
        buyidxs = buyDates{stockrow};
        for ii = 1:numel(buyidxs)
            dateidx = buyidxs(ii);
            transTable = [transTable; {dates(stockrow,dateidx), 'trscoppetto@students.natickps.org', tickers(stockrow),'Buy', 5}];
        end
        sellidxs = sellDates{stockrow};
        for ii = 1:numel(sellidxs)
            dateidx = sellidxs(ii);
            transTable = [transTable; {dates(stockrow,dateidx), 'trscoppetto@students.natickps.org', tickers(stockrow),'Sell',5}];
        end
    end

    transTable.Timestamp = datestr(transTable.Timestamp,'mm/dd/yyyy hh:MM:ss');
    transTable = sortrows(transTable,"Timestamp");
end