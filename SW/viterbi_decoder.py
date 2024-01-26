import numpy as np
from py_aff3ct.module.py_module import Py_Module

''' 
Module permettant le décodage Viterbi.

Certaines bases pour la générification du module pour plusieurs formes d'encodages
ont été ajoutés mais ne sont pas suffisantes.
'''

class viterbi_decoder(Py_Module):

    def decode(self, r_in, r_out):
        # branch metrics
        BM = np.zeros((2 ** self.sig_length, self.K), dtype=np.float32)

        BM[3, :] = r_in[0, 0:self.N:2] + r_in[0, 1:self.N:2] + 6
        BM[2, :] = r_in[0, 0:self.N:2] - r_in[0, 1:self.N:2] + 6
        BM[1, :] = -r_in[0, 0:self.N:2] + r_in[0, 1:self.N:2] + 6
        BM[0, :] = -r_in[0, 0:self.N:2] - r_in[0, 1:self.N:2] + 6

        N_state = 2 ** self.state_bits  # 8

        SM = np.zeros((N_state, self.K + 1), dtype=np.float32)
        path = np.zeros((N_state, self.K + 1), dtype=np.int32)
        SM[:, 0] = np.zeros(N_state)

        for i in range(1, self.K + 1): # chaque donnee
            #state metrics
            SM[0, i] = np.minimum(SM[0, i - 1] + BM[0, i - 1], SM[1, i - 1] + BM[3, i - 1])
            SM[1, i] = np.minimum(SM[2, i - 1] + BM[2, i - 1], SM[3, i - 1] + BM[1, i - 1])
            SM[2, i] = np.minimum(SM[4, i - 1] + BM[1, i - 1], SM[5, i - 1] + BM[2, i - 1])
            SM[3, i] = np.minimum(SM[6, i - 1] + BM[3, i - 1], SM[7, i - 1] + BM[0, i - 1])
            SM[4, i] = np.minimum(SM[0, i - 1] + BM[3, i - 1], SM[1, i - 1] + BM[0, i - 1])
            SM[5, i] = np.minimum(SM[2, i - 1] + BM[1, i - 1], SM[3, i - 1] + BM[2, i - 1])
            SM[6, i] = np.minimum(SM[4, i - 1] + BM[2, i - 1], SM[5, i - 1] + BM[1, i - 1])
            SM[7, i] = np.minimum(SM[6, i - 1] + BM[0, i - 1], SM[7, i - 1] + BM[3, i - 1])

            #paths
            path[0, i] = np.where(SM[0, i - 1] + BM[0, i - 1] < SM[1, i - 1] + BM[3, i - 1], 0, 1)
            path[1, i] = np.where(SM[2, i - 1] + BM[2, i - 1] < SM[3, i - 1] + BM[1, i - 1], 2, 3)
            path[2, i] = np.where(SM[4, i - 1] + BM[1, i - 1] < SM[5, i - 1] + BM[2, i - 1], 4, 5)
            path[3, i] = np.where(SM[6, i - 1] + BM[3, i - 1] < SM[7, i - 1] + BM[0, i - 1], 6, 7)
            path[4, i] = np.where(SM[0, i - 1] + BM[3, i - 1] < SM[1, i - 1] + BM[0, i - 1], 0, 1)
            path[5, i] = np.where(SM[2, i - 1] + BM[1, i - 1] < SM[3, i - 1] + BM[2, i - 1], 2, 3)
            path[6, i] = np.where(SM[4, i - 1] + BM[2, i - 1] < SM[5, i - 1] + BM[1, i - 1], 4, 5)
            path[7, i] = np.where(SM[6, i - 1] + BM[0, i - 1] < SM[7, i - 1] + BM[3, i - 1], 6, 7)


        #surviving path

        tmp = SM[0, self.K]
        current_state = 0
        for i in range(1, 8):
            if tmp > SM[i, self.K - 1]:
                tmp = SM[i, self.K - 1]
                current_state = i

        for i in range(self.K, 0, -1):
            if current_state < 4:
                r_out[0, i - 1] = 0
            else:
                r_out[0, i - 1] = 1
            current_state = path[current_state, i]

        return 0

    def __init__(self, K, N):

        self.N = N
        self.K = K

        # Pour générifier le décodeur
        self.sig_length = 2             # Nombre de bits de la signature
        self.state_bits = 3             # Nombre de bits pour chaque état
        self.poly = np.array([11, 13])  # Polynome utilisé pour l'encodage (non utilisé)
        self.poly_depth = 4             # Nombre de bits du polynome

        Py_Module.__init__(self)  # Call the aff3ct Py_Module __init__
        self.name = "viterbi_decoder"  # Set your module's name
        t_decode = self.create_task("decode")  # create a task for your module
        s_r_in = self.create_socket_in(t_decode, "r_in", N, np.float32)  # create an input socket for the task t_add
        s_r_out = self.create_socket_out(t_decode, "r_out", K, np.int32)  # create an output socket for the task t_add

        self.create_codelet(t_decode, lambda slf, lsk, fid: slf.decode(lsk[s_r_in], lsk[s_r_out]))  # create codelet
