%% computing the correlation between disruption and news (or tweets)
% required data: variable "news" recording the number of news for each paper
% required data: variable "disruption" recording D5 for each paper
% required data: variable "year" recording the publication year for each paper
dataPointIndex = 1;
positiveNewsIndices = find(news > 0);
clear yearCorrelations newsCounts

for currentYear = 1950:2011
    disp(currentYear);
    currentYearIndices = find(year == currentYear);
    relevantIndices = intersect(currentYearIndices, positiveNewsIndices);
    
    if length(relevantIndices) > 0
        yearCorrelations(dataPointIndex) = currentYear;
        spearmanCorr = corr(disruption(relevantIndices), news(relevantIndices), 'type', 'Spearman');
        newsCorrelations(dataPointIndex) = spearmanCorr;
        newsCounts(dataPointIndex) = length(relevantIndices);
        dataPointIndex = dataPointIndex + 1;
    end
end

hold on;
plot(yearCorrelations, newsCorrelations);