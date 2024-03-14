%% The code is used to calculate the evolution of the correlation between disruption D5 and citation C5
% required data: variable "d5" recording disruption D5 of all papers
% required data: variable "c5" recording citation C5 of all papers
% required data: variable "kout" recording the number of references of all papers
% required data: variable "year" recording the publication year of all papers

positiveC5Indices = find(c5 > 0);
positiveKoutIndices = find(kout > 0);
validIndices = intersect(positiveC5Indices, positiveKoutIndices);

h = 1;
for i = 1950:2010
    yearIndices = find(year == i);
    validYearIndices = intersect(yearIndices, validIndices);
    if ~isempty(validYearIndices)
        x(h) = i;
        y(h) = corr(c5(validYearIndices)', d5(validYearIndices)', 'type', 'Pearson');
        h = h + 1;
    end
end

interval = 5;
h = 1;
for i = 1:interval:numel(x)
    if i + interval - 1 <= numel(x)
        xx(h) = mean(x(i:i + interval - 1));
        yy(h) = mean(y(i:i + interval - 1));
        zz(h) = std(y(i:i + interval - 1));
        h = h + 1;
    end
end

hold on
errorbar(xx, yy, zz)