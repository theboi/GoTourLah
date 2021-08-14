import socket, time
import shared.pyrtp as pyrtp
import time

packets = 3
pkt_delay = 150

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP
s.bind((socket.gethostname(), 1234))

#time_int = random.randint(1,9999)
packet_seq = 0

while packets != 0:
  payload = 'd5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5'
  header_hex = pyrtp.encodePacket({'version' : 2, 'padding' : 0, 'extension' : 0, 'csi_count' : 0, 'marker' : 0, 'payload_type' : 8, 'sequence_number' : packet_seq, 'timestamp' : time.time(), 'ssrc' : 185755418, 'payload' : payload})

  s.sendto(bytes.fromhex(header_hex), (socket.gethostname(), 1447))
  
  packets -= 1
  packet_seq += 1
  
  time.sleep(float(pkt_delay * 0.0001))
s.close()

