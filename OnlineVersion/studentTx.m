function [y] = studentTx(b,fs)          
%-----Parameters-----    
    playtime = .32 ;  %How many seconds each frequency plays for
   %preamble = [1,0,1];%Preamble to start Reciever recording
    highf = 6200;      %High frequency representing 1  (Make sure that fs is 2 times highf) 
    lowf = 5000;       %Low frequency representing 0  
%---------------------
    y = [0];
    duration = (0:1/fs:playtime-1/fs);   %playtime seconds for each frequency to play
    %b = [preamble,b]
 
    for i = 1:length(b)        
        switch(b(i))
                case 1
                    x = sin(2*pi*highf*duration);
                
                case 0
                    x = sin(2*pi*lowf*duration);
                otherwise
                    fprintf("Error in creating the transmission signal");
         end 
            y = [y, x]; %concatinate all sine waves back to back
    end
    b
end