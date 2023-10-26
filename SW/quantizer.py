import sys
sys.path.insert(0, '../pyaf/py_aff3ct/build/lib')
import numpy as np
import py_aff3ct as aff3ct
from py_aff3ct.module.py_module import Py_Module

class quantizer(Py_Module):

	def quantize(self, s_cp, r_in, r_out):
		clip_val = 4/s_cp 
		tmp = np.clip(r_in[0], -1*clip_val, clip_val)
		r_out[0, :] = np.round(tmp[:]*3/clip_val)
		return 0
    
	def __init__(self, N):
		
		self.N = N
		Py_Module.__init__(self) # Call the aff3ct Py_Module __init__
		self.name = "quantizer"   # Set your module's name
		t_quantize = self.create_task("quantize") # create a task for your module
		s_cp      = self.create_socket_in  (t_quantize, "cp", 1, np.float32)
		s_r_in    = self.create_socket_in  (t_quantize, "r_in"   , N, np.float32 ) # create an input socket for the task
		s_r_out   = self.create_socket_out (t_quantize, "r_out"  , N, np.float32 ) # create an output socket for the task
		    
		self.create_codelet(t_quantize, lambda slf, lsk, fid: slf.quantize(lsk[s_cp], lsk[s_r_in], lsk[s_r_out])) # create codelet
	