source activate pytorch-xhzhao

export KMP_AFFINITY=compact,1,0,granularity=fine
export OMP_NUM_THREADS=40

python -m cProfile -o output.pstats train.py --train-manifest data/an4_train_manifest.csv --val-manifest data/an4_val_manifest.csv --num-workers 1  
    #--num-workers 1  --batch-size 20 --learning-anneal 1.01 --augment

