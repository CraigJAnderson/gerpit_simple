## Gerpit simple

Simplified version of gerpit- requires a bed file in input folder, as well as a 4d tree and hal alignment in src folder.

There is a toy bed file and affiliated output data in these folders, respectively. There's a conda environment to run everything as I have.
<pre>
conda env create --name cactus --file=environment.yml
conda activate cactus
</pre>

IMPORTANT: 1 bed feature per input file

All the intermediate files are retained for the toy example- hash out line 43 of gerpit.sh if you want to keep the ones you generate
<pre>
#set WRKDIR variable as path with gerpit
#set BIN as path to GERPplusplus
#Run as:
cd ${WRKDIR}
${WRKDIR}/gerpit.sh test_15001 C3H_HeJ ${BIN}/GERPplusplus ${WRKDIR}/src/1509_ca.hal ${WRKDIR}

#specifically, the input is:
#JOB=$1 : Job number or the name used for the input and output files
#SPE=$2 : Species name reference in the hal alignment that the bed is derived from
#GERP_LOC=$3 : path to GERPplusplus directory
#HAL_ALIGNMENT=$4 : path to hal directory
#WRKDIR=$5 : path to where this folder is
</pre>
