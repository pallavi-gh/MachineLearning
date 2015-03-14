function [ array, label ] = tloadDataInArray( directory, style )
%load all images in directory

if style == 1
directory_name = directory;
files = dir(directory_name);

fileIndex = find(~[files.isdir]);
array = cell(1,length(fileIndex));
i=1;
megastr = '';
for j = fileIndex
array(1,i) = {files(j).name};
megastr = strcat(megastr,{files(j).name});
i = i+1;
end
imagename = [];
for i = 1:length(array)
    if isempty(regexp(array{1,i},'.+\.jpg','match'))
        imagename = [ imagename array(1,i)];
    end
end
index = [];
for i = 1:length(imagename)
    match = regexp(megastr,char(imagename(1, i)),'match');
    if  size(match{1,1},2)==2;
        index = [index i];
    
    end
end

imagename = imagename(1, index);
array = {};
label = cell(1,length(imagename));
for i = 1:length(imagename)
    array = [array imread(fullfile(directory, strcat(char(imagename(1, i)),'.jpg')   ))];
    label(1,i) = textread(fullfile(directory,char(imagename(1, i))),'%s');
end
% for i = 1:length(fileIndex)
%     
% if num == 1
%     fileName = files(fileIndex(i)).name;
%     label(1,(i+1)/2) = { fileread(fullfile(directory_name,fileName)) } ;
%     num = 2;
% else
%     fileName = files(fileIndex(i)).name;
%     array = [array imread(fullfile(directory_name,fileName))];
%     num = 1;
%     
% end
% % array = imread(string);
% end
end

