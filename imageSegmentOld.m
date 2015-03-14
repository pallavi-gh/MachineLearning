function [ObjArray] = imageSegmentOld(I,tittle)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


J=I;
% imshow(J);
% 
% t = title(strcat('index of image is ',tittle));
% set(t, 'FontSize', 20);

if ndims(I)==3
    I=rgb2gray(I);
end
level=graythresh(I);
I=~im2bw(I,level);

I=bwareaopen(I,30);
% figure(1)

[L num]=bwlabel(I);
prop=regionprops(L,'BoundingBox');
% hold on;
% for i=1:size(prop,1)
%     rectangle('Position',prop(i).BoundingBox,'EdgeColor','b','LineWidth',2);
% end
% hold off;

for j=1:num
    [row, col]=find(L==j);
    i1=I(min(row):max(row),min(col):max(col));
    i2=~i1;
    cell{j}=im2double(imresize(i2, [40 40]));
end
ObjArray=cell;

% if length(ObjArray)~=4
% pause(2.7);
% end
% close(1);

    


end

