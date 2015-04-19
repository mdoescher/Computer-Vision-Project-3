function [ dictionary ] = BuildLLCCodebook(imageFileList,imageBaseDir,dataBaseDir,params,canSkip,pfig)
%BUILDLLCODEBOOK Summary of this function goes here
%   Detailed explanation goes here

descriptors = GenerateSiftDescriptorsLLC( imageFileList, imageBaseDir, dataBaseDir, params, canSkip, pfig );
dictionary = CalculateDictionary(imageFileList,imageBaseDir,dataBaseDir,'_sift.mat',params,canSkip,pfig);

for i = 1:size(descriptors,1)
    xi = descriptors(i,:);
    
    [c, index] = LLCSolver(dictionary, xi,params.number_neighbors);
    Bi = dictionary(index,:);
    ci = c(index);
    deltaBi = -2* ci'*(xi-ci*Bi);
    miu = sqrt(1.0/i);
    Bi = Bi - (miu * deltaBi) / norm(ci);
    dictionary(index, :) = Bi;
end

