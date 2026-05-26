function [buyDates, sellDates, graphs] = findTransactionDates(tickers, stockCloses, makeGraphs)
    numStocks = numel(tickers);
    shortEMA = calcEMA(stockCloses,12);
    longEMA = calcEMA(stockCloses,26);

    MACD = shortEMA - longEMA;

    signal = calcEMA(MACD,9);

    MACDHistograms = MACD - signal;

    buySignals = false(numStocks,width(MACDHistograms));
    sellSignals = false(numStocks,width(MACDHistograms));

% this is my first change. I changed MACDNeg to when the slope of the
% stocks themselves are negative and I changed MACDPos to when the slope of
% the stocks themselves are posotive.

    MACDNeg = gradient(stockCloses) < 0;
    MACDPos = gradient(stockCloses) > 0;

    buySignals(:,2:end) = MACDNeg(:,1:end-1) & MACDPos(:, 2:end);
    sellSignals(:,2:end) = MACDPos(:,1:end-1) & MACDNeg(:, 2:end);

    buyDates = cell(1,numStocks);
    sellDates = cell(1,numStocks);
    for ii = 1:numStocks
            buyDates{ii} = find(buySignals(ii,:));
            sellDates{ii} = find(sellSignals(ii,:));
    end

    if makeGraphs==true
        graphs = zeros(1, numStocks);

        for ss = 1:numStocks
            graphs(ss) = figure('Visible','off');
            plot(stockCloses(ss,:));
            title(tickers(ss));
            hold on;
            plot(shortEMA(ss,:));
            plot(longEMA(ss,:));

            yyaxis right;
            bar(MACDHistograms(ss,:),'FaceAlpha', 0.0);

            for cc = 1:width(buySignals)
               if buySignals(ss,cc) == 1
                   xline(cc, '--g', 'LineWidth', 1);
               end
               if sellSignals(ss,cc) == 1
                   xline(cc, '--r', 'LineWidth', 1);
               end
    
            end
            legend('Close', 'EMA12','EMA26','Hist','Location','southwest');
            hold off
        end
    else
        graphs = [];
    end

end