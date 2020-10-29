#!/bin/bash
#$ -l h_rt=00:05:00
#$ -l h_vmem=10G
#$ -N GWAS_ukb
#$ -M b.lin@umcutrecht.nl
#$ -m eas
#$ -e /hpc/hers_en/blin/UkBiobank/GWAS
#$ -o /hpc/hers_en/blin/UkBiobank/GWAS


rm GWAS_chr*_ukb.sh
for chr in {1..22}; do

echo "#!/bin/bash" > GWAS_chr${chr}_ukb.sh
echo "#$ -l h_rt=200:00:00 " >> GWAS_chr${chr}_ukb.sh
echo "#$ -l h_vmem=100G  " >> GWAS_chr${chr}_ukb.sh
echo "#$ -N GWAS_ukb  " >> GWAS_chr${chr}_ukb.sh
echo "#$ -M b.lin@umcutrecht.nl  " >> GWAS_chr${chr}_ukb.sh
echo "#$ -m eas  " >> GWAS_chr${chr}_ukb.sh
echo "#$ -e /hpc/hers_en/blin/UkBiobank/GWAS  " >> GWAS_chr${chr}_ukb.sh 
echo "#$ -o /hpc/hers_en/blin/UkBiobank/GWAS  " >> GWAS_chr${chr}_ukb.sh
echo "cd /hpc/hers_en/blin/UkBiobank/GWAS   " >> GWAS_chr${chr}_ukb.sh

geno=/hpc/ukbiobank/genetic_v3/ukb_imp_chr${chr}_v3.bgen
sample=/hpc/hers_en/blin/UkBiobank/Pheno/Pheno_round2_SNPtest.sample
genotype=/hpc/ukbiobank/genetic_v3/ukb_imp_chr22_v3.bgen
pheno=/hpc/hers_en/blin/UkBiobank/Pheno/Pheno_round2_SNPtest.pheno
SNP=/hpc/hers_en/blin/UkBiobank/Post_GWAS/QC_INFO08_MAF_001_chr${chr}.txt
short=/hpc/hers_en/blin/UkBiobank/Pheno/Individual_height_33_quantile.txt
tall=/hpc/hers_en/blin/UkBiobank/Pheno/Individual_height_67_quantile.txt

echo " ./plink2  --bgen "${geno}" --pheno "${pheno}" --sample "${sample}"  --extract "${SNP}" --pheno-name BMI --keep "${short}"  --linear --threads 10  --out ukb_bmi_short_chr"${chr}".out " >> GWAS_chr${chr}_ukb.sh
echo " ./plink2  --bgen "${geno}" --pheno "${pheno}" --sample "${sample}"  --extract "${SNP}" --pheno-name BMI --keep "${tall}"  --linear --threads 10  --out ukb_bmi_tall_chr"${chr}".out " >> GWAS_chr${chr}_ukb.sh

done
for chr in {1..22}; do
qsub GWAS_chr${chr}_ukb.sh  -pe threaded 10 -l h_vmem=100G 
done

