This folder contains the original coursework implementation of the Bit Decoder digital communication system. This version was developed to demonstrate an end-to-end frequency-shift 
keying communication pipeline using live audio input and output, reflecting the intended use within a controlled lab environment.

In this implementation, binary data is modulated into distinct carrier frequencies and transmitted through audio hardware. The receiver monitors incoming audio, performs spectral 
analysis and filtering, and recovers the transmitted bits based on frequency energy detection. This version emphasizes real-time signal processing, hardware interaction, and practical 
system integration.

The online version relies on MATLAB’s Signal Processing Toolbox for filtering and power measurement, as well as access to audio input/output devices. These dependencies were available 
in the original course environment and are preserved here to maintain fidelity to the original design.
