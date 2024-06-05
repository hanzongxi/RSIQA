function feat=highlight_suppressing_feature(img,thr)

  
  grayImg=rgb2gray(img);
  [m,n]=size(grayImg);
  %grayImg=imresize(grayImg,0.125);
  grayImg = medfilt2(grayImg,[5,3],'symmetric');
  binImg=grayImg>thr;


 %% number of the overexposed pixels
  num=sum(binImg(:));
  RA=num/(m*n);
 %% average of saturation
  hsvImg=rgb2hsv(img);
  S=hsvImg(:,:,2);
  SA=mean(S(binImg));
 %% average of brigtness
  V=hsvImg(:,:,3);
  
  pp=V((binImg));
  sort_pp = sort(pp,'ascend');
  len = length(sort_pp);
  ww = 1:len;
  weight = log2(1+(ww/len));
  weight = weight/(sum(weight));
  Br = sum(sort_pp.*weight'); %% This is the logarithm weighting strategy.

 %% Total variation
  V1=imtranslate(V,[0,1]);
  V2=imtranslate(V,[0,-1]);
  V3=imtranslate(V,[1,0]);
  V4=imtranslate(V,[-1,0]);
  TV=abs(V-V1)+abs(V-V2)+abs(V-V3)+abs(V-V4);
  mTV=mean(TV(binImg));

 %% Entropy
  Ent=entropy(V(binImg));
  feat = [RA SA Br mTV Ent];
  % binImg1=imdilate(binImg,strel("rectangle",[15,15]));
  % mask=boundarymask(binImg1);
  % figure,imshow(mask)
 % imwrite(mask,'mask.png')
  % binImg1=imdilate(binImg,strel("rectangle",[7,11]));
  % figure;imshow(binImg);

end

    

    


