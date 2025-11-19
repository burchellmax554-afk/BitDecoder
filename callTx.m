function callTx(fs, numbits, seed)
% Notwes to future me if I ever forget how this works:
% Plays 2 seconds of silence at start to avoid glitch
%
% callTx(fs, numbits, seed) is a function that is used to call the transmitter
% and actually play the sound through the speaker. Decoding is handeled by
% callRx
%
% fs is the sampling frequency that the transmitter uses
% numbits is the number of random bits the transmitter will send
% seed can be any number, but must match the function call to "callRx".
%
% For example, 
%      callTx(8000,10,1)
% would generate 10 random bits, pass them to the transmitter, and then
% play the resulting signal created by your transmitter.

rng(seed);
b = round(rand(numbits,1)');
x = studentTx(b,fs);
if length(x)/fs > 10
    disp(['Modulated signal exceeds the 10 second limit described in ' ...
        'the lab handout.']);
    return;
end
disp('Press any key to transmit...')
pause;
x=x/max(abs(x));
x=[zeros(2*fs,1); x(:)];  % add two seconds of silence to front due to glitch discovered 2/5/19
sound(x,fs);