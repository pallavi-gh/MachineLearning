imagen=imread('easy\0.15778130765921.jpg');
imshow(imagen);
%% Convert to gray scale
if size(imagen,3)==3 % RGB image
    imagen=rgb2gray(imagen);
end
figure(1)
imshow(imagen)
i=edge(imagen);
imshow(i)
l=i;
pause(2);
I = double(i);
BW = im2bw(I,0.5);                   %# binarize image
BW = imdilate(BW,strel('square',1));
kl=BW;
%BW = imdilate(BW,strel('square',3));  %# dilation
imshow(BW);
pause(4);
%BW = imfill(BW,'holes');             %# fill inside silhouette
BW = imerode(BW,strel('square',3));  %# erode
imshow(BW);
pause(4);
BW = bwperim(BW,8);                  %# get perimeter
imshow(BW);
pause(4);
imshow(BW)
imagen=BW;
[L Ne]=bwlabel(imagen);
%% Measure properties of image regions
propied=regionprops(L,'BoundingBox');
hold on
total=[];
%% Plot Bounding Box
for n=1:size(propied,1)
    t=rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2);
    total=bwarea(t);
    %if(total<150)
        
end
hold off
pause (1)
total
%% Objects extraction

figure
for n=1:Ne
    [r,c] = find(L==n);
    n1=imagen(min(r):max(r),min(c):max(c));
    n2=~n1;
    imshow(~n1);
    pause(0.5)
end
imshow(kl);