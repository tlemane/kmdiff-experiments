# kmdiff-experiments

This repository contains all materials to reproduce the experiments described in the paper: XXX.

## Installation

The kmdiff dependencies must be installed before installation, see [link](https://github.com/tlemane/kmdiff#dependencies).


```bash
bash install.sh
```

```
conda env create -p kmdiff_expe --file environment.yml
conda activate ./kmdiff_expe
```

## Ampicilin resistance

### Download

```bash
cd ampicilin_resistance/data
bash download.sh
```

### kmdiff

```bash
cd ampicilin_resistance/kmdiff
bash run.sh
```

### HAWK

```bash
cd ampicilin_resistance/hawk
bash run.sh
```

## 1000 Genomes

### Download

```bash
cd 1000_genomes/data
bash download.sh
```

### kmdiff

```bash
cd 1000_genomes/kmdiff
bash run.sh
```

### HAWK

```bash
cd 1000_genomes/hawk
bash run.sh

