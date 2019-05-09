# Facial Emotion Recognition
Code and workflow for building some emotion recognition models on PSU
ACI HPC clusters.

## Quick Start
`ssh` into the PSU ACI HPC with X11 flags.

```
ssh USERID@aci-b.aci.ics.psu.edu -X -Y
```

Start an interactive session using `qsub`.

```
qsub -A open -I -X -l walltime=24:00:00 -l nodes=5:ppn=10 -l pmem=20gb
```

Start the container, and execute the `video_analysis.py` script.

```
singularity pull -n emorec_aci.simg shub://d-bohn/emorec_aci:16.04

singularity exec emorec_aci.simg /bin/bash

python3 /opt/emorec/video_analysis.py VIDEOFILE OUTDIR SAVENAME
```

**IMPORTANT: You must specify that you want the 16.04 version of this build,
as the master branch runs on too new a kernel**

The arguments to be passed (in order) are:

  - **VIDEOFILE**: Full path to video file to be analyzed

  - **OUTDIR**: Full path to a writable director to store
  results (e.g., `/storage/home`)

  - **SAVENAME**: File name to save the results (e.g., `data.csv`).
  It will save automatically to the specified output directory.

## Image Builds
The emorec_aci docker image was built on docker hub.

The emorec_aci singularity image was built using the docker image base and
converting it to a singularity image via singularity hub.

Setup for linking Github with Docker Hub and Singularity Hub can be found here:

  - [docker Hub](https://docs.docker.com/docker-hub/)
  - [Singularity Hub](https://github.com/singularityhub/singularityhub.github.io/wiki)

The `Singularity` file specifies creating a Singularity-compatible image
from the docker image, as well as adding access to folders within ACI,  specifically:
```
# ACI mappings so you can access your files.
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/group
```

## Notes
  - The kernel on PSU ACI is too old to run Ubuntu 18.04, so I had to
  downgrade to Ubuntu 16.04 and shoehorn in Python3.6

  - Create command function for automatic execution of `video_analysis.py`
    script

  - Add a `ArgumentParser` and help files.
