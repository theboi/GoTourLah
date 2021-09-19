import sys
sys.path.append("..")

import datetime
import shared.k as k
import numpy as np
import os
import cv2

duration = 60
frames_per_second = 24.0
res = '1080p'

t = datetime.datetime.now()

cap = cv2.VideoCapture(0)
out1 = cv2.VideoWriter('video1_{}.mp4'.format(str(t)), cv2.VideoWriter_fourcc(*'XVID'), 25, (k.CAMERA_WIDTH, k.CAMERA_HEIGHT))
out2 = cv2.VideoWriter('video2_{}.mp4'.format(str(t)), cv2.VideoWriter_fourcc(*'XVID'), 25, (k.CAMERA_WIDTH, k.CAMERA_HEIGHT))

while True:
    ret, frame = cap.read()
    out1.write(frame)
    out2.write(frame)
    cv2.imshow('frame',frame)
    if cv2.waitKey(1) == 27 or datetime.datetime.now().timestamp() - t.timestamp() >= duration:
        break
    

cap.release()
out1.release()
out2.release()
cv2.destroyAllWindows()