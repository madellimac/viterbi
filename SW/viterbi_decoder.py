import sys
sys.path.insert(0, '../pyaf/py_aff3ct/build/lib')
import numpy as np
import py_aff3ct as aff3ct
from py_aff3ct.module.py_module import Py_Module

class viterbi_decoder(Py_Module):

	def decode(self, r_in, r_out):
		
		# branch metrics
		BM = np.zeros((4,self.K), dtype=np.float32)
		BM[3,:] =  r_in[0, 0:self.N:2] + r_in[0, 1:self.N:2] + 6
		BM[2,:] =  r_in[0, 0:self.N:2] - r_in[0, 1:self.N:2] + 6
		BM[1,:] = -r_in[0, 0:self.N:2] + r_in[0, 1:self.N:2] + 6
		BM[0,:] = -r_in[0, 0:self.N:2] - r_in[0, 1:self.N:2] + 6
		print(BM)
		# state metrics
		N_state = 8
		SM = np.zeros((N_state, self.K+1), dtype = np.float32)
		path = np.zeros((N_state, self.K+1), dtype = np.int32)
		SM[:,0] = np.zeros(N_state)
		
		for i in range(1, self.K+1):
			print(i)
			SM[0, i] = np.minimum(SM[0, i-1] + BM[0, i-1], SM[1, i-1] + BM[3, i-1])
			SM[1, i] = np.minimum(SM[2, i-1] + BM[1, i-1], SM[3, i-1] + BM[2, i-1])
			SM[2, i] = np.minimum(SM[4, i-1] + BM[2, i-1], SM[5, i-1] + BM[1, i-1])
			SM[3, i] = np.minimum(SM[6, i-1] + BM[3, i-1], SM[7, i-1] + BM[0, i-1])
			SM[4, i] = np.minimum(SM[0, i-1] + BM[3, i-1], SM[1, i-1] + BM[0, i-1])
			SM[5, i] = np.minimum(SM[2, i-1] + BM[2, i-1], SM[3, i-1] + BM[1, i-1])
			SM[6, i] = np.minimum(SM[4, i-1] + BM[1, i-1], SM[5, i-1] + BM[2, i-1])
			SM[7, i] = np.minimum(SM[6, i-1] + BM[0, i-1], SM[7, i-1] + BM[3, i-1])

			path[0, i] = np.where(SM[0, i-1] + BM[0, i-1] < SM[1, i-1] + BM[3, i-1], 0, 1)
			path[1, i] = np.where(SM[2, i-1] + BM[1, i-1] < SM[3, i-1] + BM[2, i-1], 2, 3)
			path[2, i] = np.where(SM[4, i-1] + BM[2, i-1] < SM[5, i-1] + BM[1, i-1], 4, 5)
			path[3, i] = np.where(SM[6, i-1] + BM[3, i-1] < SM[7, i-1] + BM[0, i-1], 6, 7)
			path[4, i] = np.where(SM[0, i-1] + BM[3, i-1] < SM[1, i-1] + BM[0, i-1], 0, 1)
			path[5, i] = np.where(SM[2, i-1] + BM[2, i-1] < SM[3, i-1] + BM[1, i-1], 2, 3)
			path[6, i] = np.where(SM[4, i-1] + BM[1, i-1] < SM[5, i-1] + BM[2, i-1], 4, 5)
			path[7, i] = np.where(SM[6, i-1] + BM[0, i-1] < SM[7, i-1] + BM[3, i-1], 6, 7)

		current_state = 0
		for i in range(self.K-1, -1, -1):
			r_out[0, i] = path[current_state, i] % 2
			print(current_state)
			current_state = path[current_state, i]

		print("SM=", SM)
		print("path=\n", path)
		return 0
    
	def __init__(self, K, N):
		
		self.N = N
		self.K = K
		Py_Module.__init__(self) # Call the aff3ct Py_Module __init__
		self.name = "viterbi_decoder"   # Set your module's name
		t_decode = self.create_task("decode") # create a task for your module
		s_r_in    = self.create_socket_in  (t_decode, "r_in"   , N, np.float32 ) # create an input socket for the task t_add
		s_r_out   = self.create_socket_out (t_decode, "r_out"  , K, np.int32 ) # create an output socket for the task t_add
		    
		self.create_codelet(t_decode, lambda slf, lsk, fid: slf.decode(lsk[s_r_in], lsk[s_r_out])) # create codelet
		#self.create_codelet(t_add, lambda slf, lsk, fid: slf.add(lsk[s_ix_x], lsk[s_ix_y], lsk[s_delta_x], lsk[s_delta_y], lsk[s_enable], lsk[s_r_in], lsk[s_r_out])) # create codelet