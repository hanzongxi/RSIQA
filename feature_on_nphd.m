% clear
% clc
load ./names.mat
feat = [];
for i = 1:510
    i
    img_path = names{i};
    img = imread(img_path);
    feat(i,:) = riqa_feature(img); %% You can extract the feature using bnbt_feature, or bniqm_feature function, which is in their own subfolders.
    
end

save riqa_feat.mat feat;