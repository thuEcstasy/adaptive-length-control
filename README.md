## Quick Startup

1. Create Environment

```
pip install -e verl
pip install packaging
pip install ninja
pip install flash-attn --no-build-isolation
pip install -e .
```

**Note: You may see `Dependency Conflict: antlr4-python3-runtime Version Mismatch` after installing the packages, but it won't cause any troubles in the training process.**

2. Prepare Dataset

Generate data for traininng L1-Exact:

```
python scripts/data/deepscaler_dataset.py 
```

3. Train Models

Change `MODEL_PATH` to the model you want to finetune.

In `/script/train/run_l1_exact.sh`, change these paths to the path for the dataset that you prepared.
```
data.train_files=.../train.parquet\
data.val_files=.../aime.parquet \
```

Login your wandb and huggingface account:
```
wandb login
huggingface login
```

Finally we can start our training process:
```
./script/train/run_l1_exact.sh
```

4. Evaluation

```
cd eval
./eval.sh
```

## Acknowledgments

- We would like to thank DeepSeek for releasing Deepseek-r1 and distilled models, 
- Qwen for releasing super-awesome Qwen-2.5 math Models, and 
- [Agentica](https://github.com/agentica-project/deepscaler) for codebase, and opensourcing their models and datasets! This codebase is built on top of their work.


## Citation

If you use L1/LCPO in your research, please cite:

```bibtex
@misc{aggarwal2025l1controllinglongreasoning,
  title={L1: Controlling How Long A Reasoning Model Thinks With Reinforcement Learning}, 
  author={Pranjal Aggarwal and Sean Welleck},
  year={2025},
  eprint={2503.04697},
  archivePrefix={arXiv},
  primaryClass={cs.CL},
  url={https://arxiv.org/abs/2503.04697}, 
}
```


