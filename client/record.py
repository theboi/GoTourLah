import sys
sys.path.append("..")

import cv2, imutils
import random
import time
import socket
from copy import deepcopy
from rtp import RTP, Extension, PayloadType
import shared.k as k
import numpy as np

cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH, k.CAMERA_WIDTH)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, k.CAMERA_HEIGHT)
cap.set(cv2.CAP_PROP_FPS, 15)

writer= cv2.VideoWriter('basicvideo.mp4', cv2.VideoWriter_fourcc(*'DIVX'), 20, (k.CAMERA_WIDTH,k.CAMERA_HEIGHT))

while True:
  image: np.ndarray
  isSuccess, image = cap.read()
  if not isSuccess:
    print("Camera Error")
    break

  image = cv2.resize(image, (k.CAMERA_WIDTH, k.CAMERA_HEIGHT))
  # image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

  isEncoded, buffer = cv2.imencode('.jpg',image,[cv2.IMWRITE_JPEG_QUALITY,80])
  if not isEncoded:
    print("JPG Encoding Error")
    break

  time.sleep(0.1)

cap.release()
