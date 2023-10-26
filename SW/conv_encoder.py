import sys
sys.path.insert(0, '../pyaf/py_aff3ct/build/lib')
import numpy as np
import py_aff3ct as aff3ct
from py_aff3ct.module.py_module import Py_Module

class conv_encoder(Py_Module):

	def encode(self, r_in, r_out):
		poly1 = np.array([1,0,1])
		poly2 = np.array([1,1,1])
		SR = np.zeros(3, dtype=np.int32)
		for i in range(0, self.K):
			SR = np.roll(SR, 1)
			SR[0] = r_in[0, i]
			r_out[0, 2*i] = np.mod(np.sum(np.multiply(SR, poly1)), 2)
			r_out[0, 2*i+1] = np.mod(np.sum(np.multiply(SR, 
			poly2)), 2)
			print(SR)
			
		print(r_out)
		return 0
        
    
	def __init__(self, K, N):
		
		self.N = N
		self.K = K
		Py_Module.__init__(self) # Call the aff3ct Py_Module __init__
		self.name = "conv_encoder"   # Set your module's name
		t_encode = self.create_task("encode") # create a task for your module
		s_r_in    = self.create_socket_in  (t_encode, "r_in"   , K, np.int32 ) # create an input socket for the task t_add
		s_r_out   = self.create_socket_out (t_encode, "r_out"  , N, np.int32 ) # create an output socket for the task t_add
		    
		self.create_codelet(t_encode, lambda slf, lsk, fid: slf.encode(lsk[s_r_in], lsk[s_r_out])) # create codelet
		#self.create_codelet(t_add, lambda slf, lsk, fid: slf.add(lsk[s_ix_x], lsk[s_ix_y], lsk[s_delta_x], lsk[s_delta_y], lsk[s_enable], lsk[s_r_in], lsk[s_r_out])) # create codelet