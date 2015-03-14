[imgarray imglabel] = tloadDataInArray('t_easy',1);


 %for i = 11:20
 %  tshowImageWithLabel(imgarray{1,i},imglabel{1,i});
 %   pause(1);
 %end
segmentedimages = {};
count = 0;
segmentedimageslabel = [];

for i = 1:length(imgarray)
    [temp ecc orient] = timageSegmentOld(imgarray{1,i},num2str(i));
    count = count +1;
    if length(temp) == 4
        
        segmentedimages = [segmentedimages temp];
        segmentedimageslabel = [segmentedimageslabel; double(imglabel{1,i}(1,1)); double(imglabel{1,i}(1,2)); double(imglabel{1,i}(1,3)); double(imglabel{1,i}(1,4))];
        %for j=1:4
         %   tshowImageWithLabel(imgarray{1,i},imglabel{1,i});
        %end
    end
end

%indexa = segmentedimageslabel == double('b');
%indexp = segmentedimageslabel == double('d');
%indexb = segmentedimageslabel == double('s');
%indexd = segmentedimageslabel == double('m');
%[m loopend]=size(segmentedimages);
%for k=1:loopend
 %   img=segmentedimages{1,k};
 %   %imshow(segmentedimages{1,k});
 %   kur{k}=kurtosis(img);
 %   %ecc{k}=regionprops(img,'ConvexArea');
 %   orient{k}=regionprops(img,'Area');
 %   third{k}=regionprops(img,'Orientation');
%end

%for j=1:loopend
    
    %eccM{j}=[ecc{j}.ConvexArea]; 
 %   orientM{j}=[orient{j}.Area];
 %   thirdM{j}=[third{j}.Orientation];
%end
%eccV=cell2mat(kur);
%orientV=cell2mat(orientM);
%thirdV=cell2mat(thirdM);

%plot3(eccV(indexa),orientV(indexa),thirdV(indexa),'xr');
%hold on
%plot3(eccV(indexp),orientV(indexp),thirdV(indexp),'xb');
%hold on
%plot3(eccV(indexb),orientV(indexb),thirdV(indexb),'xg');

%plot(eccV(indexa),orientV(indexa),'xr');
%hold on
%plot(eccV(indexp),orientV(indexp),'xb');
%hold on
%plot(eccV(indexb),orientV(indexb),'xg');
%hold on
%plot(orientV(indexd),eccV(indexd),'xy');



% %size(segmentedimages)
% newlabel=segmentedimageslabel(1:loopend,1)';
% 
% %scatter(orientV,eccV);
% X=[orientV,eccV];
% a=orientV';
% b=eccV';
% c=newlabel';
% gplotmatrix(a,b,c);
% 
% %X=[eccM;orientM];
% %size(X)
% %silhouette(X,'Euclidean')
% 
% 
% %size(segmentedimageslabel)
% accuracyx = (length(segmentedimages)/count)/4
imgdata = [];
size(segmentedimages)
 for i = 1:length(segmentedimages)
     
     imgdata = [imgdata ; im2Array(segmentedimages{1,i},1)];
end
disp('original');size(imgdata)

% use for showing segmented images with labels
% for i=1:length(segmentedimages)
%     imshow(segmentedimages{1,i});
%     t = title(char(segmentedimageslabel(i,1)));
%     set(t, 'FontSize', 20);
%     pause(.5);
%     close;
% end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~PCA begins~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
i=segmentedimages{1};
imshow(i);

imgs=imgdata';
[m n]=size(imgs);
[Vecs,Vals,Psi] = pc_evectors(imgs,1600);   % Get top 30 PC evectors of Imgs
figure(1)
plot(Vals);                                 % To plot the eigenvalues
CVals = zeros(1,length(Vals));              % Allocate a vector same length as Vals
CVals(1) = Vals(1);
for i = 2:length(Vals)                      % Accumulate the eigenvalue sum
   CVals(i) = CVals(i-1) + Vals(i);
end;
CVals = CVals / sum(Vals);                  % Normalize total sum to 1.0
plot(CVals);                                % Plot the cumulative sum
ylim([0 1]);                                % Set Y-axis limits to be 0-1

Proj = Vecs(:,1:2)' * imgs;       % Project each image onto first 2 evectors
size(Proj)
figure(2)
plot(Proj(1,:),Proj(2,:),'r.')
disp('vecs');size(Vecs)
pc_ev_1 = Vecs(:,30);                 % Get PC eigenvector 1
pc_ev_1 = reshape(pc_ev_1,40,40);     % Reshape into 2D array
figure(3)
imagesc(pc_ev_1);                    % Display as image scaled 0-255

OrigImg = imgs(:,1);                     % Grab image 20
Projection = Vecs(:,1:1600)'*(OrigImg - Psi);    % Project onto ev's 1-10
Reconstruction = Vecs(:,1:1600)*Projection+Psi;  % Reconstruct from projection
Reconstruction = reshape(Reconstruction,40,40);     % originally they used a transpose for Reconstruction, I removed to invert the image.
figure(4)
imagesc(Reconstruction);
colormap(gray(256));
daspect([1 1 1]);
disp('recons size');size(Reconstruction)

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~PCA ends~~~~~~~~~~~~~~~~~~~~~

%im20=imgs(:,20);
%im20= reshape(L,40,40)';         % Reshapes column vector into a 2D array
%image(im20);
%colormap(gray(256));
%daspect([1 1 1]);


%[eigenvectors scores eigenvalues] = princomp(x);
%size(eigenvectors)
%C=reshape(eigenvectors,40,40);
%imshow(C);
%D=
%[m n]=size(x);
%x=reshape(x,m*n,1);
%mn=mean(x,2);
%x=bsxfun(@minus,x,mean(x,1));
%y=x'*x/(m*n-1);
%[v d]=eigs(y,10);
%signals=x*v;
%imshow(signals);

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
%matlabpool open 2
%opt = statset('display','iter','UseParallel', 'always');
%[inmodel history] = sequentialfs(@criteriaNB,imgdata,segmentedimageslabel,'options',opt,'cv','resubstitution','nfeatures',1000);
%matlabpool close
%save('featuresel.data','inmodel','history','-v7.3');
%load('featuresel.data','-mat');

%imgdataT=imgdata';
%[coeff scores latent] = princomp(zscore(imgdataT),'econ');

%disp('imgdata');size(imgdata) 
%disp('coeff');size(coeff)
 %disp('scores');size(scores)
 %disp('latent');size(latent)
 %[foo, feature_idx] = sort(latent, 'descend');
%selected_projected_data = scores(:, feature_idx(1:1000));
% disp('selected_projected_data');size(selected_projected_data)
%reconstructed_images = scores / coeff + repmat(mean(imgdataT,1), 1600, 1);
%newset=imgdataT - reconstructed_images;

%disp('newset');size(newset)
%imgdata=selected_projected_data;

%imshow(x);
% Classification of segmented images
 %[partone parttwo] = breakArrayNFold(size(imgdata,1),5,1);
 %traindata = imgdata(partone,:);
 %trainlabels = segmentedimageslabel(partone,:);

%disp('traindata'); 
%size(traindata)
 
 %testdata = imgdata(parttwo,:);
 %disp('testdata');size(testdata)
 
 
 

 %testlabels = segmentedimageslabel(parttwo,:);
 
 %svmModel = trainSVM(traindata,trainlabels,2);
 %predictedLabels = classifySVM(svmModel,testdata);
 
 %accuracy = sum(double(predictedLabels==testlabels'))/length(testlabels)

%crossValidation( traindata, trainlabels, @classifySVM, @trainSVM, 10)

