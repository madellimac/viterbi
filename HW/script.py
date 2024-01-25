import serial
import time
import io

ser = serial.Serial('/dev/ttyUSB1',115200)

for i in range(97, 123):
    ser.write(chr(i).encode())
    time.sleep(0.01)

print("Sending over")
#time.sleep(10)


#ser.read()
i = 97
#while ser.inWaiting() and i < 123:
while i < 123:  
    x = ser.read()
    time.sleep(0.01)
    #print("x=",x)
    #if x.decode() != chr(i):
    #print("Différence détectée sur ", chr(i).encode(), " x= ",x,"val i:",i,"hex de x:",x.hex(), "hex de i:",(chr(i).encode()).hex())
    print("Attendu: ", chr(i).encode(), " Recu: ",x,"val i:",i,"hex de x:",x.hex(), "hex de i:",(chr(i).encode()).hex())
    i+=1
    

""" while ser.inWaiting():
    print("Lu : ", ser.read(1)) """
