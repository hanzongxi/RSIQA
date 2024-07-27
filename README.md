# Blind Quality Assessment of Night-Time Photos: A Region Selective Approach
[Zongxi Han](https://github.com/hanzongxi/), Xie Rong

### Download the database

The night-time photo quality database (NPHD) can be downloaded at [[Baidu Drive]](https://pan.baidu.com/s/1eXZ_31c0O8NoXG0ONJ_tzQ),  password: nphd


### Quick start

The cross-validation process of our region selective IQA (RSIQA) can be run by check_performance_on_nphd.m. demo.m outputs the predicted score of a test photo.

### Experimental results 

The comparative results with 17 STOAs are in the Compare_17STOA.zip, where their predicted mos on NPHD and test code are provided. The test code of compuatational time and performance with and without region selectivee strategy are in Compare_time_perf.zip. The computaional time and performance comparsion of RSIQA with BNIQM on NNID are in Compare_on_nnid.zip.
The comparsion results of LIEAs are in the Compare_LIEA.zip, whose source code can be found in LIEA_source_code.zip.

### Additional points not explained in the paper
Q1: Why use the highlight suppressing feature set? Not every night-time scene contains highlights.


A1: Our purpose is to benchmark the quality of night-time photos of smartphones. So, from the very begining, we 
choose scenes that can be used to test three capabilities of cameras, as explained in Section 3.1.

Q2: Why set the quality score of six anchors to 100, 80, 60, 40, 20, 0. It seems so absolute and subjective.


A2: Setting 100 to 99, 80 to 81 is totally fine. First, MOS is obtained from the people's opinion, it has no standard answer.
Second, MOS has to be curve-fitted in the PLCC calculation. Changing the quality score of six anchors has no effect in either 
SROCC, KROCC, or PLCC. Last but not least, nearly all IQA models only care about the prediction accuracy in the statistical meaning, not 
individual difference. Thus, setting 100 to 99, or even 95 has no influence in the statistical viewpoint. As for the individual difference of camera quality, it depends on your own experiences, understanding and subjective preference. Actually, we think this is one of the dark side of objective IQA.

If you find this work useful, please cite our paper. If having any questions, please contact zongxihan@sjtu.edu.cn
