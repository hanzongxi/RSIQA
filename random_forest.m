%% Random Forest,这个因为要长100或者500颗树，所以速度比SVR慢
% doc TreeBagger
% Mdl represents the ensemble object.
load riqa_feat.mat;
load mos.mat;

train_inst=feat;
train_label=mos;
test_inst=feat;
test_label=mos;

Mdl=TreeBagger(5,train_inst,train_label,Method="regression"); %ss=0.9133
predSpecies = predict(Mdl, test_inst);
figure,[ss,kk,pp,rr] = verify_performance(test_label,predSpecies)


Mdl=TreeBagger(10,train_inst,train_label,Method="regression"); %ss=0.9393
predSpecies = predict(Mdl, test_inst);
figure,[ss,kk,pp,rr] = verify_performance(test_label,predSpecies)

Mdl=TreeBagger(100,train_inst,train_label,Method="regression"); %ss=0.9560
predSpecies = predict(Mdl, test_inst);
figure,[ss,kk,pp,rr] = verify_performance(test_label,predSpecies)
view(Mdl.Trees{1},Mode="graph")

Mdl=TreeBagger(500,train_inst,train_label,Method="regression");%ss=0.9572
predSpecies = predict(Mdl, test_inst);
figure,[ss,kk,pp,rr] = verify_performance(test_label,predSpecies)
save Mdl.mat Mdl;


