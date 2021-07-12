import numpy as np

NUMBER_DENSITY = 50. # m-3. This is MP number concentration.

FRACT_TOP = 0.3
H_TOP = 2000 # m. MPs are confined to between this altitude and the surface.

# NOTES:
#
# SW_ABS, SW_SCA, LW_ABS and LW_SCA are obtained from adding the fibre and
# fragment optical properties (and MP concentration is set to 50).
#
# SW_ASY and LW_ASY are an average of the fibre and fragment asymmetry parameters
# (can't exceed 1).

SW_ABS = np.array([
	2.81158369e-11,
	1.77962749e-11,
	2.08364126e-11,
	5.14508882e-11,
	3.07313372e-10,
	2.54537590e-09,
]) # m-1

SW_SCA = np.array([
	2.76736909e-08,
	2.77087682e-08,
	2.77304626e-08,
	2.77420879e-08,
	2.75660197e-08,
	2.54975269e-08,
]) # m-1

SW_ASY = np.array([
	0.82524714,
	0.8332091,
	0.83648979,
	0.8378385,
	0.83938119,
	0.85604786,
]) # 0

LW_ABS = np.array([
	5.46044537e-09,
	7.83862314e-09,
	8.73329251e-09,
	8.73896642e-09,
	8.49942788e-09,
	8.46115076e-09,
	7.82993746e-09,
	7.28748169e-09,
	3.93569214e-09,
]) # m-1

LW_SCA = np.array([
	2.43824945e-08,
	2.12505464e-08,
	2.00217649e-08,
	2.00278374e-08,
	1.99839631e-08,
	1.99987942e-08,
	2.05330068e-08,
	2.10225261e-08,
	2.41769027e-08,
]) # m-1

LW_ASY = np.array([
	0.8301096,
	0.87838708,
	0.8990576,
	0.89882933,
	0.90440009,
	0.90463539,
	0.90059854,
	0.89644002,
	0.8681488,
]) # 1
