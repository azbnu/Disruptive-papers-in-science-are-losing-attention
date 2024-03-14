%% This code is used to generate bootstrap citation c5
% Required data: "c5" is the citation c5 of all papers
numElements = length(c5);
meanValues = zeros(1, realization);
for i = 1:realization
    randomIndices = randi(numElements, [1, sample_size]);
    meanValues(i) = mean(c5(randomIndices));
end
[counts, binCenters] = hist(meanValues, 10);
normalizedCounts = counts / sum(counts);
plot(binCenters, normalizedCounts);