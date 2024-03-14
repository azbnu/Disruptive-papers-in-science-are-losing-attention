 %% This code is used to compute the number of papers published per year
 %% and the number of papers cited by scientists in their first ten career years
 % required data: variable "year" recording the publication year of all papers
 % required data: variable "authorship" recording the edgelist of authorid and paperid
 % required data: variable "start_all" recording the career start year of all scientists

num = tabulate(year);
plot(num(:,1), num(:,2));

timespan = 10;
start = start_all(authorship(:,1));
pubyear = year(authorship(:,2));
difference = pubyear - start';
selectedIndices = find(difference <= timespan);
Ax = sparse(authorship(selectedIndices,1), authorship(selectedIndices,2), 1);
Ax(N,M) = 0;
highKpIndices = find(kp > 10);
Ax(:, highKpIndices) = 0;
interactionMatrix = sign(Ax * B);
aout2 = sum(interactionMatrix');
highKaIndices = find(ka >= 10);
num = tabulate(aout2(highKaIndices));
hold on
plot(num(2:end,1), num(2:end,3) / 100)

x2 = num(2:end,1);
y2 = num(2:end,3) / 100;
p = polyfit(x2, log(y2), 1);
hold on
plot([x2(1), x2(end)], [exp(p(2) + p(1) * x2(1)), exp(p(2) + p(1) * x2(end))])