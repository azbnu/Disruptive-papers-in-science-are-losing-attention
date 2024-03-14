%% comparing the citation c5 of papers with novel reference combination and papers with conventional reference combination
% required data: variable "aty_median" records the atypical combination median score for all papers
% required data: variable "c5" recording citation C5 of all papers
% required data: variable "year" recording the publication year of all papers
 
h = 1;
for t = 1950:2011
    disp(t);
    yearIndices = find(year == t);
    novelIndices = find(aty_median(yearIndices) < 0);
    conventionalIndices = find(aty_median(yearIndices) > 0);
    x(h) = t;
    y(h) = mean(c5(yearIndices(novelIndices)));
    z(h) = std(c5(yearIndices(novelIndices))) ./ sqrt(length(novelIndices));
    yy(h) = mean(c5(yearIndices(conventionalIndices)));
    zz(h) = std(c5(yearIndices(conventionalIndices))) ./ sqrt(length(conventionalIndices));
    h = h + 1;
end
hold on
plot(x, y)
hold on
plot(x, yy)