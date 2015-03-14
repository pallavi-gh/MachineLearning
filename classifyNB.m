function [ predict ] = classifyNB( model, testdata )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
predict = zeros(size(testdata,1),1);
probability = zeros(size(model,2),1);

for i = 1:size(testdata,1)
    for j = 1:size(model,2)
        temp = testdata(i,:).*model{j};
        temp = temp(temp~=0);
        probability(j,1) = sum(log(temp));
    
    end
    probability(probability == 0) = -100000;
    [~, predict(i,1)] = max(probability);
    
end
predict = predict' + 96;
