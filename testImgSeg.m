function [ arr big idx ] = testImgSeg( I )

%% Image segmentation and extraction
%% Read Image

imagen = imread(I);
I=imagen;
figure(1)
imshow(I);
if ndims(I)==3
    I=rgb2gray(I);
end
figure(2)
imshow(I);
    
level=graythresh(I);
I=~im2bw(I,level);
figure(3)
imshow(I);
I=bwareaopen(I,30);
figure(4)
imshow(I);
figure(1)
%pause(10);
[L num]=bwlabel(I);
imshow(L);
%pause(3);
prop=regionprops(L,'BoundingBox');
% hold on;
for i=1:size(prop,1)
    %figure(5)
  t=( rectangle('Position',prop(i).BoundingBox,'EdgeColor','b','LineWidth',2));
  
end
%hold off;

for j=1:num
    [row, col]=find(L==j);
    i1=I(min(row):max(row),min(col):max(col));
    i2=~i1;
    cell{j}=im2double(imresize(i2, [40 40]));
    ecc{j}=regionprops(cell{j},'Eccentricity');
    orient{j}=regionprops(cell{j},'Orientation');
   % figure(j+5)
 %   imshow(cell{j});
end
ObjArray=cell;

%display images from cell
 for k=1:num
     J=cell{k};
    % imshow(J);
     pause(1);
     J=[];
 end
 BW=cell{3};
%[L2 num2]=bwlabel(testimg);
CC = bwconncomp(BW);
numPixels = cellfun('length',CC.PixelIdxList);
[biggest,idx] = max(numPixels);

[m n]=size(biggest);
for l=1:idx-1
    BW(CC.PixelIdxList{l}) = 0;
end
for l=idx+1:n
    BW(CC.PixelIdxList{l}) = 0;
end
 
figure, imshow(BW);
pause(2);


%display images from cell
for i=1:num
    arr{i}=[ecc{i}.Eccentricity]; 
    big{i}=[orient{i}.Orientation];
end
 idx=idx;
end


