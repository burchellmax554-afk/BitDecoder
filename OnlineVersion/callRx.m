function [decodedbits, truebits] = callRx(fs, numbits, seed)
    % [decodedbits truebits] = callRx(fs, numbits, seed) is a function for 
    % recording the audio, passing it to your receiver script (studentRx.m), 
    % and computing the bit error rate.

    %% DO NOT EDIT ANY OF THE CODE IN THIS FUNCTION
    % In fact, you really don't need to look at any of this.
    r = audiorecorder(fs, 16, 1);
    disp('Press any key to record...')
    pause;

    highf = 6200;
    lowf = 5000;
    bandpass_width = 50;

    % Initialize the recorder and monitor for a signal
    disp('Monitoring for signal start...')
    while true
        % Check for a presence of the high frequency (or a specific frequency range)
        % in the audio input, indicating the start of transmission.
        ad = getaudiodata(r, 'double')';
        % Check the frequency content of the signal (e.g., looking for highf or lowf)
        band_rec = bandpass(ad, [lowf-bandpass_width, highf+bandpass_width], fs);
        
        % Measure the magnitude of the band-pass filtered signal in the expected frequency range
        highf_mag = bandpower(band_rec, fs, [highf-1, highf+1]);
        lowf_mag = bandpower(band_rec, fs, [lowf-1, lowf+1]);
        
        % If either frequency is strong enough, start the recording
        if highf_mag > 0.01 || lowf_mag > 0.01
            disp('Signal detected, starting recording...')
            record(r);  % Start the recording when a signal is detected
            break;
        end
        
        % Wait a small amount of time before checking again
        pause(0.1);
    end

    % Wait for the user to stop the recording
    disp('Press any key to stop recording...')
    pause;
    stop(r);

    % Process the recorded audio data
    ad = getaudiodata(r, 'double')';
    bits = studentRx(ad, fs);
    rng(seed);
    b = round(rand(numbits, 1)');
    
    % Find the alignment of the transmitted and received bits
    b_x = xcorr(bits, b);
    [~, b_idx] = max(b_x);
    delay = b_idx - max(length(bits), length(b));
    if delay >= 0
        bits = bits(delay+1:end);
    end
    
    % Calculate the bit error rate
    numcor = sum(bits == b);
    ber = 1 - (numcor / length(b));
    disp(['Your bit error rate is ' num2str(ber)]);
    
    % Return the decoded bits and true bits
    decodedbits = bits;
    truebits = b;
    
    % Log the results if the BER is zero
    if ber == 0
        prompt = ['Since your BER is zero, this will be logged to the '
                  'leaderboard if you are on campus or using the VPN. '
                  'What username/alias would you like to              '
                  'use? (alphanumeric only, no spaces)                '];
        disp(prompt)             
        name = input('Your alias: ','s');
        fprintf(' \n');
        webread(['http://aspect.kb.wwu.edu/datalogger.php?name=' name '&score=' num2str(numbits) '&id=' getenv('username')]);
    end
    disp('If on campus, or using the VPN, you can see the leaderboard <a href="http://aspect.kb.wwu.edu/leaderboard.php">here</a>.')
end

%  Note from the very end: My code's upper limit is around 120 bits