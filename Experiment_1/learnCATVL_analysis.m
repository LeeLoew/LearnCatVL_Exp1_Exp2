
  

blocklength = 0;
bONEacc = 0;
bTWOacc = 0;
bTHREEacc = 0;
bFOURacc = 0;
bFIVEacc = 0;
bSIXacc = 0;



for w = 1:length(data)
    if data(w,2) == 1
        blocklength = blocklength + 1;
        
        if data(w,8) == 1
            bONEacc = bONEacc + 1;
        end
        
    elseif data(w,2) == 2
        if data(w,8) == 1
            bTWOacc = bTWOacc + 1;
        end
        
    elseif data(w,2) == 3
        if data(w,8) == 1
            bTHREEacc = bTHREEacc + 1;
        end
        
    elseif data(w,2) == 4
        if data(w,8) == 1
            bFOURacc = bFOURacc + 1;
        end
        
    elseif data(w,2) == 5
        if data(w,8) == 1
            bFIVEacc = bFIVEacc + 1;
        end
        
    elseif data(w,2) == 6
        if data(w,8) == 1
            bSIXacc = bSIXacc + 1;
        end
        
        
    else clear all
    end
end

trainingacc = [bONEacc bTWOacc bTHREEacc bFOURacc bFIVEacc bSIXacc];
trainingacc = trainingacc/blocklength;


cleandata(k,1:6) = trainingacc;


samecat = 0;
difcat = 0;


for x = 1:length(recData)
    
    if recData(x,1) == recData(x,3)
        if recData(x,11) == 1
            samecat = samecat + 1;
        end
    else
        if recData(x,11) == 1
            difcat = difcat + 1;
        end
    end



end
samecat = samecat/(numRecTrials/2);
difcat = difcat/(numRecTrials/2);
cleandata(k,7:8) = [samecat difcat];
cleandata(k,9) = [str2num(qtwo_results(1))];



k = k+1;
