#!/bin/bash


# Default hparams
export PYTHONINTMAXSTRDIGITS=0
export VLLM_WORKER_MULTIPROC_METHOD=spawn
cuda=0
NUM_GPUS=4

while getopts g:d:s flag
do 
    case "${flag}" in 

        g) cuda=${OPTARG};;
        d) ds_size=${OPTARG};;
        s) train_with_hard=${OPTARG};;
    esac
done 


export CUDA_VISIBLE_DEVICES=$cuda
# export CUDA_LAUNCH_BLOCKING=1
export VLLM_ALLOW_LONG_MAX_MODEL_LEN=1

echo $cuda
eval "$(conda shell.bash hook)"



OUTPUT_DIR=
TASK=math_500
# TASK=gsm8k
# TASK=aime24
# TASK=aime25
# TASK=amc23
# TASK=olympiadbench
# TASK=minervamath
# TASK=gpqa:diamond

MODEL=

# MODEL_ARGS="pretrained=$MODEL,dtype=bfloat16,max_model_length=32768,gpu_memory_utilization=0.96,tensor_parallel_size=${NUM_GPUS},generation_parameters={max_new_tokens:16384,temperature:0.0,top_p:0.1}"
MODEL_ARGS="pretrained=$MODEL,dtype=bfloat16,max_model_length=32768,gpu_memory_utilization=0.96,generation_parameters={max_new_tokens:16384,temperature:0.6,top_p:0.95}"
# MODEL_ARGS="pretrained=$MODEL,dtype=bfloat16,gpu_memory_utilization=0.96,tensor_parallel_size=${NUM_GPUS},generation_parameters={max_new_tokens:32768,temperature:0.6,top_p:0.95}"
# MODEL_ARGS="pretrained=$MODEL,dtype=bfloat16,max_model_length=32768,gpu_memory_utilization=0.96,generation_parameters={max_new_tokens:16384,temperature:0.6,top_p:0.95}"
lighteval vllm $MODEL_ARGS "custom|$TASK|0|0" \
    --custom-tasks evaluate.py \
    --output-dir $OUTPUT_DIR \
    --use-chat-template \
    --save-details \
    # --system-prompt="You are a helpful assistant. You should think step-by-step and put your final answer within \\boxed{{}}."
    # --system-prompt="Please reason step by step, and put your final answer within \\boxed{}." \
    # --use-chat-template \
    # --system-prompt="Please reason step by step, and put your final answer within \\boxed{}." \