import tensorflow_io as tfio

video_path = "/home/bel/Metralabs/TF/metrabs/img/Video.mp4"
print("Testing TensorFlow I/O video support...")
video = tfio.IODataset.from_ffmpeg(video_path, "v:0")
for frame in video.take(1):
    print("Frame shape:", frame.shape)
