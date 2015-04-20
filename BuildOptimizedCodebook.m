function [dictionary] = buildcodebook( imageFileList, imageBaseDir, dataBaseDir, params, canSkip, saveSift )
% generates the dictionary

if(~exist('params','var'))
    params.maxImageSize = 1000
    params.gridSpacing = 8
    params.patchSize = 16
    params.dictionarySize = 200
    params.numTextonImages = 50
    params.pyramidLevels = 3
    params.oldSift = false;
end

if(~isfield(params,'maxImageSize'))
    params.maxImageSize = 1000
end
if(~isfield(params,'gridSpacing'))
    params.gridSpacing = 8
end
if(~isfield(params,'patchSize'))
    params.patchSize = 16
end
if(~isfield(params,'dictionarySize'))
    params.dictionarySize = 200
end
if(~isfield(params,'numTextonImages'))
    params.numTextonImages = 50
end
if(~isfield(params,'pyramidLevels'))
    params.pyramidLevels = 3
end
if(~isfield(params,'oldSift'))
    params.oldSift = false
end

if(~exist('canSkip','var'))
    canSkip = 1
end
if(~exist('saveSift','var'))
    saveSift = 1
end

pfig = sp_progress_bar('Building Spatial Pyramid');
%% build the pyramid
if(saveSift)
%    GenerateSiftDescriptors( imageFileList,imageBaseDir,dataBaseDir,params,canSkip,pfig);
end
%dictionary=CalculateDictionary(imageFileList,imageBaseDir,dataBaseDir,'_sift.mat',params,canSkip,pfig);
dictionary=BuildLLCCodebook(imageFileList,imageBaseDir,dataBaseDir,params,canSkip,pfig);
%BuildHistograms(imageFileList,imageBaseDir,dataBaseDir,'_sift.mat',params,canSkip,pfig);
%pyramid_all = CompilePyramid(imageFileList,dataBaseDir,sprintf('_texton_ind_%d.mat',params.dictionarySize),params,canSkip,pfig);
close(pfig);
end
