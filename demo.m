load Mdl.mat;
img1=imread('1_Pixel3.jpg'); 
img2=imread('2_K20Pro.jpg'); 
img3=imread('3_6SP.jpg'); 
feat1=riqa_feature(img1);
feat2=riqa_feature(img2);
feat3=riqa_feature(img3);

score1 = predict(Mdl, feat1)  %84.2
score2 = predict(Mdl, feat2)  %76.8
score3 = predict(Mdl, feat3)  %41.9


