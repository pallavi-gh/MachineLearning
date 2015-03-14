function [] = segmentImagetest(txt)
%% Image segmentation and extraction
%% Read Image
prompt = 'Enter image name: ';
txt = input(prompt,'s');
imagen = imread(txt);
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
% figure(1)

[L num]=bwlabel(I);
prop=regionprops(L,'BoundingBox');
% hold on;
for i=1:size(prop,1)
    figure(5)
  imshow( rectangle('Position',prop(i).BoundingBox,'EdgeColor','b','LineWidth',2));
end
%hold off;

for j=1:num
    [row, col]=find(L==j);
    i1=I(min(row):max(row),min(col):max(col));
    i2=~i1;
    cell{j}=im2double(imresize(i2, [40 40]));
    figure(j+5)
    imshow(cell{j});
end
ObjArray=cell;

% if length(ObjArray)~=4
% pause(2.7);
% end
% close(1);

    


end