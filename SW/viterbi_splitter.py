import numpy as np
from py_aff3ct.module.py_module import Py_Module

''' 
Module permettant la suppression des bits de bourrage en fin de transmission.
'''

class viterbi_splitter(Py_Module):

    def split(self, r_in, r_out):
        for i in range(0, self.N-6*self.K):
            r_out[0, i] = r_in[0, i]

        return 0

    def __init__(self, K, N):
        self.N = N # Longueur du message
        self.K = K # Longeur de contrainte
        Py_Module.__init__(self)  # Call the aff3ct Py_Module __init__
        self.name = "viterbi_splitter"  # Set your module's name
        t_split = self.create_task("split")  # create a task for your module
        s_r_in = self.create_socket_in(t_split, "r_in", N, np.int32)
        s_r_out = self.create_socket_out(t_split, "r_out", N - 6 * K, np.int32)

        self.create_codelet(t_split, lambda slf, lsk, fid: slf.split(lsk[s_r_in], lsk[s_r_out]))  # create codelet

