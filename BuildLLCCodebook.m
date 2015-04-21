function [ dictionary ] = BuildLLCCodebook(imageFileList,imageBaseDir,dataBaseDir,params,canSkip,pfig)
%BUILDLLCODEBOOK Summary of this function goes here
%   Detailed explanation goes here

descriptors = GenerateSiftDescriptorsLLC( imageFileList, imageBaseDir, dataBaseDir, params, canSkip, pfig );
dictionary = CalculateDictionaryLLC(imageFileList,imageBaseDir,dataBaseDir,'_sift.mat',params,canSkip,pfig);

for i = 1:size(descriptors,1)
    xi = descriptors.data(i,:);
    
    [c, index] = LLCSolver(dictionary, xi,params.number_neighbors);
    Bi = dictionary(index,:);
    deltaBi = -2* c*(xi-c'*Bi);
    miu = sqrt(1.0/i);
    Bi = Bi - (miu * deltaBi) / norm(c);
    dictionary(index, :) = Bi;
end

outFName = fullfile(dataBaseDir, sprintf('dictionary_%d.mat', params.dictionarySize));
sp_make_dir(outFName);
save(outFName, 'dictionary');

end

