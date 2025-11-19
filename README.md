This project implements a complete end-to-end digital communication system in MATLAB using audio frequencies as the transmission medium. The transmitter (CallTx.m) generates a 
random sequence of bits, modulates them into an audible waveform using the custom studentTx.m function, and plays the resulting signal through the computer’s speakers. studentTx 
maps each bit to a corresponding sinusoidal tone—5 kHz for a binary 0 and 6.2 kHz for a binary 1—concatenating these tones into a continuous signal that represents the 
transmitted message. The gain is normalized, silence padding is added to address hardware inconsistencies, and the signal is played out at the specified sampling rate.

The receiver (CallRx.m) continuously monitors microphone input for the presence of the expected frequency bands, automatically detects when a transmission begins, records the 
incoming audio, and passes it to studentRx.m for demodulation. The demodulator performs bandpass filtering, divides the signal into bit-length segments, and computes the energy 
around each target frequency to classify each received bit. Cross-correlation is then used for bit alignment before computing the bit-error rate (BER) between the transmitted and 
recovered bitstreams. If the recovered sequence is perfect, the system automatically logs the result to an online leaderboard. Together, these four files demonstrate real-world 
communication pipeline concepts such as tone-based modulation, channel distortion, synchronization, demodulation, and BER measurement—implemented using only core MATLAB tools 
and standard audio hardware.
