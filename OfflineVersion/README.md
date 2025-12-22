This folder contains an offline validation version of the Bit Decoder digital communication system. The purpose of this version is to allow reproducible testing and analysis of the 
transmitter and receiver without requiring live audio input/output or specialized MATLAB toolboxes.

In the original coursework implementation (OnlineVersion), the system relied on physical audio hardware and MATLAB’s Signal Processing Toolbox to demonstrate real-time transmission 
and reception. While effective in a controlled lab environment, these dependencies make the system difficult to run and validate outside that context. The offline version removes 
these constraints while preserving the core modulation and detection logic.

In this version, the transmitted signal is generated directly using the original FSK transmitter and passed to the receiver for decoding. Signal filtering and frequency detection are 
implemented explicitly using frequency-domain methods and correlation-based energy detection, eliminating reliance on toolbox-specific functions. This allows the system to be evaluated
consistently on any standard MATLAB installation.
