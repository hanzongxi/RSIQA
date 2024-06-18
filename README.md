# Blind Quality Assessment of Night-Time Photos: A Region Selective Approach
[Zongxi Han](https://github.com/hanzongxi/), Xie Rong

### Download the database

The night-time photo quality database (NPHD) can be downloaded at [[Baidu Drive]](https://pan.baidu.com/s/1eXZ_31c0O8NoXG0ONJ_tzQ),  password: nphd


### Quick start

The cross-validation process of our region selective IQA (RSIQA) can be run by check_performance_on_nphd.m. demo.m outputs the predicted score of a test photo.

### Experimental results 

The comparative results with 17 STOAs are in the Compare_17STOA.zip, where their predicted mos on NPHD and test code are provided. The test code of compuatational time and performance with and without region selectivee strategy are in Compare_time_perf.zip. The computaional time and performance comparsion of RSIQA with BNIQM on NNID are in Compare_on_nnid.zip.
The comparsion results of LIEAs are in the Compare_LIEA.zip, whose source code can be found in LIEA_source_code.zip.

If you find this work useful, please cite our paper. If having any questions, please contact zongxihan@sjtu.edu.cn
