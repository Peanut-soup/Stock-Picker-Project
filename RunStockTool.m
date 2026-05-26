if ~exist("priceHistory", 'var')
    priceHistory = hist_stock_data('01012024',now,'NASDAQ100.txt');
    tickers = categorical(string({priceHistory.Ticker}));
end

if ~exist('graphs','var')
    [tt, graphs] = MakeMoney(priceHistory,true);
else
    tt = MakeMoney(priceHistory,false);
end
writetable(tt,'TStransactions.csv', "WriteVariableNames",false);
processTransactions("players - players.csv",priceHistory,"TStransactions.csv")
figure(graphs(tickers=="NVDA"));