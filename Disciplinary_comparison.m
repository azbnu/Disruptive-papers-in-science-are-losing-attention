 %% This code is used for disciplinary comparison of the correlation between disruption and citation
% required data: variable "d5" recording disruption D5 of all papers
% required data: variable "c5" recording citation C5 of all papers
% required data: variable "year" recording the publication year of all papers
% required data: variable "discipline" recording the discipline id for all papers

xtmp = setdiff(1:19, [1,6,12,16,19]);
x = [xtmp, 1, 6, 12, 16, 19];
positiveC5 = find(c5 > 0);
for i = 1:max(discipline)
    disp(i);
    currentDisciplineIndices = find(discipline == x(i));
    relevantIndices = intersect(positiveC5, currentDisciplineIndices);
    earlyPeriod = find(year <= 1960);
    earlyIndices = intersect(earlyPeriod, relevantIndices);
    latePeriod = find(year >= 2000);
    lateIndices = intersect(latePeriod, relevantIndices);
    result1 = corr(c5(earlyIndices), d5(earlyIndices), 'type', 'Spearman');
    result2 = corr(c5(lateIndices), d5(lateIndices), 'type', 'Spearman');
    hold on
    plot([1 + (i - 1) * 3, 2 + (i - 1) * 3], [result1, result2])
end

for i = 1:max(discipline)
    disp(i);
    currentDisciplineIndices = find(discipline == x(i));
    earlyPeriod = find(year <= 1960);
    earlyIndices = intersect(earlyPeriod, currentDisciplineIndices);
    latePeriod = find(year >= 2000);
    lateIndices = intersect(latePeriod, currentDisciplineIndices);
    positiveEarlyD5 = find(d5(earlyIndices) > 0);
    ratio1 = mean(c5(earlyIndices(positiveEarlyD5))) ./ mean(c5(earlyIndices));
    positiveLateD5 = find(d5(lateIndices) > 0);
    ratio2 = mean(c5(lateIndices(positiveLateD5))) ./ mean(c5(lateIndices));
    hold on
    plot([1 + (i - 1) * 3, 2 + (i - 1) * 3], [ratio1, ratio2])
end