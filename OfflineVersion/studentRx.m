function [recovered_bits] = studentRx(rec,fs)
    %=-=-=-=-Parameters-=-=-=-=
        numbits = 120;
        highf = 6200;
        lowf =5000;
        bandpass_width = 50; %Filter width away from desired freq.
    %=-=-=-=-=-=--=-=-=-=-=-=-=
    recovered_bits = zeros(1,numbits);
    i = 1;
    bit_len=floor(length(rec)/numbits);%Length of each bit interval (floor() rounds down)
    rec=rec/max(abs(rec));
    figure(1)  
    plotspec(rec,1/fs)
    
    figure(2)

    % Manual bandpass filter (no Signal Processing Toolbox)
    N = length(rec);
    f = (-N/2:N/2-1)*(fs/N);
    REC_FFT = fftshift(fft(rec));

    band_mask = (abs(f) >= (lowf-bandpass_width) & abs(f) <= (highf+bandpass_width));
    REC_FFT(~band_mask) = 0;

    band_rec = real(ifft(ifftshift(REC_FFT)));
    plotspec(band_rec,1/fs)
    for count = 1:numbits
        %Looks at the frequency content at a certain chunk of time
        band_rec_chunk = band_rec(i+floor(bit_len/5):(i+bit_len-1)-floor(bit_len/5));
        %length of the frequency range/fs to represent the length for each
        %frequency integer
    % Compute frequency-domain power manually (no Signal Processing Toolbox)
    N = length(band_rec_chunk);
    X = fft(band_rec_chunk);
    f = (0:N-1)*(fs/N);

    lowf_idx = (f >= lowf-1 & f <= lowf+1);
    highf_idx = (f >= highf-1 & f <= highf+1);

    % Tone energy measurement (no Signal Processing Toolbox) ---
    N = length(band_rec_chunk);
    t = (0:N-1) / fs;

    % Low frequency basis
    sL = sin(2*pi*lowf*t);
    cL = cos(2*pi*lowf*t);

    % High frequency basis
    sH = sin(2*pi*highf*t);
    cH = cos(2*pi*highf*t);

    % Correlation energies (dot products)
    lowf_mag  = (band_rec_chunk * sL.')^2 + (band_rec_chunk * cL.')^2;
    highf_mag = (band_rec_chunk * sH.')^2 + (band_rec_chunk * cH.')^2;

 
        if(lowf_mag > highf_mag)
            bit = 0;
        else
            bit = 1; 
        end

        recovered_bits(count) = bit;
        i = i + bit_len; 
 
    end
    recovered_bits
end