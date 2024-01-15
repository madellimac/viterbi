import serial
import numpy as np
from py_aff3ct.module.py_module import Py_Module


class viterbi_serial(Py_Module):
    def send(self, r_in):
        ser = serial.Serial('/dev/ttyUSB1', 9600, bytesize=serial.SIXBITS)
        print("début")
        for i in range(0, self.N, 2):
            tmp1 = int(((3-r_in[0, i])/2)*7/3)
            tmp2 = int(((3-r_in[0, i + 1])/2)*7/3)
            tmp = tmp2 + (tmp1 << 3)
            print(f'{tmp:06b}')
            ser.write(tmp.to_bytes(1, byteorder='big', signed=False))
        print("fin")
        return 0

    def receive(self, r_out):
        ser = serial.Serial('/dev/ttyUSB1', 9600, bytesize=1)
        for i in range(0, self.N - 6 * self.K):
            ser.read(r_out[i])
            print(r_out)
            print("OK")
        return 0


    def __init__(self, K, N):
        self.N = N
        self.K = K
        # self.ser = serial.Serial('/dev/ttyUSB1', 9600, bytesize=serial.SIXBITS)
        Py_Module.__init__(self)  # Call the aff3ct Py_Module __init__
        self.name = "viterbi_serial"  # Set your module's name
        t_send = self.create_task("send")  # create a task for your module
        t_receive = self.create_task("receive")  # create a task for your module
        s_r_in = self.create_socket_in(t_send, "r_in", N, np.float32)
        s_r_out = self.create_socket_out(t_receive, "r_out", N - 6 * K, np.int32)

        self.create_codelet(t_send, lambda slf, lsk, fid: slf.send(lsk[s_r_in]))  # create codelet
        self.create_codelet(t_receive, lambda slf, lsk, fid: slf.receive(lsk[s_r_out]))
