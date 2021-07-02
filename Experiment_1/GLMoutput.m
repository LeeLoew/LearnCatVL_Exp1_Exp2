%GenMixModelAnalysisSetup
clear tempGMMoutput
clear clustvar
clear factor
clear ACC

for x = 1:length(recData)
    clustvar = sub;
    if recData(x,1) == recData(x,3) %if same cat
        factor = 1;
        if recData(x,11) == 1
           ACC = 1;
        else
            ACC = 0;
        end
    else
        factor = 2;
        if recData(x,11) == 1
            ACC = 1;
        else
            ACC = 0;
        end
    end
    
    
    tempGMMoutput(x, 1:3) = [clustvar factor ACC];
    
    
end

if k == 1
    finalGMMoutput = tempGMMoutput;
else
    finalGMMoutput = [finalGMMoutput; tempGMMoutput];
end


k = k+1
