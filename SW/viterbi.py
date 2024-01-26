import py_aff3ct as aff3ct

from conv_encoder import conv_encoder
from viterbi_decoder import viterbi_decoder
from quantizer import quantizer
from viterbi_splitter import viterbi_splitter

import numpy as np
import math
import time
import matplotlib.pyplot as plt

'''
Voir SOFTWARE_PROGRAM.md dans doc pour des explications sur le programme.
'''

K = 100 # Longueur du message
N = 2*K # Longueur du message encodé
A = 4   # Longueur de contrainte
B = 6*A # Longueur max de convergence
C = 2*B # Longueur max de convergence encodé

ebn0_min = 0
ebn0_max = 3
ebn0_step = 0.5

ebn0 = np.arange(ebn0_min, ebn0_max, ebn0_step)
esn0 = ebn0 + 10 * math.log10((K + B)/(N + C))
sigma_vals = 1/(math.sqrt(2) * 10 ** (esn0 / 20))

src = aff3ct.module.source.Source_random_fast(K + B, 12)

cc_enc = conv_encoder(K + B, N + C)
vit_dec = viterbi_decoder(K + B, N + C)
qtz = quantizer(N + C, )

mdm = aff3ct.module.modem.Modem_BPSK_fast(N + C)
gen = aff3ct.tools.Gaussian_noise_generator_implem.FAST
chn = aff3ct.module.channel.Channel_AWGN_LLR(N + C, gen)
mnt = aff3ct.module.monitor.Monitor_BFER_AR(K, 50)

src_trunc = viterbi_splitter(A, K + B)
dec_trunc = viterbi_splitter(A, K + B)

sigma = np.ndarray(shape = (1,1),  dtype = np.float32)
chn["add_noise ::CP"].bind(sigma)
mdm["demodulate::CP"].bind(sigma)
qtz["quantize  ::cp"].bind(sigma)

src    ["generate   ::U_K   "] = cc_enc  ["encode       :: r_in "]
cc_enc ["encode     ::r_out "] = mdm     ["modulate     :: X_N1 "]
mdm    ["modulate   ::X_N2  "] = chn     ["add_noise    :: X_N  "]
chn    ["add_noise  ::Y_N   "] = mdm     ["demodulate   :: Y_N1 "]
mdm    ["demodulate ::Y_N2  "] = qtz     ["quantize     :: r_in "]
qtz    ["quantize   ::r_out "] = vit_dec ["decode       :: r_in "]

src      ['generate::U_K'] = src_trunc['split::r_in']
src_trunc['split::r_out']  = mnt      ['check_errors::U']

vit_dec  ['decode::r_out'] = dec_trunc ['split::r_in']
dec_trunc['split::r_out']  = mnt       ['check_errors::V']

fer = np.zeros(len(ebn0))
ber = np.zeros(len(ebn0))

print(" Eb/NO (dB) | Frame number |    BER   |    FER   |  Tpt (Mbps)")
print("------------|--------------|----------|----------|------------")

for i in range(len(sigma_vals)):
    # reset the error counter of the monitor
    mnt.reset()
    # set the new sigma value
    sigma[:] = sigma_vals[i]

    # get the current time
    t = time.time()

    while not mnt.is_done():
        src["generate"].exec()
        cc_enc["encode"].exec()
        mdm["modulate"].exec()
        chn["add_noise"].exec()
        mdm["demodulate"].exec()
        qtz["quantize"].exec()
        vit_dec["decode"].exec()
        mnt["check_errors"].exec()
        src_trunc['split'].exec()
        dec_trunc['split'].exec()

    # calculate the simulation throughput
    elapsed = time.time() - t
    total_fra = mnt.get_n_analyzed_fra()
    tpt = total_fra * K * 1e-6 / elapsed

    # store the current BER and FER values
    ber[i] = mnt.get_ber()
    fer[i] = mnt.get_fer()

    # Display data
    print("%11.2f | %12d | %7.2e | %7.2e | %10.2f" % (ebn0[i], total_fra, ber[i], fer[i], tpt))

fig = plt.figure()
plt.title("Viterbi BER/FER vs Eb/N0")
plt.xlabel("Eb/N0")
plt.ylabel("BER/FER")
plt.grid()
plt.semilogy(ebn0, fer, 'r-', ebn0, ber, 'b--')
plt.show()

