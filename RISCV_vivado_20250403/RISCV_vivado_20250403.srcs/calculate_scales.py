#!/usr/bin/env python3

import math

import argparse
 
def quantize_multiplier_shift(s_a: float, s_w: float, s_y: float):

    """

    Given activation scale s_a, per-channel weight scale s_w, and output scale s_y,

    compute integer multiplier and right-shift so that:

      M ≈ multiplier / 2**shift

    where M = (s_a * s_w) / s_y

    """
 
    # 1. real-valued requant scale

    M = (s_a * s_w) / s_y

    if M <= 0 or M >= 1:

        # for stability, M should be in (0,1); in practice M can be >1 but that still works

        pass
 
    # 2. decompose M = m * 2**e, with m in [0.5, 1)

    m, e = math.frexp(M)
 
    # 3. convert mantissa m into Q0.31 fixed-point integer

    multiplier = int(round(m * (1 << 31)))
 
    # 4. compute right shift so that:

    #      multiplier / (2**shift) ≈ M

    #    i.e. shift = 31 - e

    shift = 31 - e
 
    return multiplier, shift
 
def main():

    Sw= [0.002931511029601097, 0.002793340478092432, 0.002625892171636224, 0.001955465180799365, 0.0024299444630742073, 0.0030782176181674004, 0.0018029140774160624, 0.003041959833353758, 0.003213127376511693, 0.0035850664135068655, 0.0035787506494671106, 0.0023249350488185883, 0.0018809415632858872, 0.0027728185523301363, 0.002232627011835575, 0.0030582421459257603]
    Sa = 0.02709713950753212
    Sy = 0.14580480754375458
    M = []
    S = []
    for i in range(len(Sw)):
        multiplier, shift = quantize_multiplier_shift(Sa, Sw[i], Sy)
        M.append(multiplier)
        S.append(shift)
    print("multiplier: ", M)
    print("shift: ", S)

 
if __name__ == "__main__":

    main()

 