import serial
import time
import io

ser = serial.Serial('/dev/ttyUSB1',115200)

for i in range(97, 123):
    ser.write(chr(i).encode())
    time.sleep(0.1)

print("Sending over")
#time.sleep(2)



i = 97
while ser.inWaiting() and i <= 123:
    x = ser.read()
    time.sleep(0.1)
    #print("x=",x)
    #if x.decode() != chr(i):
    print("Différence détectée sur ", chr(i).encode(), " x= ",x,"val i:",i,"hex de x:",x.hex(), "hex de i:",(chr(i).encode()).hex())
    i+=1
    

""" while ser.inWaiting():
    print("Lu : ", ser.read(1)) """
