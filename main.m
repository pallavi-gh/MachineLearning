% [imgarray imglabel] = loadDataInArray('easy',1);


% for i = 11:20
%     showImageWithLabel(imgarray{1,i},imglabel{1,i});
%     pause(1);
% end



% 
% segmentedimages = {};
% count = 0;
% segmentedimageslabel = [];
% 
% for i = 1:length(imgarray)
%     temp = imageSegmentOld(imgarray{1,i},num2str(i));
%     count = count +1;
%     if length(temp) == 4
%         
%         segmentedimages = [segmentedimages temp];
%         segmentedimageslabel = [segmentedimageslabel; double(imglabel{1,i}(1,1)); double(imglabel{1,i}(1,2)); double(imglabel{1,i}(1,3)); double(imglabel{1,i}(1,4))];
%         
%     end
% end
% 
% accuracyx = (length(segmentedimages)/count)/4
% imgdata = [];
% 
% for i = 1:length(segmentedimages)
%     
%     imgdata = [imgdata ; im2Array(segmentedimages{1,i},1)];
% end
% clear accuracyx count i imgarray imglabel temp segmentedimages 


% use for showing segmented images with labels
% for i=1:length(segmentedimages)
%     imshow(segmentedimages{1,i});
%     t = title(char(segmentedimageslabel(i,1)));
%     set(t, 'FontSize', 20);
%     pause(.5);
%     close;
% end




%use for naive bayes model of a
% fullNBmodel = trainNB(imgdata,segmentedimageslabel,1);
% x = NaiveBayes.fit(traindata,trainlabels, 'Distribution', 'mn');
% sum(x.predict(testdata)==testlabels)/length(testlabels);
% sdk = im2Array(x.Params(1,:),2);
% sdk = cell2mat(sdk);
% sdk = sdk/max(max(sdk));
% imshow(sdk);
% imshow(fullmodel)



%use for NB feature selection
% matlabpool open 4
% opt = statset('display','iter','UseParallel', 'always');
% [inmodel history] = sequentialfs(@criteriaNB,imgdata,segmentedimageslabel,'options',opt,'cv','resubstitution','nfeatures',1000);
% matlabpool close
% save('featuresel.data','inmodel','history','-v7.3');
% load('featuresel.data','-mat');


% Break array into test and train
% [partone parttwo] = breakArrayNFold(size(imgdata,1),5,1);
% traindata = imgdata(partone,:);
% trainlabels = segmentedimageslabel(partone,:);
% testdata = imgdata(parttwo,:);
% testlabels = segmentedimageslabel(parttwo,:);
% clear partone parttwo segmentedimageslabel imgdata




%resizing of images
% accuracy = zeros(1,40);
% numoffets = zeros(1,40);
% for i = 1:40
%     traind = resizeImgData( traindata , i );
%     testd = resizeImgData( testdata , i );
%     svmModel = trainSVM(traind,trainlabels,2);
%     predictedLabels = classifySVM(svmModel,testd);
%     accuracy(1,i) = sum(double(predictedLabels==testlabels'))/length(testlabels);
%     numoffets(1,i) =  i*i;
% end
% plot(numoffets,accuracy,'-x');
traind = resizeImgData( traindata , 5 );
testd = resizeImgData( testdata , 5 );
fullNBmodel = trainNB(traind,trainlabels,1);
fullmodel = [];
for i = 1:length(fullNBmodel)
    fullmodel = [fullmodel zeros(5,3) im2Arrayx(fullNBmodel{i},2,5)];
end
imshow(fullmodel)







%Lasso fit
% [B,FitInfo] = lassoglm(traindata,trainlabels);
% save('lassofeatures.data','B','FitInfo','-v7.3');
% load('lassofeatures.data','-mat');
% logis = glmfit(traindata,trainlabels);
% 
% svmModel = trainSVM(traindata(:,abs(logis(2:1601))>4),trainlabels,2);
% predictedLabels = classifySVM(svmModel,testdata(:,abs(logis(2:1601))>4));
% accuracy = sum(double(predictedLabels==testlabels'))/length(testlabels);
% 
% 
% imshow([im2Array(abs(B(:,10)/sum(B(:,10))),2) ones(40,5) im2Array(abs(B(:,20)/sum(B(:,20))),2) ones(40,5) im2Array(abs(B(:,30)/sum(B(:,30))),2) ones(40,5) im2Array(abs(B(:,40)/sum(B(:,40))),2) ones(40,5) im2Array(abs(B(:,50)/sum(B(:,50))),2) ones(40,5) im2Array(abs(B(:,60)/sum(B(:,60))),2) ones(40,5) im2Array(abs(B(:,70)/sum(B(:,70))),2) ones(40,5) im2Array(abs(B(:,80)/sum(B(:,80))),2)])
% baseline = ones(1,29)*accuracy;
% accuracy = zeros(1,29);
% numoffets = zeros(1,29);
% for i = 1:29
%     idx = ((B(:,i*3)~=0)');
%     svmModel = trainSVM(traindata(:,idx),trainlabels,2);
%     predictedLabels = classifySVM(svmModel,testdata(:,idx));
%     accuracy(1,i) = sum(double(predictedLabels==testlabels'))/length(testlabels);
%     numoffets(1,i) =  sum(idx);
% end
% plot(numoffets,baseline,'r');
% hold on
% plot(numoffets,accuracy,'-x');

% 
% %Classification of segmented images
% svmModel = trainSVM(traindata,trainlabels,2);
% predictedLabels = classifySVM(svmModel,testdata);
% 
% accuracy = sum(double(predictedLabels==testlabels'))/length(testlabels)

% crossValidation( traindata, trainlabels, @classifySVM, @trainSVM, 10)

