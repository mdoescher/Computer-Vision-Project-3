tic
fprintf('Start');

%control all the parameters
params.maxImageSize = 1000
params.gridSpacing = 1
params.patchSize = 16
params.dictionarySize = 1024
params.numTextonImages = 300
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

 
% construct training_data_set and testing_data_set
fprintf('Construct Training and Test data sets');
training_data_set=[];
testing_data_set=[];
testing_image_count=[];
for i=1:number_directories
    number_images=size(pyramids{i},1);
    f=perm{i};
    pyramid=pyramids{i};
    t(1:number_images,:)=pyramid(f(1:number_images),:); % permute the images
    training_data_set=[training_data_set; t(1:training_size,:)];  % first * images are used for the training set
    testing_data_set=[testing_data_set; t(training_size+1:number_images,:)]; % rest for the testing set
    testing_image_count=[testing_image_count (number_images-training_size)]; % number of images from each set in the testing set
end
training_data_set=sparse(training_data_set);
testing_data_set=sparse(testing_data_set);

fprintf('Training');
parfor i=1:number_directories
    training_label = [];
    for j=1:number_directories
        sign=-1;
        if (i==j) 
            sign = 1;
        end
        training_label=[training_label; ones(training_size,1)*sign];
    end
    model{i}=train(training_label, training_data_set);
end

fprintf('Testing');
confusion_matrix = zeros(number_directories, number_directories);
i=0;
for j=1:number_directories
    for k=1:testing_image_count(j)
        i=i+1
        probability_vector = zeros(1,number_directories);
        parfor m=1:number_directories
           [~, ~, probability_vector(m)] = predict(1,testing_data_set(i,:), model{m});
        end
        [M,I]=max(probability_vector);
        confusion_matrix(j,I)=confusion_matrix(j,I)+1;
    end
end

confusion_matrix
save([dictionary_dir 'confusion_matrix'], 'confusion_matrix');

number_correct = sum(diag(confusion_matrix));
number_total = sum(sum(confusion_matrix));
accuracy = number_correct/number_total

tmp = sum(confusion_matrix')'
for i = 1:size(confusion_matrix,1)
    for j = 1:size(confusion_matrix,2)
    confusion_matrix(i,j) = confusion_matrix(i,j)/tmp(i);
    end
end

    

toc
    
   


