%% This code is used to generate randomized surrogate data
% Required data: "year", "c5", "d5" record the publication year, citation c5, disruption d5 of all the papers, respectively.

r = rand(1, length(year));
[num1, num2] = sort(r, 'descend');
randomizedYear = year(num2);
real = []; 
surrogate = [];
for t = 1950:2010
    id = find(year == t);
    real(end + 1) = corr(c5(id), d5(id));
    id2 = find(randomizedYear == t);
    surrogate(end + 1) = corr(c5(id2), d5(id2));
end