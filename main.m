%control all the parameters
params.maxImageSize = 1000
params.gridSpacing = 1
params.patchSize = 16
params.dictionarySize = 200
params.numTextonImages = 1500
params.pyramidLevels = 2 % minimum 1
params.number_neighbors = 5;

number_directories=15;
training_size=100;
regenerateDictionary=1;
canSkip=1;

directory = 'Scene_Categories/';
dictionary_dir = ['data_200_LLC_'];
subfolderlist = dir(directory);
filepaths = cell(size(subfolderlist,1),1);
newfiles = [];

if (regenerateDictionary==1)
    canSkip=0;
    for i=1:size(subfolderlist,1)-2
        files = dir(strcat(directory,subfolderlist(i+2).name,'/','*.jpg'));
        perm{i} = randperm(size(files,1))';
        for j = 1:training_size
            filepaths{(i-1)*training_size+j}  = strcat(subfolderlist(i+2).name,'/',files(perm{i}(j)).name);
        end
    end
    [dictionary] = buildcodebook(filepaths,directory,dictionary_dir,params,0,0); 

    for i=3:size(subfolderlist,1)
        outFName = fullfile([dictionary_dir subfolderlist(i).name], sprintf('dictionary_%d.mat', params.dictionarySize));
        sp_make_dir(outFName);
        save(outFName, 'dictionary');
    end
    outFName=fullfile(dictionary_dir,sprintf('perm_%d.mat', params.dictionarySize));
    save(outFName, 'perm');
end
inFName=fullfile(dictionary_dir,sprintf('perm_%d.mat', params.dictionarySize));
load(inFName, 'perm');

% load the images and build the pyramids
listing=dir('Scene_Categories');
parfor i=3:2+number_directories
   image_dir=['Scene_Categories/' listing(i).name];
   data_dir = [dictionary_dir listing(i).name];
   fnames = dir(fullfile(image_dir, '*.jpg'));
   num_files = size(fnames,1);
   filenames = cell(num_files,1);
   for f = 1:num_files
	   filenames{f} = fnames(f).name;
   end
   pyramids{i-2} = BuildPyramidLLC(filenames,image_dir,data_dir,params,canSkip,0);  
end


%control all the parameters
params.maxImageSize = 1000
params.gridSpacing = 1
params.patchSize = 16
params.dictionarySize = 1024
params.numTextonImages = 1500
params.pyramidLevels = 2 % minimum 1
params.number_neighbors = 5;

number_directories=15;
training_size=100;
regenerateDictionary=1;
canSkip=1;

directory = 'Scene_Categories/';
dictionary_dir = ['data_1024_LLC_'];
subfolderlist = dir(directory);
filepaths = cell(size(subfolderlist,1),1);
newfiles = [];

if (regenerateDictionary==1)
    canSkip=0;
    for i=1:size(subfolderlist,1)-2
        files = dir(strcat(directory,subfolderlist(i+2).name,'/','*.jpg'));
        perm{i} = randperm(size(files,1))';
        for j = 1:training_size
            filepaths{(i-1)*training_size+j}  = strcat(subfolderlist(i+2).name,'/',files(perm{i}(j)).name);
        end
    end
    [dictionary] = buildcodebook(filepaths,directory,dictionary_dir,params,0,0); 

    for i=3:size(subfolderlist,1)
        outFName = fullfile([dictionary_dir subfolderlist(i).name], sprintf('dictionary_%d.mat', params.dictionarySize));
        sp_make_dir(outFName);
        save(outFName, 'dictionary');
    end
    outFName=fullfile(dictionary_dir,sprintf('perm_%d.mat', params.dictionarySize));
    save(outFName, 'perm');
end
inFName=fullfile(dictionary_dir,sprintf('perm_%d.mat', params.dictionarySize));
load(inFName, 'perm');

% load the images and build the pyramids
listing=dir('Scene_Categories');
parfor i=3:2+number_directories
   image_dir=['Scene_Categories/' listing(i).name];
   data_dir = [dictionary_dir listing(i).name];
   fnames = dir(fullfile(image_dir, '*.jpg'));
   num_files = size(fnames,1);
   filenames = cell(num_files,1);
   for f = 1:num_files
	   filenames{f} = fnames(f).name;
   end
   pyramids{i-2} = BuildPyramidLLC(filenames,image_dir,data_dir,params,canSkip,0);  
end


%control all the parameters
params.maxImageSize = 1000
params.gridSpacing = 1
params.patchSize = 16
params.dictionarySize = 200
params.numTextonImages = 1500
params.pyramidLevels = 2 % minimum 1
params.number_neighbors = 5;

number_directories=15;
training_size=100;
regenerateDictionary=1;
canSkip=1;

directory = 'Scene_Categories/';
dictionary_dir = ['data_200_SPM_'];
subfolderlist = dir(directory);
filepaths = cell(size(subfolderlist,1),1);
newfiles = [];

if (regenerateDictionary==1)
    canSkip=0;
    for i=1:size(subfolderlist,1)-2
        files = dir(strcat(directory,subfolderlist(i+2).name,'/','*.jpg'));
        perm{i} = randperm(size(files,1))';
        for j = 1:training_size
            filepaths{(i-1)*training_size+j}  = strcat(subfolderlist(i+2).name,'/',files(perm{i}(j)).name);
        end
    end
    [dictionary] = buildcodebook(filepaths,directory,dictionary_dir,params,0,0); 

    for i=3:size(subfolderlist,1)
        outFName = fullfile([dictionary_dir subfolderlist(i).name], sprintf('dictionary_%d.mat', params.dictionarySize));
        sp_make_dir(outFName);
        save(outFName, 'dictionary');
    end
    outFName=fullfile(dictionary_dir,sprintf('perm_%d.mat', params.dictionarySize));
    save(outFName, 'perm');
end
inFName=fullfile(dictionary_dir,sprintf('perm_%d.mat', params.dictionarySize));
load(inFName, 'perm');

% load the images and build the pyramids
listing=dir('Scene_Categories');
parfor i=3:2+number_directories
   image_dir=['Scene_Categories/' listing(i).name];
   data_dir = [dictionary_dir listing(i).name];
   fnames = dir(fullfile(image_dir, '*.jpg'));
   num_files = size(fnames,1);
   filenames = cell(num_files,1);
   for f = 1:num_files
	   filenames{f} = fnames(f).name;
   end
   pyramids{i-2} = BuildPyramid(filenames,image_dir,data_dir,params,canSkip,0);  
end


%control all the parameters
params.maxImageSize = 1000
params.gridSpacing = 1
params.patchSize = 16
params.dictionarySize = 1024
params.numTextonImages = 1500
params.pyramidLevels = 2 % minimum 1
params.number_neighbors = 5;

number_directories=15;
training_size=100;
regenerateDictionary=1;
canSkip=1;

directory = 'Scene_Categories/';
dictionary_dir = ['data_1024_SPM_'];
subfolderlist = dir(directory);
filepaths = cell(size(subfolderlist,1),1);
newfiles = [];

if (regenerateDictionary==1)
    canSkip=0;
    for i=1:size(subfolderlist,1)-2
        files = dir(strcat(directory,subfolderlist(i+2).name,'/','*.jpg'));
        perm{i} = randperm(size(files,1))';
        for j = 1:training_size
            filepaths{(i-1)*training_size+j}  = strcat(subfolderlist(i+2).name,'/',files(perm{i}(j)).name);
        end
    end
    [dictionary] = buildcodebook(filepaths,directory,dictionary_dir,params,0,0); 

    for i=3:size(subfolderlist,1)
        outFName = fullfile([dictionary_dir subfolderlist(i).name], sprintf('dictionary_%d.mat', params.dictionarySize));
        sp_make_dir(outFName);
        save(outFName, 'dictionary');
    end
    outFName=fullfile(dictionary_dir,sprintf('perm_%d.mat', params.dictionarySize));
    save(outFName, 'perm');
end
inFName=fullfile(dictionary_dir,sprintf('perm_%d.mat', params.dictionarySize));
load(inFName, 'perm');

% load the images and build the pyramids
listing=dir('Scene_Categories');
parfor i=3:2+number_directories
   image_dir=['Scene_Categories/' listing(i).name];
   data_dir = [dictionary_dir listing(i).name];
   fnames = dir(fullfile(image_dir, '*.jpg'));
   num_files = size(fnames,1);
   filenames = cell(num_files,1);
   for f = 1:num_files
	   filenames{f} = fnames(f).name;
   end
   pyramids{i-2} = BuildPyramid(filenames,image_dir,data_dir,params,canSkip,0);  
end

