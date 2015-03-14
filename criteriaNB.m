function [ accuracy ] = criteriaNB( traindata,trainlabels,testdata,testlabels )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
x = NaiveBayes.fit(traindata,trainlabels, 'Distribution', 'mn');
accuracy = sum(x.predict(testdata)==testlabels)/length(testlabels);

end

