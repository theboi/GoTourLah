import sys
sys.path.append("..")

import cv2
import socket
import shared.k as k
from rtp import RTP
import numpy as np
# import utils

# model_path = '../data/merlion.tflite'
# label_path = '../data/labels.txt'

# interpreter = utils.load_model(model_path)
# labels = utils.load_labels(label_path)

# input_details = interpreter.get_input_details()

# # Get Width and Height
# input_shape = input_details[0]['shape']
# height = input_shape[1]
# width = input_shape[2]

# # Get input index
# input_index = input_details[0]['index']

if __name__ == "__main__":
  s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # RTP over UDP over IPv4
  s.bind((socket.gethostname(), 1447))

  while True:
    # Receive image
    data, address = s.recvfrom(k.BUFFER_SIZE)
    print("Received.")
    s.sendto(data, address)

    payload = RTP().fromBytes(data).payload

    npdata = np.frombuffer(bytes(payload), dtype=np.uint8)
    image = cv2.imdecode(npdata, cv2.IMWRITE_JPEG_QUALITY)
    # # image = cv2.imread("../data/merlion2.png")
    # image = cv2.resize(image, (k.CAMERA_WIDTH, k.CAMERA_HEIGHT))
    # image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    # top_result = utils.process_image(interpreter, image, input_index)
    # print("Top result", top_result)
    # utils.display_result(top_result, image, labels)

    cv2.imshow("Image", image)
    if cv2.waitKey(25) & 0xFF == ord('q'):
      break

cv2.destroyAllWindows()