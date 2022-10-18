#!/bin/bash
#gerpit.sh
JOB=$1
SPE=$2
GERP_LOC=$3
HAL_ALIGNMENT=$4
WRKDIR=$5
##make space for job
mkdir ${WRKDIR}/output/${JOB}
cd ${WRKDIR}/output/${JOB}
##original way of pulling elements from bed, line by line. Now we give it a specific bed.
#sed -n ${JOB}p ${BED} > ${JOB}.bed
##get the maf from the hal file, specific to the bed coordinates

hal2maf --refGenome ${SPE} --refTargets ${WRKDIR}/input/${JOB}.bed --noDupes --noAncestors --global --onlyOrthologs --unique ${HAL_ALIGNMENT} ${JOB}.maf

##strip the header, then the tree for gerp++
sed -i 2d ${JOB}.maf

##the following will stitch together the individual alignment fragments from a maf produced by hal2maf. Care is taken to infer and fill in gaps not reported in the maf, which would otherwise lead to an inaccurate alignment.
egrep -nr "^$" ${JOB}.maf | sed 's/://g' | awk '{ print prev"\t"$0} { prev = $0 }'| sed 1d | awk '{print $1+2","$2-1}' > list.txt
for x in $(seq 1  1 $(wc -l list.txt | cut -f1 -d" ")) ; do TMP=$(sed -n ${x}p list.txt) ; sed -n ${TMP}p ${JOB}.maf | sed 's/\./\t/g' | awk '{ print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8}' > maf_part${x}.txt ; done
BREAKS=$(wc -l list.txt)
python ${WRKDIR}/src/maf2fa.py $BREAKS
sed -e 's/^/>/g' prep.txt | sed -e 's/\t/\n/g' > out.fa

##run gerp,append to bed coordinates and calculate neutral and RS averages for all_mean. Output only the first elem for all_el.gerp
${GERP_LOC}/gerpcol -a -f out.fa -t ${WRKDIR}/src/tree.txt -e ${SPE} -j

##output scores for individual sites
while read line ; do bits=($line) ; for x in $(seq ${bits[1]} 1 ${bits[2]}) ; do echo $x | Y=${bits[0]} awk '{print ENVIRON["Y"]"\t"$1"\t"$1+1}' >> tmp.bed ; done ; sed '$d' tmp.bed | paste - out.fa.rates >> ${WRKDIR}/output/${JOB}.ind.bed ; done < ${WRKDIR}/input/${JOB}.bed

awk '{ total += $2} END { print total/NR }' out.fa.rates > out.fa.rates2
awk '{ total += $1} END { print total/NR }' out.fa.rates > out.fa.rates3
paste ${WRKDIR}/input/${JOB}.bed out.fa.rates3 out.fa.rates2 >> ${WRKDIR}/output/${JOB}.all_mean.gerp

############
############
#Hash this out if you want to keep intermediate files

#tidy up
cd ..
rm -r ${WRKDIR}/output/${JOB}
##end script

