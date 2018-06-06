#!/bin/sh


export PATH="/home/zhaoxiao/anaconda3-xhzhao/bin:$PATH"
#export MPICH_MAX_THREAD_SAFETY=multiple

export KMP_AFFINITY=compact,1,0,granularity=fine
export OMP_NUM_THREADS=56

lscpu
which python


echo "runing DS2 on AN4 dataset with $1 node"
n=$1
if [ $1 == 1 ]; then
    python train.py  --rnn-type gru --hidden-size 800 --hidden-layers 5 --train-manifest data/an4_train_manifest.csv --val-manifest data/an4_val_manifest.csv --epochs 100 --num-workers 1  --batch-size 32 --learning-anneal 1.01 --augment
fi
if [ $1 -ge 2 ]; then
    if [ $2=='opa' ]; then
        export I_MPI_FABRICS=tmi
        export I_MPI_TCP_NETMASK=ib0
    else
        export I_MPI_FABRICS=tcp
        export I_MPI_TCP_NETMASK=enp134s0f0
    fi

    mpirun -n $n -ppn 1 -f host_n"$n".txt  python -u train.py  --rnn-type gru --hidden-size 800 --hidden-layers 5 --train-manifest data/an4_train_manifest.csv --val-manifest data/an4_val_manifest.csv --epochs 100 --num-workers 1  --batch-size $(( 32 / n)) --learning-anneal 1.01 --augment --dist-backend mpi --world-size $1
fi
