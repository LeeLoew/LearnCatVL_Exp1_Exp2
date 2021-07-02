%This was updated to extract same cat vs difcat accuracy from the original
%anlysis file.

%first lets make a same vs dif variable in the 10th column and set 1/2 fir
%first or second image of pair
data(1:length(data),10) = 0;
data(1:length(data),11) = repmat([1 2], 1,384);
skip = 0;
for n = 1:length(data)
    
    
    
   if data(n,6) < 17 %ImIdx is same pair images 1-16
       data(n,10) = 1;
   elseif data(n,6) > 16
       data(n,10) = 2;
   end
    
    
    
    
    
end

% % % a = 1;
% % % b = 1;
% % % c = 1;
% % % d = 1;

% % % for x = 1:length(data)
% % %     if data(x,10) == 1 %same
% % %         
% % %         
% % %         if data(x,11) == 1 %first image
% % %             samefirst(a,:) = data(x,:);
% % %             a = a+1;
% % %         elseif data(x,11) == 2 %second image
% % %             samesecond(b,:) = data(x,:);
% % %             b =b+1;
% % %             
% % %         end
% % %         
% % %     elseif data(x,10) == 2 %dif
% % %         
% % %         
% % %         if data(x,11) == 1 %first image
% % %             differentfirst(c,:) = data(x,:);
% % %             c = c+1;
% % %         elseif data(x,11) == 2 %second image
% % %             differentsecond(d,:) = data(x,:);
% % %             d = d+1;
% % %             
% % %         end
% % %         
% % %     end
% % %     
% % % end
% % % 
% % % a
% % % b
% % % c
% % % d





blocklength = 0;
bONEaccSFIRST = 0;
bTWOaccSFIRST = 0;
bTHREEaccSFIRST  = 0;
bFOURaccSFIRST  = 0;
bFIVEaccSFIRST  = 0;
bSIXaccSFIRST  = 0;


bONEaccDFIRST  = 0;
bTWOaccDFIRST  = 0;
bTHREEaccDFIRST  = 0;
bFOURaccDFIRST  = 0;
bFIVEaccDFIRST  = 0;
bSIXaccDFIRST  = 0;


bONEaccSSECOND = 0;
bTWOaccSSECOND = 0;
bTHREEaccSSECOND = 0;
bFOURaccSSECOND = 0;
bFIVEaccSSECOND = 0;
bSIXaccSSECOND = 0;


bONEaccDSECOND = 0;
bTWOaccDSECOND = 0;
bTHREEaccDSECOND = 0;
bFOURaccDSECOND = 0;
bFIVEaccDSECOND = 0;
bSIXaccDSECOND = 0;


for w = 1:length(data)
    if data(w,2) == 1
        blocklength = blocklength + 1;
        
        if data(w,8) == 1
            if data(w,10) == 1
                if data(w,11) == 1
                    bONEaccSFIRST = bONEaccSFIRST + 1;
                elseif data(w,11) == 2
                    bONEaccSSECOND = bONEaccSSECOND + 1;
                end
            else
                if data(w,11) == 1
                    bONEaccDFIRST = bONEaccDFIRST + 1;
                elseif data(w,11) == 2
                    bONEaccDSECOND = bONEaccDSECOND + 1;
                end
            end
        end
        
    elseif data(w,2) == 2
        
        if data(w,8) == 1
            if data(w,10) == 1
                if data(w,11) == 1
                    bTWOaccSFIRST = bTWOaccSFIRST + 1;
                elseif data(w,11) == 2
                    bTWOaccSSECOND = bTWOaccSSECOND + 1;
                end
            else
                if data(w,11) == 1
                    bTWOaccDFIRST = bTWOaccDFIRST + 1;
                elseif data(w,11) == 2
                    bTWOaccDSECOND = bTWOaccDSECOND + 1;
                end
            end
        end
        
    elseif data(w,2) == 3
        
        if data(w,8) == 1
            if data(w,10) == 1
                if data(w,11) == 1
                    bTHREEaccSFIRST = bTHREEaccSFIRST + 1;
                elseif data(w,11) == 2
                    bTHREEaccSSECOND = bTHREEaccSSECOND + 1;
                end
            else
                if data(w,11) == 1
                    bTHREEaccDFIRST = bTHREEaccDFIRST + 1;
                elseif data(w,11) == 2
                    bTHREEaccDSECOND = bTHREEaccDSECOND + 1;
                end
            end
        end
        
    elseif data(w,2) == 4
        if data(w,8) == 1
            if data(w,10) == 1
                if data(w,11) == 1
                    bFOURaccSFIRST = bFOURaccSFIRST + 1;
                elseif data(w,11) == 2
                    bFOURaccSSECOND = bFOURaccSSECOND + 1;
                end
            else
                if data(w,11) == 1
                    bFOURaccDFIRST = bFOURaccDFIRST + 1;
                elseif data(w,11) == 2
                    bFOURaccDSECOND = bFOURaccDSECOND + 1;
                end
            end
        end
        
    elseif data(w,2) == 5
        if data(w,8) == 1
           if data(w,10) == 1
                if data(w,11) == 1
                    bFIVEaccSFIRST = bFIVEaccSFIRST + 1;
                elseif data(w,11) == 2
                    bFIVEaccSSECOND = bFIVEaccSSECOND + 1;
                end
            else
                if data(w,11) == 1
                    bFIVEaccDFIRST = bFIVEaccDFIRST + 1;
                elseif data(w,11) == 2
                    bFIVEaccDSECOND = bFIVEaccDSECOND + 1;
                end
            end
        end
        
    elseif data(w,2) == 6
        if data(w,8) == 1
           if data(w,10) == 1
                if data(w,11) == 1
                    bSIXaccSFIRST = bSIXaccSFIRST + 1;
                elseif data(w,11) == 2
                    bSIXaccSSECOND = bSIXaccSSECOND + 1;
                end
            else
                if data(w,11) == 1
                    bSIXaccDFIRST = bSIXaccDFIRST + 1;
                elseif data(w,11) == 2
                    bSIXaccDSECOND = bSIXaccDSECOND + 1;
                end
            end
        end
        
        
    else clear all
    end
end

trainingacc = [bONEaccSFIRST bONEaccDFIRST bONEaccSSECOND bONEaccDSECOND bTWOaccSFIRST bTWOaccDFIRST bTWOaccSSECOND bTWOaccDSECOND bTHREEaccSFIRST bTHREEaccDFIRST bTHREEaccSSECOND bTHREEaccDSECOND bFOURaccSFIRST bFOURaccDFIRST bFOURaccSSECOND bFOURaccDSECOND bFIVEaccSFIRST bFIVEaccDFIRST bFIVEaccSSECOND bFIVEaccDSECOND bSIXaccSFIRST bSIXaccDFIRST bSIXaccSSECOND bSIXaccDSECOND];
trainingacc = trainingacc/(blocklength/4);


cleandata(k,1:24) = trainingacc;


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
%cleandata(k,13:14) = [samecat difcat];
%cleandata(k,15) = [str2num(qtwo_results(1))];



k = k+1;
