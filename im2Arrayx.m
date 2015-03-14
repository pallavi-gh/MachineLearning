function [ array ] = im2Arrayx( im, way, i )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if way == 1
array = reshape(im,1,i*i);
end
if way == 2
    array = reshape(im,i,i);
end
end

