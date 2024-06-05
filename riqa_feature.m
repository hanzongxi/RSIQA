function feat = riqa_feature(I)
addpath('EA');
addpath('TR');
tic   %89.07s
feat=[];

[m,n,~]=size(I);
I_center=I(m/5:4*m/5,n/5:4*n/5,:);
I_topleft=I(1:round(m/5),1:round(n/5),:);
I_topright=I(1:round(m/5),n-round(n/5)+1:n,:);
I_bottomleft=I(m-round(m/5)+1:m,1:round(n/5),:);
I_bottomright=I(m-round(m/5)+1:m,n-round(n/5)+1:n,:);
I_around=[I_topleft I_topright; I_bottomleft I_bottomright];

dis_file_gray = rgb2gray(I_center);
i = 1;
    %% mean value
   mean_tmp = round(mean2(dis_file_gray));        
   feat(i, 1) = 1/(sqrt(2*pi)*26.0625)*exp(-(mean_tmp-118.5585)^2/(2*26.0625^2));
        
   %% std value
   std_tmp = round(std2(dis_file_gray));
   feat(i, 2) = 1/(sqrt(2*pi)*12.8584)*exp(-(std_tmp-57.2743)^2/(2*12.8584^2));
        
  %% entropy value
   entropy_tmp = entropy(dis_file_gray);
   feat(i, 3) = 1/0.2578*exp((entropy_tmp-7.5404)/0.2578)*exp(-exp((entropy_tmp-7.5404)/0.2578));
        
  %% kurtosis value
   kurtosis_tmp = kurtosis(double(dis_file_gray(:)));       
   feat(i, 4) = sqrt(19.3174/(2*pi*kurtosis_tmp^3))*exp(-19.3174*(kurtosis_tmp-2.7292)^2/(2*(2.7292^2)*kurtosis_tmp));
        
  %% skewness value
   skewness_tmp = skewness(double(dis_file_gray(:)));
   feat(i, 5) = 1/(sqrt(2*pi)*0.6319)*exp(-(skewness_tmp-0.1799)^2/(2*0.6319^2));

I_center_HSV=rgb2hsv(I_center);
feat(i, 6)=mean2(I_center_HSV(:,:,2)); % Saturation feature
%==========================================================================
I_V = I_center_HSV(:,:,3);   % The HSV_V value, or the brightness layer.
I_histeq=I_center_HSV;
I_histeq(:,:,3) = histeq(I_V);
I_histeq = hsv2rgb(I_histeq);
feat(i, 7)=NIQMC1(I_center,im2uint8(I_histeq)); % Contrast feature

I_around_HSV=rgb2hsv(I_around);
feat(i, 8)=mean2(I_around_HSV(:,:,3));
feat(i, 9)=mean2(I_around_HSV(:,:,2));

feat(i,10)=abs(feat(i,8)-mean2(I_V))/mean2(I_V);
feat(i,11)=abs(feat(i,9)-feat(i,6))/feat(i,6);
%==========================================================================


%% Sharpness related feature
I_foreground_sharpness=lpc_map(0.3,0.3,I);

%% Scale1
GLCM=texture_feature(I_foreground_sharpness);
load Dic.mat; 
EA=SPARISH(I_foreground_sharpness,Dic,6,1); % no pooling is adopted
TR=fsi(I_foreground_sharpness);
NS=niqe(I_foreground_sharpness);
feat=[feat GLCM TR EA NS];

%% Scale2
I_foreground_sharpness2=imresize(I_foreground_sharpness,0.5);
GLCM2=texture_feature(I_foreground_sharpness2);
EA2=SPARISH(I_foreground_sharpness2,Dic,6,1); % no pooling is adopted
TR2=fsi(I_foreground_sharpness2);
NS2=niqe(I_foreground_sharpness2);
feat=[feat GLCM2 TR2 EA2 NS2];


I_1=imresize(I,0.25);
[~,LPC]=lpc_si(rgb2gray(I_1));
[m,n,~]=size(LPC);
LPC_topleft=LPC(1:round(m/5),1:round(n/5),:);
LPC_topright=LPC(1:round(m/5),n-round(n/5)+1:n,:);
LPC_bottomleft=LPC(m-round(m/5)+1:m,1:round(n/5),:);
LPC_bottomright=LPC(m-round(m/5)+1:m,n-round(n/5)+1:n,:);
LPC_around=[LPC_topleft LPC_topright; LPC_bottomleft LPC_bottomright];
CA=mean2(LPC_around);
feat=[feat CA];



%% Highlight suppressing feature
feat_highlight=highlight_suppressing_feature(I,200);
feat=[feat feat_highlight];

toc


function gg = NIQMC1(im1,im2)
%==========================================================================
% 1) Please cite the paper (K. Gu, W. Lin, G. Zhai, X. Yang, W. Zhang, and 
% C. W. Chen, "No-reference quality metric of contrast-distorted images
% based on information maximization," IEEE Trans. Cybernetics, 2017, in 
% press.)
% 2) If any question, please contact me through guke.doctor@gmail.com; 
% gukesjtuee@gmail.com. 
% 3) Welcome to cooperation, and I am very willing to share my experience.
%==========================================================================
% if size(im,3) == 1
% im(:,:,1:3) = repmat(im,[1,1,3]);
% end
% aa = 0.8;
% uu = 0.2:0.2:1;
% tt = 7;
%% Preprocessing
im1 = double(rgb2gray(im1));
im2 = double(rgb2gray(im2));
% im2 = bfilter(im1/255,1,[3,0.1],tt)*255;
% im3 = armodel(im1,tt);
% im4 = aa*im2+(1-aa)*im3;
% im4 = im4(1:tt:end,1:tt:end);
% sal = fes_index(im);
% sal = imresize(sal,size(im4));
% %% Local Measure
% [vv,vv] = sort(sal(:),'descend');
% for i = 1:length(uu)
% ww = uint8(im4(vv(1:round(uu(i)*end))));
% pp = hist(ww,0:4:255);
% pp = (1+256*pp)/sum(1+256*pp);
% zz(i) = -sum(pp.*log2(pp));
% end
% ff = max(zz);
%% Global Measure
qq = 0:2:255;
rr = hist(im1(:),qq);
uu = hist(im2(:),qq);
rr = (1+2*rr)/sum(1+2*rr);
uu = (1+2*uu)/sum(1+2*uu);
%uu = ones(1,numel(qq))/sum(ones(1,numel(qq)));
gg = kldiv(qq,uu,rr,'js');


%=======================================================
function KL = kldiv(varValue,pVect1,pVect2,varargin)
if ~isequal(unique(varValue),sort(varValue)),
warning('KLDIV:duplicates','X contains duplicate values. Treated as distinct values.')
end
if ~isequal(size(varValue),size(pVect1)) || ~isequal(size(varValue),size(pVect2)),
error('All inputs must have same dimension.')
end
% Check probabilities sum to 1:
if (abs(sum(pVect1) - 1) > .00001) || (abs(sum(pVect2) - 1) > .00001),
error('Probablities don''t sum to 1.')
end
if ~isempty(varargin),
switch varargin{1},
case 'js',
logQvect = log2((pVect2+pVect1)/2);
KL = .5 * (sum(pVect1.*(log2(pVect1)-logQvect)) + ...
sum(pVect2.*(log2(pVect2)-logQvect)));
case 'sym',
KL1 = sum(pVect1 .* (log2(pVect1)-log2(pVect2)));
KL2 = sum(pVect2 .* (log2(pVect2)-log2(pVect1)));
KL = (KL1+KL2)/2;
otherwise
error(['Last argument' ' "' varargin{1} '" ' 'not recognized.'])
end
else
KL = sum(pVect1 .* (log2(pVect1)-log2(pVect2)));
end
