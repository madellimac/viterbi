import sys
sys.path.insert(0, '../../py_aff3ct/build/lib')
import py_aff3ct as aff3ct
from py_aff3ct.module.py_module import Py_Module

from conv_encoder import conv_encoder
from viterbi_decoder import viterbi_decoder
from quantizer import quantizer

import numpy as np
import math

K = 10
N = 2*K
ebn0_min = 15.0
ebn0_max = 15.5
ebn0_step = 0.2

ebn0 = np.arange(ebn0_min, ebn0_max, ebn0_step)
esn0 = ebn0 + 10 * math.log10(K/N)
sigma_vals = 1/(math.sqrt(2) * 10 ** (esn0 / 20))

src = aff3ct.module.source.Source_random_fast(K, 12)

cc_enc = conv_encoder(K, N)
vit_dec = viterbi_decoder(K, N)
qtz = quantizer(N, )

mdm = aff3ct.module.modem.Modem_BPSK_fast(N)
gen = aff3ct.tools.Gaussian_noise_generator_implem.FAST
chn = aff3ct.module.channel.Channel_AWGN_LLR(N, gen)
mnt = aff3ct.module.monitor.Monitor_BFER_AR(K, 1000)

sigma = np.ndarray(shape = (1,1),  dtype = np.float32)
sigma[:] = sigma_vals[0]
print(sigma_vals[0])
chn["add_noise    ::CP  "] = sigma
mdm["demodulate ::CP  "] = sigma
qtz["quantize :: cp"] = sigma

src    ["generate   ::U_K   "] = cc_enc  ["encode       :: r_in "]
cc_enc ["encode     ::r_out "] = mdm     ["modulate     :: X_N1 "]
mdm    ["modulate   ::X_N2  "] = chn     ["add_noise    :: X_N  "]
chn    ["add_noise  ::Y_N   "] = mdm     ["demodulate   :: Y_N1 "]
mdm    ["demodulate ::Y_N2  "] = qtz     ["quantize     :: r_in "]
qtz    ["quantize   ::r_out "] = vit_dec ["decode       :: r_in "]

src    ["generate   ::U_K   "] = mnt     ["check_errors :: U    "]
vit_dec["decode     ::r_out "] = mnt     ["check_errors :: V    "]


src["generate"].exec()
cc_enc["encode"].exec()
mdm["modulate"].exec()
chn["add_noise"].exec()
mdm["demodulate"].exec()
qtz["quantize"].exec()
vit_dec["decode"].exec()
mnt["check_errors"].exec()

print("src = ", src    ["generate   ::U_K   "][:])
# print("enc out = ", cc_enc ["encode     ::r_out "][:])
# print("mod out = ", mdm    ["modulate   ::X_N2  "][:])
# print("chn out = ", chn    ["add_noise  ::Y_N   "][:])
# print("demod out = ", mdm    ["demodulate ::Y_N2  "][:])
# print("qtz in = ", qtz    ["quantize ::r_in  "][:])
# print("qtz out = ", qtz    ["quantize ::r_out  "][:])
print("dec in = ", vit_dec["decode     ::r_in "][:])
print("dec out = ", vit_dec["decode     ::r_out "][:])
#seq  = aff3ct.tools.sequence.Sequence(src["generate"], mdm["modulate"], 1)
 
#seq.exec()

#bits = cc_enc['encode::r_out'][:]
#print("bits = ", bits)
