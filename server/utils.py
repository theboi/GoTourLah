"""
Run object detection on images, Press ESC to exit the program
For Raspberry PI, please use `import tflite_runtime.interpreter as tflite` instead
"""
import re
import numpy as np

import tensorflow.lite as tflite
# import tflite_runtime.interpreter as tflite

def load_labels(label_path):
  r"""Returns a list of labels"""
  with open(label_path) as f:
    labels = {}
    for line in f.readlines():
      m = re.match(r"(\d+)\s+(\w+)", line.strip())
      labels[int(m.group(1))] = m.group(2)
    return labels

def load_model(model_path):
  r"""Load TFLite model, returns a Interpreter instance."""
  interpreter = tflite.Interpreter(model_path=model_path)
  interpreter.allocate_tensors()
  return interpreter


def process_image(interpreter, image, input_index):
  r"""Process an image, Return a list of detected class ids and positions"""
  input_data = np.expand_dims(image, axis=0)  # expand to 4-dim

  # Process
  interpreter.set_tensor(input_index, input_data)
  interpreter.invoke()

  # Get outputs
  output_details = interpreter.get_output_details()

  # output_details[0] - position
  # output_details[1] - class id
  # output_details[2] - score
  # output_details[3] - count

  print(output_details[0])
  positions = np.squeeze(interpreter.get_tensor(output_details[0]['index']))
  classes = np.squeeze(interpreter.get_tensor(output_details[1]['index']))
  scores = np.squeeze(interpreter.get_tensor(output_details[2]['index']))

  result = []

  for idx, score in enumerate(scores):
    if score > 0.5:
      result.append({'pos': positions[idx], '_id': classes[idx]})

  return result