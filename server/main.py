import sys
sys.path.append("..")

import random
from shared.rtp import rtp
import os
import cv2
import socket
import shared.k as k
from rtp import RTP
import numpy as np
# import matplotlib.pyplot as plt
# import tensorflow as tf

# https://medium.com/analytics-vidhya/creating-a-powerful-and-quick-object-detection-system-using-frozen-tensorflow-models-bacfff3e2114
# Load the Model

# model_path = "Provide path to the folder where you downloaded the above model" # @elliot
# pb_file = os.path.join(model_path, 'frozen_inference_graph.pb')

# # Read the graph.
# with tf.gfile.FastGFile(pb_file, 'rb') as f:
#     graph_def = tf.GraphDef()
#     graph_def.ParseFromString(f.read())
# gpu_options = tf.GPUOptions(per_process_gpu_memory_fraction=1)
# with tf.Session(config=tf.ConfigProto(gpu_options=gpu_options)) as sess:
#     sess.graph.as_default()
#     tf.import_graph_def(graph_def, name='')

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # RTP over UDP over IPv4
s.bind((socket.gethostname(), k.SERVER_ADDR))
stc_packet_seq = random.randint(1, 9999) # https://en.wikipedia.org/wiki/Real-time_Transport_Protocol

while True:
  # Receive image
  cts_data, cts_address = s.recvfrom(k.BUFFER_SIZE)
  cts_payload = RTP().fromBytes(cts_data).payload

  s.sendto(bytes("hello".encode()), (socket.gethostname(), k.CLIENT_ADDR))
  stc_packet_seq += 1

  npdata = np.frombuffer(bytes(cts_payload), dtype=np.uint8)
  image = cv2.imdecode(npdata, cv2.IMWRITE_JPEG_QUALITY)

  # # Provide path to an image for testing
  # image_height, image_width, _ = image.shape
  # image = cv2.resize(image, (224, 224))
  # image = image[:, :, [2, 1, 0]] # BGR2RGB
  
  # outputs = sess.run([sess.graph.get_tensor_by_name('num_detections:0'),
  #             sess.graph.get_tensor_by_name('detection_scores:0'),
  #             sess.graph.get_tensor_by_name('detection_boxes:0'),
  #             sess.graph.get_tensor_by_name('detection_classes:0')],  
  #             feed_dict={
  #                       'image_tensor:0': image.reshape(1,
  #                         image.shape[0],
  #                         image.shape[1],3)})

  # # Visualize the results
  # font = cv2.FONT_HERSHEY_SIMPLEX
  
  # for i in range(num_detections):
  #     classId = int(outputs[3][0][i])
  #     print(classId)
  #     score = float(outputs[1][0][i])
  #     bbox = [float(v) for v in outputs[2][0][i]]
  #     if True:
  #         x = bbox[1] * image_width
  #         y = bbox[0] * image_height
  #         right = bbox[3] * image_width
  #         bottom = bbox[2] * image_height
  #         cv2.rectangle(image,
  #                       (int(x), int(y)),
  #                       (int(right), int(bottom)),
  #                       (225, 255, 0),
  #                       thickness=2)
  #         cv2.putText(image,str(class_list[classId-1]),(int(x),int(y)), font, 1, (200,0,0), 3, cv2.LINE_AA)
  #         print('SCORE:',score, ', Class:',class_list[classId-1], ', BBox:',int(x),int(y),int(right),int(bottom))
  cv2.imshow("Image", image)
  if cv2.waitKey(25) & 0xFF == ord('q'):
    break

cv2.destroyAllWindows()