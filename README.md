# GWAS_BMI
The GWAS script for BMI in short and tall people using UKB samples

The GWAS script from "Genome-wide analyses point to differences in genetic architecture of BMI between tall and short people". 

We ran a GWAS of BMI on 7,904,644 HapMap3 SNPs (MAF=0.01, imputation quality > 0.8) in UKB samples using PLINK2 in linear regression models in both short (< 33% height quantile) and tall individuals (> 67% height quantile). To improve computational efficiency, we firstly conducted mixed linear models of BMI on sex, age, square of age, recruitment center, genotyping chips and 10 PCs calculated from genotyped SNPs for UKB QCed samples, and then the residuals of that model were used as input data for GWASs. 
