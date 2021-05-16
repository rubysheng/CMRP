#!/usr/bin/bash
#title          :section2.1_header_and_aa.sh
#description    :The preparation for ortholog searching - rename header of sequences and predict amino acid sequences
#author         :Ruby(Yiru) Sheng
#usage          :source $CMRP_PATH/script/section2.1_header_and_aa.sh -l input_dir_list -o output_dir
#input files    :a list of target directories with absolute paths which can find *fasta.RSEM.transcripts.fa
#output files   :renamed Fasta files and gene_trans_map ...
#bash_version   :4.4.19(1)-release
#=======================================================================================================================


OPTIND=1         # Reset in case getopts has been used previously in the shell.
input_dir=""
output_dir=""
list=""

while getopts "h?:l:o:" opt; do
    case "$opt" in
    h)
        echo "-l is a required list with input directories (to find the raw FASTA files) "
        echo "-o is a required output directory"
        echo "-h shows this help message"
        echo "press Ctrl+C to exit"
          # exit 0
        ;;
    l) list=$OPTARG
        ;;
    # e) end_output=$OPTARG
    #     ;;
    o) output_dir=$OPTARG
        if [[ "${output_dir: -1}" != '/' ]]; then
            output_dir=${output_dir}"/"
        fi
        #mkdir -p ${output_dir}
    esac
done
shift $(( OPTIND-1 ))



function preprocessFA() {
  TAX_CODE="$1"
  OUT_DIR="$2"
  file=`basename $(pwd)`
  FA_NEWNAME="${file}_RSEM.fasta"
  MAP_NEWNAME="${file}_RSEM.gene_trans_map"
  PE_NAME="${FA_NEWNAME}.transdecoder.pep"
  PE_NEWNAME="${file}_pep.fasta"
  # change fasta file and gene_trans_map file format
  if [ ! -e ${FA_NEWNAME} ]; then
    echo "No renamed file"
    echo "    Reformating Trinity.fasta.RSEM.transcripts.fa to "${FA_NEWNAME}
    echo
    find . -name "Trinity.fasta.RSEM.transcripts.fa" -exec cp -v {} ./tmp.transcripts.fa \;
    sed "s+TRINITY+${file}+g" tmp.transcripts.fa > ${FA_NEWNAME}
    rm -v tmp.transcripts.fa
    sed -i "s/_/./g" ${FA_NEWNAME}
    echo "Adding the taxon code"
    sed -i "s/>/>${TAX_CODE}_/g" ${FA_NEWNAME}
  fi
  # change the header of gene_trans_map
  if [ ! -e ${MAP_NEWNAME} ]; then
    echo "No renamed gene_trans_map"
    echo "    Reformating Trinity.fasta.gene_trans_map to "${MAP_NEWNAME}
    find . -name "Trinity.fasta.gene_trans_map" -exec cp -v {} ./${MAP_NEWNAME} \;
    sed -i "s/_/./g" ${MAP_NEWNAME}
    echo "Adding the taxon code"
    sed -i "s+TRINITY+${TAX_CODE}_${file}+g" ${MAP_NEWNAME}
  fi
  # protein sequence prediction
  if [ ! -e ${PE_NAME} ]; then
    echo "Translate to protein sequence"
    echo
    TransDecoder.LongOrfs -t ${FA_NEWNAME} --gene_trans_map ${MAP_NEWNAME}
    TransDecoder.Predict -t ${FA_NEWNAME}
  fi
  if [ ! -e "tmp.fa" ]; then
    echo "Renaming "${PE_NAME}" to "${PE_NEWNAME}"."
    cp ${PE_NAME} ${PE_NEWNAME}
    echo "Reformating "${PE_NEWNAME}
    awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' ${PE_NEWNAME} > tmp.fa
    printf "\n" >> tmp.fa
    echo "Shortening the header of sequences"
    awk '/>/ { print $1; getline; print $0 }' tmp.fa > ${PE_NEWNAME}
    echo "Moving to the input directory"
    cp -v ${PE_NEWNAME} ${OUT_DIR}
  fi
}

if [ ! "${list}" = "" ]; then # have a input list
  input_dir="$(pwd)/input/"
  base_dir="$(pwd)"
  checkarray=()

  if [ ! -e ${input_dir} ]; then
    echo "Creating the input directory to hold all protein fasta files"
    mkdir -v ${input_dir}
  fi

  while IFS=" " read -r f1 f2
  do
    printf 'Taxonomy_code: %s, Dir: %s\n' "$f1" "$f2"
    echo
    SP_CODE="$f1"
    DIR="$f2"
    mvd_pep=`basename ${DIR}`"_pep.fasta"
    cd ${DIR}
    if [ ! -e ${mvd_pep} ]; then
      preprocessFA ${SP_CODE} ${input_dir}
      echo
      echo "Check if the file is prepared in "${input_dir}
      cd ${input_dir}

      if [ ! -e ${mvd_pep} ]; then  # test if the pep file is moved to the destination
        echo "No file named "${mvd_pep}" moved to input directory"
      fi
    else
      cd ${input_dir}/..
      find ${input_dir} -name ${mvd_pep} -exec ls -l {} \;
      acc=`basename ${DIR}`
      echo ${acc}
      checkarray+=("${acc}")
      echo ${checkarry}
    fi
  done < "${list}"
  cd ${input_dir}/..
  count_l=`wc -l < ${list}`
  echo ${count_l}
  echo ${#checkarray[@]}
fi

echo `pwd`
if [ ! "${output_dir}" = "" ] && [ "${#checkarray[@]}" = "${count_l}" ]; then
  if [ -d "${output_dir}" ]; then
    rm -r -v ${output_dir}
  fi
  echo
  echo "Please run the following command mannually"
  echo
fi
