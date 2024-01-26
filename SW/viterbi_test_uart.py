import py_aff3ct as aff3ct

from conv_encoder import conv_encoder
from viterbi_decoder import viterbi_decoder
from quantizer import quantizer
from viterbi_splitter import viterbi_splitter
from viterbi_serial_test import viterbi_serial

import numpy as np
import math

'''
Voir SOFTWARE_PROGRAM.md dans doc pour des explications sur le programme.
'''

K = 10
N = 2*K
A = 4   # Longueur de contrainte (K)
B = 6*A # Longueur max de convergence
C = 2*B

ebn0_min = 12
ebn0_max = 12.5
ebn0_step = 0.5

ebn0 = np.arange(ebn0_min, ebn0_max, ebn0_step)
esn0 = ebn0 + 10 * math.log10((K + B)/(N + C))
sigma_vals = 1/(math.sqrt(2) * 10 ** (esn0 / 20))

cc_enc = conv_encoder(K + B, N + C)
vit_dec = viterbi_decoder(K + B, N + C)
qtz = quantizer(N + C, )

mdm = aff3ct.module.modem.Modem_BPSK_fast(N + C)
gen = aff3ct.tools.Gaussian_noise_generator_implem.FAST
chn = aff3ct.module.channel.Channel_AWGN_LLR(N + C, gen)
mnt = aff3ct.module.monitor.Monitor_BFER_AR(K, 50)

src_trunc = viterbi_splitter(A, K + B)
dec_trunc = viterbi_splitter(A, K + B)

vit_serial = viterbi_serial(A, N + C)

sigma = np.ndarray(shape = (1,1),  dtype = np.float32)

chn["add_noise ::CP"].bind(sigma)
mdm["demodulate::CP"].bind(sigma)
qtz["quantize  ::cp"].bind(sigma)

src_array = np.array([(1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0)], dtype=np.int32)
print(src_array.size)

cc_enc["encode::r_in"].bind(src_array)
cc_enc["encode     ::r_out "] = mdm     ["modulate     :: X_N1 "]
mdm   ["modulate   ::X_N2  "] = chn     ["add_noise    :: X_N  "]
chn   ["add_noise  ::Y_N   "] = mdm     ["demodulate   :: Y_N1 "]
mdm   ["demodulate ::Y_N2  "] = qtz     ["quantize     :: r_in "]
qtz   ["quantize   ::r_out "] = vit_dec ["decode       :: r_in "]
qtz   ["quantize   ::r_out "] = vit_serial ["send      :: r_in "]

src_trunc['split::r_in'].bind(src_array)
vit_dec  ['decode::r_out'] = dec_trunc ['split::r_in']

# set the new sigma value
sigma[:] = sigma_vals[0]

cc_enc["encode"].exec()
mdm["modulate"].exec()
chn["add_noise"].exec()
mdm["demodulate"].exec()
qtz["quantize"].exec()
vit_dec["decode"].exec()
vit_serial["send"].exec()
src_trunc['split'].exec()
dec_trunc['split'].exec()

print("src = ",           src_array[:])
print("qtz in = ",        qtz    ["quantize ::r_in  "][:])
print("qtz out = ",       qtz    ["quantize ::r_out  "][:])
print("dec out = ",       vit_dec["decode     ::r_out "][:])
print("src trunc     = ", src_trunc['split::r_out'][:])
print("dec out trunc = ", dec_trunc['split::r_out'][:])

