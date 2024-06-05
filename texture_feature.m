
function feat = texture_feature(img)

if numel(size(img))>2     %% Is a rgb image ?
    img = rgb2gray(img);
else
    img = img;
end

feat = [];

glcm = graycomatrix(img,'Offset',[0 1; -1 1;-1 0;-1 -1]);
stats = graycoprops(glcm,{'contrast','Energy','homogeneity'});

ee = stats.Energy;
cc = stats.Contrast;
hh = stats.Homogeneity;

feat = [mean(ee) std(ee) mean(cc) std(cc) mean(hh) std(hh)];

end