import tensorflow_hub as tfhub
print("Loading the model...")
model = tfhub.load('./models/metrabs_l')  # Use the local path
print("Model loaded successfully.")
