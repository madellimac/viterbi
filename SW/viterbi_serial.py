import serial
import numpy as np
from py_aff3ct.module.py_module import Py_Module

''' 
Module permettant l'envoi et la réception des données en série depuis la carte FPGA embarquant le décodeur matériel.


Ce module n'a jamais pu être correctement testé conjointement avec la carte FPGA et le décodeur matériel.
Il comporte probablement des erreurs au niveau de la mise en forme des signatures à envoyer.
'''

class viterbi_serial(Py_Module):
    def send(self, r_in):
        ser = serial.Serial('/dev/ttyUSB1', 9600, bytesize=serial.EIGHTBITS)
        print("début")
        for i in range(0, self.N, 2):
            tmp1 = int(((3-r_in[0, i])/2)*7/3)
            tmp2 = int(((3-r_in[0, i + 1])/2)*7/3)
            tmp = (tmp2<<2) + (tmp1 << 5) # Vérifier si les bits inutiles sont bien les deux de poids faibles
            print(f'{tmp:06b}')
            ser.write(tmp.to_bytes(1, byteorder='big', signed=False))
        return 0

    def receive(self, r_out):
        ser = serial.Serial('/dev/ttyUSB1', 9600, bytesize=1)
        for i in range(0, self.N - 6 * self.K):
            r_out[i] = ser.read()
        return 0


    def __init__(self, K, N):
        self.N = N
        self.K = K
        Py_Module.__init__(self)  # Call the aff3ct Py_Module __init__
        self.name = "viterbi_serial"  # Set your module's name
        t_send = self.create_task("send")  # create a task for your module
        t_receive = self.create_task("receive")  # create a task for your module
        s_r_in = self.create_socket_in(t_send, "r_in", N, np.float32)
        s_r_out = self.create_socket_out(t_receive, "r_out", N - 6 * K, np.int32)

        self.create_codelet(t_send, lambda slf, lsk, fid: slf.send(lsk[s_r_in]))  # create codelet
        self.create_codelet(t_receive, lambda slf, lsk, fid: slf.receive(lsk[s_r_out]))

