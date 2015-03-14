load('featuresel.data','-mat');
sel = inmodel;
accurrracy = zeros(size(1:10:1000));
accurrracyx = zeros(size(1:10:1000));

baseline = ones(size(1:10:1000))*criteriaNB( traindata,trainlabels,testdata,testlabels );
trix = 1;
for i = 1:10:1000
sel = history.In(i,:);
accurrracy(trix,1) = criteriaNB( traindata(:,sel),trainlabels,testdata(:,sel),testlabels );
trix = trix +1;
end
plot(1:10:1000,accurrracy, 'g');
hold on
plot(1:10:1000,baseline,'r');
iter = 0;
acry = 0;
max =0;
trix = 1;
% for j = 1:10:1000
candit = zeros(1,300);
for j = [300]
    max =0;

for i = 1:40
    index = randperm(1600);
    sel = index(1:j);
    acry = criteriaNB( traindata(:,sel),trainlabels,testdata(:,sel),testlabels );
    if acry > max
        max = acry;
        candit = sel;
    end
    iter = iter+1;
    if(mod(iter,100) == 0)
    fprintf('loop no: %d, and %d\n', iter, max);
    end
end
accurrracyx(trix,1) = max;
trix = trix +1;

end
hold on;
plot(1:10:1000,accurrracyx, 'b')



% randomized feature sel intersection
% fets = 1200;
% candit = zeros(5,fets);
% 
% for j = 1:5
% iter = 0;
% acry = 0;
% max =0;
% 
% for i = 1:100
%     index = randperm(1600);
%     sel = index(1:fets);
%     acry = criteriaNB( traindata(:,sel),trainlabels,testdata(:,sel),testlabels );
%     if acry > max
%         max = acry;
%         candit(j,:) = sel;
%     end
%     iter = iter+1;
%     if(mod(iter,100) == 0)
%     fprintf('loop no: %d, and %d\n', iter, max);
%     end
% end
% end
% canditx = candit(1,:);
% for i=2:5
% canditx = intersect(canditx,candit(i,:));
% end
sel = zeros(1,1600);
for i = 1:1600
    sel(1,i) = sum(candit==i);
end

imshow(im2Array(sel,2))