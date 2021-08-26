import sys
sys.path.append("..")

import socket, cv2
import numpy as np
from rtp import RTP
import shared.k as k
import tensorflow as tf
import tensorflow_hub as hub
import pandas as pd

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP over IPv4
s.bind((socket.gethostname(), 1447))

# Loading model directly from TensorFlow Hub
detector = hub.load("https://tfhub.dev/tensorflow/efficientdet/lite2/detection/1")

# Loading csv with labels of classes
labels = pd.read_csv('labels.csv', sep=',', index_col='ID')
labels = labels['OBJECT (2017 REL.)']

print("Ready...")
while True:
  data, address = s.recvfrom(k.BUFFER_SIZE)
  print("Received.")
  s.sendto(data, address)

  payload = RTP().fromBytes(data).payload

  npdata = np.frombuffer(bytes(payload), dtype=np.uint8)
  image = cv2.imdecode(npdata, cv2.IMWRITE_JPEG_QUALITY)

  rgb_tensor = tf.convert_to_tensor(image, dtype=tf.uint8)
  rgb_tensor = tf.expand_dims(rgb_tensor, 0)

  # Creating prediction
  boxes, scores, classes, num_detections = detector(rgb_tensor)

  # Processing outputs
  pred_labels = classes.numpy().astype('int')[0] 
  pred_labels = [labels[i] for i in pred_labels]
  pred_boxes = boxes.numpy()[0].astype('int')
  pred_scores = scores.numpy()[0]

  # Putting the boxes and labels on the image
  for score, (ymin,xmin,ymax,xmax), label in zip(pred_scores, pred_boxes, pred_labels):
      if score < 0.5:
          continue
      score_txt = f'{100 * round(score)}%'
      img_boxes = cv2.rectangle(image,(xmin, ymax),(xmax, ymin),(255,0,0),2)
      font = cv2.FONT_HERSHEY_SIMPLEX
      cv2.putText(img_boxes, label,(xmin, ymax-10), font, 0.5, (0,255,0), 2, cv2.LINE_AA)
      cv2.putText(img_boxes,score_txt,(xmax, ymax-10), font, 0.5, (0,255,0), 2, cv2.LINE_AA)

  cv2.imshow("Image", image)
  if cv2.waitKey(1) & 0xFF == ord('q'):
    break

cv2.destroyAllWindows()