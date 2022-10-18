Gerpit by Craig Anderson
Simplified version of gerpit- requires a bed file in input folder, as well as a 4d tree and hal alignment in src folder.

IMPORTANT: 1 bed feature per input file

set WRKDIR variable as path with gerpit
set bin as path to GERPplusplus
Run as:
cd \${WRKDIR}
\${WRKDIR}/gerpit.sh 15001 C3H_HeJ \${BIN}/GERPplusplus \${WRKDIR}/src/1509_ca.hal \${WRKDIR}

specifically, the input is:
JOB=\$1 : Job number or the name used for the input and output files
SPE=\$2 : Species name reference in the hal alignment that the bed is derived from
GERP_LOC=\$3 : path to GERPplusplus directory
HAL_ALIGNMENT=\$4 : path to hal directory
WRKDIR=\$5 : path to where this folder is
