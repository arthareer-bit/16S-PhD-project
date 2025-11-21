##0. copy file from drive D to ubuntu
#cp -r "/mnt/d/1. Desktop/AR_PhD/6. Laboratory/2. Experiment/Nanopore/2. Sequencing result/1. 16s_Dog/1. Raw data/4. 11 Apr 25_CB_PL/4. SUP_pass_program
#freezed_11 Apr 25" ~/


## 1. cat file
        ## to make dog4_com directory
#mkdir -p dog4_com

        ## to cat file
#for i in {49..50}
#do
#zcat barcode${i}/*.fastq.gz > dog4_com/bar${i}_com.fastq.gz
#done


## 2. nanoqc
#nanoQC bar01_com.fastq


## 3. grep primer by

## make dog4_good directory
# mkdir -p dog4_good

#for i in dog4_com/bar*
#do
#  echo "Processing $i ..."
#  bname=$(basename "$i" .fastq.gz)  # e.g. bar49
#  out="dog4_good/${bname}_good.fastq.gz"

# {
#      grep -E -e "ACTTGCCTGTCGCTCTATCTTC" $i -B1 -A2 | \
#      grep -E -e "GCAATATCAGCACCAACAGAAA" $i -B1 -A2
#      grep -E -e "TTTCTGTTGGTGCTGATATTGC" $i -B1 -A2 | \
#      grep -E -e "GAAGATAGAGCGACAGGCAAGT" $i -B1 -A2
#  } | sed '/^--$/d' | gzip > "$out"
#done


## 4. porechop by
#mkdir -p dog4_pc

#for i in dog4_good/bar*; do
#  echo "Processing $i ..."
#  bname=$(basename "$i" .fastq.gz)  # e.g. bar49
#  out="dog4_pc/${bname}_pc.fastq.gz"

#porechop -i "$i" --verbosity 2 --discard_middle | gzip > "$out"       ## porechop -i "$i" -o "$out" --verbosity 2 --discard_middle
#done


## 5. chopper by
# mkdir -p dog4_chp
# for i in dog4_pc/bar*
# do
# echo "Processing $i ..."
# bname=$(basename "$i" .fastq.gz)
# out="dog4_chp/${bname}_chp.fastq.gz"
# chopper -q 10 -l 1300 --maxlength 1700 -i "$i" > "$out"
# done


## 6. emu abundance by

## 6.0 Installation by
## 6.0.1 Dowload database by
        # pip install osfclient
        # export EMU_DATABASE_DIR=<path_to_database>
        # cd ${EMU_DATABASE_DIR}
        # osf -p 56uf7 fetch osfstorage/emu-prebuilt/emu.tar
        # tar -xvf emu.tar

## 6.0.2 Activate appropriate conda environment
        # conda create --name py37 python=3.7
        # conda activate py37

## 6.0.3 Install Emu by using option B
        # conda env create -f environment.yml
        # conda activate custom-emu

## 6.0.4 then compile two file .tsv and .fasta in the database

## 6.1 create databsae osf
#emu create database/example.fasta > database/db.fasta

## 6.2 annotation
# mkdir result_test
for i in $(ls -d sample_test/bar*);
do
   #step 6.2.1 prepare folder and name
   echo $i
   name_02=$(echo $i | cut -d '/' -f2 | cut -d '.' -f1)
   echo $name_02
   mkdir -p result/${name_02}

   #step 6.2.2 run emu
   #emu abundance $i --db database/ --output-dir result_test/${name_02}/result_emu  ## <path to emu> ./emu abundance example/full_length.fa

   #step 6.2.3 curate result
   #awk -v sample=$name_02 'BEGIN{OFS="\t"} {print $0, sample}' result_test/${name_02}/result_emu/${name_02}_rel-abundance.tsv > result_test/${name_02}/res>

done

##############################################################################################################################################################














