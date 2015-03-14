function [ fullmodel ] = trainNB( data,labels,C )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


fullmodel = {};
labels = labels-96;
classes = unique(labels);
for j = 1:size(classes,1)
aindex = find(labels == classes(j));
if length(aindex) > 2
model = data(aindex(1,1),:);
for i=2:length(aindex)
    model = model + data(aindex(i,1),:);
end
model = model./length(aindex);
fullmodel(classes(j)) =  {model};
end
end
lab = find(cellfun(@isempty,fullmodel)==1);
for j = 1:size(lab,2)
    fullmodel(lab(j)) = {zeros(1,size(data(1,:),2) )};
end

% for j = 1: size(fullmodel,2)
% 
% fullmodel{j} = fullmodel{j}+0.0001;
% end

%imshow(im2Array(fullNBmodel{1},2))