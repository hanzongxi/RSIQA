load riqa_feat.mat;  %% If you want to check the performance of BNBT and BNIQM, feat_without_region_selective, please load bniqm_feat.mat, and bnbt_feat.mat, which are in their own subfolders.
load mos.mat;


inst=feat; % Using the 35-dimensionalfeatures.
label=mos;

% inst=feat(:,1:11);  % Using the 11-dimensional brightness features. 0.6799,0.5072,0.7027,19.1622
% inst=feat(:,12:30);  % Using the 19-dimensional sharpness features. 0.6913,0.5025,0.7334,18.2345
% inst=feat(:,31:35);  % Using the 5-dimensional highlight suppressing features. 0.4965，0.3456，0.5395，23.0446

ssrcc = [];
skrcc = [];
splcc = [];
srmse = [];

% train_idx_list = [];
% test_idx_list = [];

test_train_ratio = 0.9;

g = 2^-6;
c = 2^7;
parameter = ['-s' ' 3 ' '-t' ' 2 ' '-g' ' ' num2str(g) ' ' '-c' ' ' num2str(c) ' -q' ];
%
for k = 1:10
     k
     idx = randperm(510);
%     train_idx = train_idx_list(k,:);
%     test_idx = test_idx_list(k,:);    
    train_idx = idx(1:floor(510*test_train_ratio));
    test_idx = idx(ceil(510*test_train_ratio):510);
    %train_idx = [1791:2240];
    %test_idx = [1:1790];    
    train_label = label(train_idx);
    train_inst = inst(train_idx,:);
    test_label = label(test_idx);
    test_inst = inst(test_idx,:);
    
    %% Regression tree
    % %figure;
    % tree = fitrtree(train_inst,train_label,'MaxNumSplits',50); %0.6663, 0.5033, 0.6981, 19.2989
    % %view(tree, 'Mode', 'graph');
    % predict_label = predict(tree, test_inst);
    % 

    %% Random forest
    Mdl=TreeBagger(100,train_inst,train_label,Method="regression");  %ss=0.8053，0.6124，0.8345，14.6970
    predict_label = predict(Mdl, test_inst);
    
    %% SVR
    % svmmodel = svmtrain(train_label,train_inst,parameter);
    % ttest_label = zeros(size(test_label));
    % [predict_label, accuracy, dec_values]  = svmpredict(ttest_label, test_inst, svmmodel); %0.7481，0.5540，0.7953，16.1353
    
    [ss,kk,pp,rr] = verify_performance(test_label,predict_label);
    ssrcc(k) = abs(ss);
    skrcc(k) = abs(kk);
    splcc(k) = abs(pp);
    srmse(k) = abs(rr);
end
%---------------------------------------------------------------------------------%
%---------------------------------------------------------------------------------%

mean(ssrcc)   % 0.8053
mean(skrcc)   % 0.6124
mean(splcc)   % 0.8345
mean(srmse)   % 14.6970