%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
params.maxImageSize = 1000
params.gridSpacing = 1
params.patchSize = 16
params.dictionarySize = 200 %200
params.numTextonImages = 300
params.pyramidLevels = 2 % min 1
params.number_neighbors = 5;

directory = 'scene_categories/';
data_dir = ['data_7_'];
subfolderlist = dir(directory);
filepaths = cell(size(subfolderlist,1),1);
newfiles = [];
for i=3:size(subfolderlist,1)
    files = dir(strcat(directory,subfolderlist(i).name,'/','*.jpg'))
    perm = randperm(size(files,1))';
    for j = 1:100
        filepaths{(i-3)*100+j}  = strcat(subfolderlist(i).name,'/',files(perm(j)).name);
    end
end
buildcodebook(filepaths,directory,data_dir,params,0,0);  

