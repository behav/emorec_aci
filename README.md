# openpose_aci
Code and workflow for building some emotion recognition models on PSU
ACI HPC clusters.

## Quick Start
`ssh` into the PSU ACI HPC with X11 flags.

```
ssh USERID@aci-b.aci.ics.psu.edu -X -Y
```

Start an interactive session using `qsub`. We need a lot of memory for the CPU version
of OpenPose

```
qsub -A open -I -X -l walltime=24:00:00 -l nodes=5:ppn=10 -l pmem=20gb
```


## Image Builds
The OpenPose docker image was built on docker hub.

The OpenPose singularity image was built using the docker image base and
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
mkdir -p /storage/scratch
mkdir -p /gpfs/group
```

## Notes
    - Create command function for automatic execution of `video_analysis.py`
    script
