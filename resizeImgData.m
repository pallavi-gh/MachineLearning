function [ datax ] = resizeImgData( data, i )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
datax = zeros(size(data,1),i*i);
for j = 1:size(data,1)
%     size(im2Arrayx(imresize(im2Arrayx(data(j,:),2,40), [i i]),1,i))
%     size(datax)
    datax(j,:)=im2Arrayx(imresize(im2Arrayx(data(j,:),2,40), [i i]),1,i);

end

