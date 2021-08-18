import cv2

camera = cv2.VideoCapture(1)

# 13 images cover 1s, so "FPS" is 13
seconds = int(input("Enter recording seconds: "))
for i in range(13*seconds):
  return_value, image = camera.read()
  cv2.imwrite('./imageExport/img'+str(i)+'.png', image)

del camera

for x in range(13*seconds):
  with open('./imageExport/img'+str(x)+'.png', "rb") as image:
    f = image.read()
    b = bytes(f)
  with open('./imageExport/byteexport/imgByte'+str(x)+'.txt', "w") as text:
    text.write(str(b))