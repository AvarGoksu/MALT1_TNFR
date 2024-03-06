#!/bin/bash

# Initialize the single checksum file for all samples
checksum_file="/vol/ExtraVol/Krappmann3/20240207/checksums.txt"
> "$checksum_file"  # Clear the checksum file to start fresh

for i in {3948..3994}; do
    id=$(printf "24L%06d" $(( i )))
    sample_dir="/vol/ExtraVol/Krappmann3/20240207/Sample_${id}"
    
    # Check if sample directory exists
    if [[ -d "$sample_dir" ]]; then
        # Find the fastq.gz files and calculate their md5sums, appending to the single checksum file
        find "$sample_dir" -type f \( -name "${id}*_R1_001.fastq.gz" -o -name "${id}*_R2_001.fastq.gz" \) -exec md5sum {} \; >> "$checksum_file"
    else
        echo "Sample directory does not exist: $sample_dir" >> "$checksum_file"
    fi
done


