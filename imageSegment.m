function [ObjArray] = imageSegment(I, tittle)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%if str==[]
 %   prompt = 'Enter image name: ';
  %  txt = input(prompt,'s');
   % I = imread(txt);
%else
%    I=imread(str);
%end
J=I;
imshow(J);
t = title(strcat('index of image is ',tittle));
set(t, 'FontSize', 20);
if ndims(I)==3
    I=rgb2gray(I);
end
[level em]=graythresh(I);
I=~im2bw(I,em);
% pause(1);
I=bwareaopen(I,30);
% pause(1);
figure(1)
% imshow(~I);

[L num]=bwlabel(I);
prop=regionprops(L,'BoundingBox');
hold on;
for i=1:size(prop,1)
    rectangle('Position',prop(i).BoundingBox,'EdgeColor','b','LineWidth',2);
end
hold off;

for j=1:num
    [row, col]=find(L==j);
    i1=I(min(row):max(row),min(col):max(col));
    i2=~i1;
    %imshow(i2);
    cell{j}=i2;
    %pause(1);
end
ObjArray=cell;
if length(ObjArray)~=4
pause(2.7);
end
close(1);
%display images from cell
% for k=1:num
%     J=cell{k};
%     imshow(J);
%     pause(1);
%     J=[];
% end
    


end

