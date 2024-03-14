 %% The code is used to compute relative citation c5
% required data: variable "d5" recording disruption D5 of all papers
% required data: variable "c5" recording citation C5 of all papers
% required data: variable "kout" recording the number of references of all papers
% required data: variable "year" recording the publication year of all papers

clear allVariables
positiveC5 = find(c5 > 0);
positiveKout = find(kout > 0);
validIndices = intersect(positiveC5, positiveKout);

hNegative = 1; hPositive = 1; hAll = 1;
for yearIndex = 1950:2010
    currentYearIndices = find(year == yearIndex);
    validYearIndices = intersect(currentYearIndices, validIndices);
    
    negativeD5Indices = find(d5 < 0);
    validNegativeIndices = intersect(negativeD5Indices, validYearIndices);
    if ~isempty(validNegativeIndices)
        xNegative(hNegative) = yearIndex;
        yNegative(hNegative) = mean(c5(validNegativeIndices));
        zNegative(hNegative) = std(c5(validNegativeIndices)) / sqrt(length(validNegativeIndices));
        hNegative = hNegative + 1;
    end
    
    positiveD5Indices = find(d5 > 0);
    validPositiveIndices = intersect(positiveD5Indices, validYearIndices);
    if ~isempty(validPositiveIndices)
        xPositive(hPositive) = yearIndex;
        yPositive(hPositive) = mean(c5(validPositiveIndices));
        zPositive(hPositive) = std(c5(validPositiveIndices)) / sqrt(length(validPositiveIndices));
        hPositive = hPositive + 1;
    end
    
    if ~isempty(validYearIndices)
        xAll(hAll) = yearIndex;
        yAll(hAll) = mean(c5(validYearIndices));
        zAll(hAll) = std(c5(validYearIndices)) / sqrt(length(validYearIndices));
        hAll = hAll + 1;
    end
end

hold on
ratioNegative = yNegative ./ yAll;
ratioPositive = yPositive ./ yAll;

interval = 5; hMean = 1;
for index = 1:interval:length(xAll)
    if index + interval - 1 < length(xAll)
        xMean(hMean) = mean(xAll(index:index + interval - 1));
        yMeanNegative(hMean) = mean(ratioNegative(index:index + interval - 1));
        zMeanNegative(hMean) = std(ratioNegative(index:index + interval - 1));
        yMeanPositive(hMean) = mean(ratioPositive(index:index + interval - 1));
        zMeanPositive(hMean) = std(ratioPositive(index:index + interval - 1));
        hMean = hMean + 1;
    end
end

errorbar(xMean, yMeanNegative, zMeanNegative)
errorbar(xMean, yMeanPositive, zMeanPositive)