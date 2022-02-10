import sys
sys.path.append("..")

import time
import cv2, imutils
import random
import socket
import shared.k as k
from shared.rtp import rtp
import numpy as np

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP over IPv4
s.bind((socket.gethostname(), k.CLIENT_ADDR))
cts_packetSeq = random.randint(1, 9999) # https://en.wikipedia.org/wiki/Real-time_Transport_Protocol

cap = cv2.VideoCapture(0)
# cap = cv2.VideoCapture('../data/merlion4.mp4')

cap.set(cv2.CAP_PROP_FRAME_WIDTH, k.CAMERA_WIDTH)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, k.CAMERA_HEIGHT)
cap.set(cv2.CAP_PROP_FPS, 15)

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
  
  cts_payload = bytearray(buffer)
  rtpData = rtp(cts_payload, cts_packetSeq)
  cts_data = rtpData.toBytearray()
  s.sendto(cts_data, (socket.gethostname(), k.SERVER_ADDR))
  cts_packetSeq += 1

  stc_data, stc_addr = s.recvfrom(k.BUFFER_SIZE)
  print(stc_data.decode("utf-8"))
  
  time.sleep(0.5)

s.close()
cap.release()
