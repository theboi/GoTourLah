import socket
from shared import pyrtp

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP over IPv4
s.bind((socket.gethostname(), 1447))

while True:
  message, address = s.recvfrom(1024)
  message = message.upper()
  s.sendto(message, address)
  print(pyrtp.decodePacket(message.hex()))

# s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP over IPv4

# if __name__ == '__main__':
#   for pings in range(10):
#   s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
#   s.settimeout(1.0)
  
#   start = time.time()
#   s.sendto(b'test', (socket.gethostname(), 1234))
#   try:
#     data, server = s.recvfrom(1024)
#     end = time.time()
#     elapsed = end - start
#     print(f'{data} {pings} {elapsed}')
#   except socket.timeout:
#     print('REQUEST TIMED OUT')