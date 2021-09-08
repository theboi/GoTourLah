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

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP over IPv4
s.bind((socket.gethostname(), 1234))

#time_int = random.randint(1,9999)
packet_seq = random.randint(1, 9999) # https://en.wikipedia.org/wiki/Real-time_Transport_Protocol

cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH, k.CAMERA_WIDTH)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, k.CAMERA_HEIGHT)
cap.set(cv2.CAP_PROP_FPS, 15)

baseRTP = RTP(
    marker=True,
    payloadType=PayloadType.L16_2chan,
    # extension=Extension(
    #     startBits=0,
    #     headerExtension=0
    # ),
    # ssrc=185755418
)

while True:
  image: np.ndarray
  isSuccess, image = cap.read()
  if not isSuccess:
    print("Camera Error")
    break

  image = cv2.resize(image, (k.CAMERA_WIDTH, k.CAMERA_HEIGHT))
  image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

  isEncoded, buffer = cv2.imencode('.jpg',image,[cv2.IMWRITE_JPEG_QUALITY,80])
  if not isEncoded:
    print("JPG Encoding Error")
    break
  
  payload = bytearray(buffer)

  nextRTP = deepcopy(baseRTP)
  nextRTP.sequenceNumber += 1
  nextRTP.timestamp = int(time.time())
  nextRTP.payload = payload

  data = nextRTP.toBytearray()
  s.sendto(data, (socket.gethostname(), 1447))

  packet_seq += 1

  time.sleep(2)

s.close()
cap.release()
