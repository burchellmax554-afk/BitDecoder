function [recovered_bits] = studentRx(rec,fs)
    %=-=-=-=-Parameters-=-=-=-=
        numbits = 30;
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
    band_rec = bandpass(rec,[lowf-bandpass_width,highf+bandpass_width],fs);
    plotspec(band_rec,1/fs)
    for count = 1:numbits
        %Looks at the frequency content at a certain chunk of time
        band_rec_chunk = band_rec(i+floor(bit_len/5):(i+bit_len-1)-floor(bit_len/5));
        %length of the frequency range/fs to represent the length for each
        %frequency integer
        lowf_mag = bandpower(band_rec_chunk,fs,[lowf-1,lowf+1]);
        highf_mag = bandpower(band_rec_chunk,fs,[highf-1,highf+1]);
 
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