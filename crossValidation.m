function [ accuracy ] = crossValidation( traindata, trainlabels, classify, train, fold, opone, optwo, opthree)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if (~exist('opone', 'var'))
        opone = 2;
    end
    if (~exist('optwo', 'var'))
        optwo = 2;
    end
    if (~exist('opthree', 'var'))
        opthree = 2;
    end
accuracy = 0;
N = fold;
    for fold = 1:N
        
        [partone parttwo] = breakArrayNFold(size(traindata,1),N,fold);
        Model = train(traindata(partone,:),trainlabels(partone,:), opone);
        predictedLabels = classify(Model,traindata(parttwo,:));
        testError = sum(double(predictedLabels==trainlabels(parttwo,:)'))/length(trainlabels(parttwo,:));
        accuracy = accuracy + testError;
    end
accuracy = accuracy/N;



end

