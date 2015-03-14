function [] = showImageWithLabel( img, label )
%show image and its label
imshow(img);
t = title(label);
set(t, 'FontSize', 20);
end

