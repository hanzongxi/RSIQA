function img3=lpc_map(ratio1,ratio2,img)
%% 使用方法:lpc_map(0.3,0.3)
%a=rgb2gray(imread('./Sharpness/30_note9.jpg'));
%a=imresize(a,0.125);
img1=rgb2gray(img);
img2=imresize(img1,0.125);
[~,map]=lpc_si(img2);
ga=fspecial('gaussian',size(img2),100);
map_ga=map.*ga;
[m,n]=size(map_ga);

m_rec=floor(m*ratio1);
n_rec=floor(n*ratio2);
template=ones(m_rec,n_rec);
convolutionResult = conv2(map_ga, template, 'same');
%% center coordinates
[row, col]=find(convolutionResult==max(convolutionResult(:)));
left_x=floor(row-m_rec/2);
left_y=floor(col-n_rec/2);

img3=img1(8*left_x:8*left_x+8*m_rec,8*left_y:8*left_y+8*n_rec);


