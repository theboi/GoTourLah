import sys
sys.path.append("..")

import socket, cv2
import numpy as np
from rtp import RTP
import shared.k as k

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP over IPv4
s.bind((socket.gethostname(), 1447))

while True:
  data, address = s.recvfrom(k.BUFFER_SIZE)
  s.sendto(data, address)

  # print(message)

  payload = RTP().fromBytes(data).payload

  npdata = np.frombuffer(bytes(payload), dtype=np.uint8)
  image = cv2.imdecode(npdata, cv2.IMWRITE_JPEG_QUALITY)

  