import pandas as pd
from tensorflow.keras.preprocessing.sequence import pad_sequences

def preprocess_urls(urls):
    return pad_sequences([[1,2,3]] * len(urls), maxlen=10)

def classify_urls(urls):
    processed = preprocess_urls(urls)
    return [0.8 for _ in urls]