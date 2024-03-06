#!/bin/bash

for i in {3948..3994}; do
    id=$(printf "24L%06d" $(( i )))
    file1=$(find /vol/ExtraVol/Krappmann3/20240207/Sample_${id}/ -type f -name "${id}*_R1_001.fastq.gz" -print -quit)
    file2=$(find /vol/ExtraVol/Krappmann3/20240207/Sample_${id}/ -type f -name "${id}*_R2_001.fastq.gz" -print -quit)

    if [[ -f "$file1" ]] && [[ -f "$file2" ]]; then
        /home/ubuntu/STAR/source/STAR \
            --genomeDir /vol/ExtraVol/Krappmann3/indexedGenome \
            --runMode alignReads \
            --readFilesIn "$file1" "$file2" \
            --runThreadN 28 \
            --outSAMtype BAM Unsorted \
            --twopassMode Basic \
            --outSAMunmapped Within \
            --outFileNamePrefix /vol/ExtraVol/Krappmann3/20240207/star_out/Sample_${id} \
            --readFilesCommand zcat \
            --outSAMmultNmax 1
    else
        echo "WARNING: Could not find expected files for sample ${id}"
    fi
done


