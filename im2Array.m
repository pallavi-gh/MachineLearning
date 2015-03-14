function [ array ] = im2Array( im, way )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if way == 1
array = reshape(im,1,1600);
end
if way == 2
    array = reshape(im,40,40);
end
end

