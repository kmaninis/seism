#/bin/bash
for i in {2000..10000..2000}
	do
	{
		qsub -N FbrgbHHA$i -t 1-101 src/scripts/eval_in_cluster.py ResNet50_nyud_rgbHHA_ft_$i NYUD-v2 read_one_cont_png fb 1 101
	};
	done


