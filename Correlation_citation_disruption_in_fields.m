%% This code is used to compute the correlation between citation and disruption in fields of different sizes
% required data: variable "paperid_pacs4bit" recording the pacs id for each paper
% required data: variable "d5" recording disruption D5 of all papers
% required data: variable "c5" recording citation C5 of all papers
% required data: variable "kout" recording the number of references of all papers

pacs = paperid_pacs4bit;
pacs(:,1) = pacs(:,1) + 1;
net = sparse(pacs(:,1), pacs(:,2), 1);
net = sign(net);
kn = sum(net);

positiveC5 = find(c5 > 0);
positiveKout = find(kout > 0);
validIndices = intersect(positiveC5, positiveKout);

h = 1;
for i = 1:length(kn)
    id = find(net(:,i) == 1);
    id = intersect(id, validIndices);
    if length(id) >= 10
        x1(h) = length(id);
        y1(h) = mean(c5(id));
        [num1, num2] = sort(d5(id), 'ascend');
        y2(h) = mean(c5(id(num2(1:round(0.5 * length(num2))))));
        [num3, num4] = sort(d5(id), 'descend');
        y3(h) = mean(c5(id(num4(1:round(0.5 * length(num4))))));
        h = h + 1;
    end
end
positiveY2 = find(y2 >= 0);
[x, y, z, num] = log_bin_statistics_error(x1(positiveY2), y2(positiveY2) ./ y1(positiveY2));
hold on
errorbar(x, y, z)
positiveY3 = find(y3 >= 0);
[x, y, z, num] = log_bin_statistics_error(x1(positiveY3), y3(positiveY3) ./ y1(positiveY3));
hold on
errorbar(x, y, z)