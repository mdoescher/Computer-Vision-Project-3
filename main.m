%control all the parameters
params.maxImageSize = 1000
params.gridSpacing = 1
params.patchSize = 16
params.dictionarySize = 200 %200
params.numTextonImages = 300
params.pyramidLevels = 2 % min 1

number_directories=2 %15;
listing=dir('Scene_Categories');

% load the images and build the pyramids
for i=3:2+number_directories
   image_dir=['Scene_Categories/' listing(i).name];
   data_dir = ['data_' listing(i).name];
   fnames = dir(fullfile(image_dir, '*.jpg'));
   num_files = size(fnames,1);
   filenames = cell(num_files,1);
   for f = 1:num_files
	   filenames{f} = fnames(f).name;
   end
   pyramids{i-2} = BuildPyramid(filenames,image_dir,data_dir,params,1,0);  
end
    
% construct training_data_set and testing_data_set
training_data_set=[];
testing_data_set=[];
testing_image_count=[];
for i=1:number_directories
    number_images=size(pyramids{i},1);
    f=randperm(number_images);
    pyramid=pyramids{i};
    t(1:number_images,:)=pyramid(f(1:number_images),:); % permute the images
    training_data_set=[training_data_set; t(1:100,:)];  % first 100 images are used for the training set
    testing_data_set=[testing_data_set; t(101:number_images,:)]; % rest for the testing set
    testing_image_count=[testing_image_count (number_images-100)]; % number of images from each set in the testing set
end
training_data_set=sparse(training_data_set);
testing_data_set=sparse(testing_data_set);

for i=1:number_directories
    i
    training_label = [];
    for j=1:number_directories
        sign=-1;
        if (i==j) 
            sign = 1;
        end
        training_label=[training_label; ones(100,1)*sign];
    end
    model{i}=train(training_label, training_data_set);
end

confusion_matrix = zeros(number_directories, number_directories);
i=0;
for j=1:number_directories
    for k=1:testing_image_count(j)
        i=i+1
        probability_vector = zeros(1,number_directories);
        for m=1:number_directories
           [~, ~, probability_vector(m)] = predict(1,testing_data_set(i,:), model{m});
        end
        [M,I]=max(probability_vector);
        confusion_matrix(j,I)=confusion_matrix(j,I)+1;
    end
end

confusion_matrix
save('confusion_matrix_experiment_1', 'confusion_matrix');

number_correct = sum(diag(confusion_matrix));
number_total = sum(sum(confusion_matrix));
accuracy = number_correct/number_total

tmp = sum(confusion_matrix')'
for i = 1:size(confusion_matrix,1)
    for j = 1:size(confusion_matrix,2)
    confusion_matrix(i,j) = confusion_matrix(i,j)/tmp(i);
    end
end

    
    
   


