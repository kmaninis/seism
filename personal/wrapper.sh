#!/bin/bash

rm ~/scratch/logs/*

#for i in {1..20}
#	do
#		qsub -N RN50-clean_$i -t 1-101 src/scripts/eval_in_cluster.py  ResNet50-neg_500_40000_clean_soft SBD  read_one_cont_png fb 1 101 $i
#	done
	
	
for i in {1..20}
	do
		qsub -N DilatedConv_$i -t 1-1 src/scripts/eval_in_cluster.py  DilatedConv SBD  read_one_cont_png fb 1 1 $i
	done
	
for i in {1..20}
	do
		qsub -N COB-dil_$i -t 1-101 src/scripts/eval_in_cluster.py  COB-dil SBD  read_one_cont_png fb 1 101 $i
	done
