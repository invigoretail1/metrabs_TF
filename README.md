# MeTRAbs Absolute 3D Human Pose Estimator

<a href="https://colab.research.google.com/github/isarandi/metrabs/blob/master/metrabs_demo.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a><br>
[![PWC](https://img.shields.io/endpoint.svg?url=https://paperswithcode.com/badge/metrabs-metric-scale-truncation-robust/3d-human-pose-estimation-on-3d-poses-in-the)](https://paperswithcode.com/sota/3d-human-pose-estimation-on-3d-poses-in-the?p=metrabs-metric-scale-truncation-robust)

<p align="center"><img src=img/demo.gif width="60%"></p>
<p align="center"><a href="https://youtu.be/4VFKiiW9RCQ"><img src=img/thumbnail_video_qual.png width="30%"></a>
<a href="https://youtu.be/BemM8-Lx47g"><img src=img/thumbnail_video_conf.png width="30%"></a></p>


# Guidelines

- Clone the repository locally.
- Download the model files from (https://bit.ly/metrabs_l) and extract the content at ```demos/models/metrabs_l/```
- Create a mamba environment for this using ```mamba env create -f environment1.yml```
- Activate the environment using ``` mamba activate metrabs_envf ```
- Run the following command
  ```
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda-11.8/lib64:$HOME/.local/lib/python3.9/site-packages/nvidia/cudnn/lib:/home/bel/miniconda3/envs/metrabs_envf/lib:/home/bel/miniconda3/envs/metrabs_envf/lib/python3.9/site-packages/tensorflow:/home/bel/miniconda3/envs/metrabs_envf/lib/python3.9/site-packages/tensorflow_io/python/ops:/usr/lib/x86_64-linux-gnu
  ```
- After this go the demos folder ``` cd demos ``` and run
  ``` python demo_video.py /home/bel/Metralabs/TF/metrabs/img/Video.mp4 ```


### Feature Summary

- **Several skeleton conventions** supported through the keyword argument ```skeleton``` (e.g. COCO,
  SMPL, H36M)
- **Multi-image (batched) and single-image** predictions both supported
- **Advanced, parallelized cropping** logic behind the scenes
    - Anti-aliasing through image pyramid and
      supersampling, [gamma-correct rescaling](http://www.ericbrasseur.org/gamma.html).
    - GPU-accelerated undistortion of pinhole perspective (homography) and radial/tangential lens
      distortions
- Estimates returned  in **3D world space** (when calibration is provided) and **2D pixel space**
- Built-in, configurable **test-time augmentation** (TTA) with rotation, flip and brightness (keyword
  argument ```num_aug``` sets the number of TTA crops per detection)
- Automatic **suppression of implausible poses** and non-max suppression on the 3D pose level (can be turned off)
- **Multiple backbones** with different speed-accuracy trade-off (EfficientNetV2, MobileNetV3)

## Training and Evaluation

See the docs directory.



## Contact

Code in this repository was written by [István Sárándi](https://isarandi.github.io) (RWTH Aachen
University) unless indicated otherwise.

Got any questions or feedback? Drop a mail to sarandi@vision.rwth-aachen.de!
