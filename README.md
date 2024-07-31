# Blind Quality Assessment of Night-Time Photos: A Region Selective Approach
[Han Zongxi](https://github.com/hanzongxi/), Xie Rong

### Download the database

The night-time photo quality database (NPHD) can be downloaded at [[Baidu Drive]](https://pan.baidu.com/s/1eXZ_31c0O8NoXG0ONJ_tzQ),  password: nphd


### Quick start

The cross-validation process of our region selective IQA (RSIQA) can be run by check_performance_on_nphd.m. demo.m outputs the predicted score of a test photo.

### Experimental results 

The comparative results with 17 STOAs are in the Compare_17STOA.zip, where their predicted mos on NPHD and test code are provided. The test code of compuatational time and performance with and without region selectivee strategy are in Compare_time_perf.zip. The computaional time and performance comparsion of RSIQA with BNIQM on NNID are in Compare_on_nnid.zip.
The visual comparsion of various LIEAs are in the Compare_LIEA.zip. Deciphered source codes of NPE, LIME, SRLLIE, SRIE, PIE are in LIEA_source_code.zip, which are not easily found elsewhere.

### Additional points we don‘t explain in the paper
Q1: Why use the highlight suppressing feature set? Not every night-time scene contains highlights.


A1: Our purpose is to benchmark the quality of night-time photos of smartphones. So, from the very begining, we 
choose scenes that can be used to test three capabilities of cameras, as explained in Section 3.1. Moreover, the NNID
database contains many scenes without highlights, our RSIQA also achives good result on NNID.

Q2: Why set the quality score of six anchors to 100, 80, 60, 40, 20, 0. It seems so absolute and subjective.


A2: Setting 100 to 99, 80 to 81 is totally fine. First, MOS is obtained from the people's opinion, it has no standard answer.
Second, MOS has to be curve-fitted in the PLCC calculation. Changing the quality score of six anchors has no effect in either 
SROCC, KROCC, or PLCC. Last but not least, nearly all IQA models only care about the prediction accuracy in the statistical meaning, not 
individual difference. Thus, setting 100 to 99, or even 95 has no influence in the statistical viewpoint, if the overall trend is correct. As for the individual difference of camera quality, it depends on your own experiences, understanding and subjective preference. Actually, we think this is one of the dark side of objective IQA. Maybe your should believe your eyes, feelings more than the statistically-correct IQA, when choosing from two cameras of close quality.

Q3: What is the rank orders of night-time photos of smartphones?

A3: Interested readers could recognize the specific models of taken photos through their Exif data, and average their ranking orders in each scene.
Generally speaking, more expensive phones have better camera quality. In the author's opinion, around 2020, the quality of Pixel3 > Find X2Pro > S20+.
But the technology keeps going, for example, the samsung night-time photos improves a lot from S20+ to S23Ultra. And the iPhones have night-mode since iPhone 11.
In the authors preference, Pixel3, S23Ultra, iPhone 13 all have very good cameras. Pixel3 is known for its sharpness, naturalness, S23Ultras improves a lot in its denoising, and
its details are smoothely rendered (despite croostalks). iPhone is known for its stability, A, if not S in night-mode, bokeh, macro; S in video, color, user experience, and stability under extreme conditions (shooting directly at sun, or shooting textured phone glass back at medium indoor lighting). 


If you find our work interesting, please cite our paper. If having any questions, please contact zongxihan@sjtu.edu.cn
