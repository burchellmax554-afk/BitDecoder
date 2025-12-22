% Offline test for Bit Communicator (no audio I/O)

fs = 16000;        % sampling frequency
numbits = 120;    % max supported bits
seed = 1;         % fixed seed for repeatability

rng(seed);
truebits = round(rand(numbits,1)');

% Generate transmit signal
txSignal = studentTx(truebits, fs);

% Normalize
txSignal = txSignal / max(abs(txSignal));

% Custom noise levels to simulate interference
noiseLevel = 0.01;
rxSignal = txSignal + noiseLevel * randn(size(txSignal));

% Run receiver
decodedbits = studentRx(rxSignal, fs);

% Compute BER
numCorrect = sum(decodedbits == truebits);
ber = 1 - numCorrect / numbits;

disp(['Offline BER: ' num2str(ber)]);
