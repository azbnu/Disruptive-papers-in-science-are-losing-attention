%% This code is used to calculate the z-score of disruption of the papers cited by scientists who started their career in different years
% required data: variable "d5" recording disruption D5 of all papers
% required data: variable "c5" recording citation C5 of all papers
% required data: variable "kout" recording the number of references of all papers
% required data: variable "year" recording the publication year of all papers
% required data: variable "start" recording the career starting year of all scientists

clear zscore
positiveKout = find(kout > 0);
positiveC5 = find(c5 > 0);
validIndices = intersect(positiveKout, positiveC5);
for year = min(year):max(year)
    disp(year);
    yearIndices = find(year == year);
    validYearIndices = intersect(yearIndices, validIndices);
    average = mean(d5_Fig2(validYearIndices));
    standardDeviation = std(d5(validYearIndices));
    zscore(validYearIndices) = (d5(validYearIndices) - average) ./ standardDeviation;
end
transformedData = A * B(:, validIndices) * zscore(validIndices)';
totalWeight = sum((A * B(:, validIndices))');
validWeights = find(totalWeight > 0);
meanData = transformedData(validWeights) ./ totalWeight(validWeights)';
clear variables
dataPoint = 1;
for year = 1950:2010
    yearStartIndices = find(start == year);
    if ~isempty(yearStartIndices)
        years(dataPoint) = year;
        means(dataPoint) = mean(meanData(yearStartIndices));
        standardErrors(dataPoint) = std(meanData(yearStartIndices)) ./ sqrt(length(yearStartIndices));
        dataPoint = dataPoint + 1;
    end
end
interval = 5;
summaryPoint = 1;
for index = 1:interval:length(years)
    if index + interval - 1 <= length(years)
        intervalYears(summaryPoint) = mean(years(index:index + interval - 1));
        intervalMeans(summaryPoint) = mean(means(index:index + interval - 1));
        intervalSE(summaryPoint) = std(means(index:index + interval - 1));
        summaryPoint = summaryPoint + 1;
    end
end
hold on
errorbar(intervalYears, intervalMeans, intervalSE)