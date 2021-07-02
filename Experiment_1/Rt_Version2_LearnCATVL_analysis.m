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





blocklength = [];
bONEaccSFIRST = [];
bTWOaccSFIRST =[];
bTHREEaccSFIRST  = [];
bFOURaccSFIRST  = [];
bFIVEaccSFIRST  = [];
bSIXaccSFIRST  = [];


bONEaccDFIRST  = [];
bTWOaccDFIRST  = [];
bTHREEaccDFIRST  = [];
bFOURaccDFIRST  = [];
bFIVEaccDFIRST  = [];
bSIXaccDFIRST  = [];


bONEaccSSECOND = [];
bTWOaccSSECOND = [];
bTHREEaccSSECOND = [];
bFOURaccSSECOND = [];
bFIVEaccSSECOND = [];
bSIXaccSSECOND = [];


bONEaccDSECOND = [];
bTWOaccDSECOND = [];
bTHREEaccDSECOND = [];
bFOURaccDSECOND = [];
bFIVEaccDSECOND = [];
bSIXaccDSECOND = [];


for w = 1:length(data)
    if data(w,9) == -1 %if it's a missed response
    
    else
    if data(w,2) == 1
        blocklength = blocklength + 1;
        
        if data(w,8) == 1
            if data(w,10) == 1
                if data(w,11) == 1
                    bONEaccSFIRST(length(bONEaccSFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bONEaccSSECOND(length(bONEaccSSECOND)+1) = data(w,9);
                end
            else
                if data(w,11) == 1
                    bONEaccDFIRST(length(bONEaccDFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bONEaccDSECOND(length(bONEaccDSECOND)+1) = data(w,9);
                end
            end
        end
        
    elseif data(w,2) == 2
        
        if data(w,8) == 1
            if data(w,10) == 1
                if data(w,11) == 1
                    bTWOaccSFIRST(length(bTWOaccSFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bTWOaccSSECOND(length(bTWOaccSSECOND)+1) = data(w,9);
                end
            else
                if data(w,11) == 1
                    bTWOaccDFIRST(length(bTWOaccDFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bTWOaccDSECOND(length(bTWOaccDSECOND)+1) = data(w,9);
                end
            end
        end
        
    elseif data(w,2) == 3
        
        if data(w,8) == 1
            if data(w,10) == 1
                if data(w,11) == 1
                    bTHREEaccSFIRST(length(bTHREEaccSFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bTHREEaccSSECOND(length(bTHREEaccSSECOND)+1) = data(w,9);
                end
            else
                if data(w,11) == 1
                    bTHREEaccDFIRST(length(bTHREEaccDFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bTHREEaccDSECOND(length(bTHREEaccDSECOND)+1) = data(w,9);
                end
            end
        end
        
    elseif data(w,2) == 4
        if data(w,8) == 1
            if data(w,10) == 1
                if data(w,11) == 1
                    bFOURaccSFIRST(length(bFOURaccSFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bFOURaccSSECOND(length(bFOURaccSSECOND)+1) = data(w,9);
                end
            else
                if data(w,11) == 1
                    bFOURaccDFIRST(length(bFOURaccDFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bFOURaccDSECOND(length(bFOURaccDSECOND)+1) = data(w,9);
                end
            end
        end
        
    elseif data(w,2) == 5
        if data(w,8) == 1
           if data(w,10) == 1
                if data(w,11) == 1
                    bFIVEaccSFIRST(length(bFIVEaccSFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bFIVEaccSSECOND(length(bFIVEaccSSECOND)+1) = data(w,9);
                end
            else
                if data(w,11) == 1
                    bFIVEaccDFIRST(length(bFIVEaccDFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bFIVEaccDSECOND(length(bFIVEaccDSECOND)+1) = data(w,9);
                end
            end
        end
        
    elseif data(w,2) == 6
        if data(w,8) == 1
           if data(w,10) == 1
                if data(w,11) == 1
                    bSIXaccSFIRST(length(bSIXaccSFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bSIXaccSSECOND(length(bSIXaccSSECOND)+1) = data(w,9);
                end
            else
                if data(w,11) == 1
                    bSIXaccDFIRST(length(bSIXaccDFIRST)+1) = data(w,9);
                elseif data(w,11) == 2
                    bSIXaccDSECOND(length(bSIXaccDSECOND)+1) = data(w,9);
                end
            end
        end
        
        
    else clear all
    end
    
    end
    
end

trainingacc = [round(mean(bONEaccSFIRST)*1000) round(mean(bONEaccDFIRST)*1000) round(mean(bONEaccSSECOND)*1000) round(mean(bONEaccDSECOND)*1000) round(mean(bTWOaccSFIRST)*1000) round(mean(bTWOaccDFIRST)*1000) round(mean(bTWOaccSSECOND)*1000) round(mean(bTWOaccDSECOND)*1000) round(mean(bTHREEaccSFIRST)*1000) round(mean(bTHREEaccDFIRST)*1000) round(mean(bTHREEaccSSECOND)*1000) round(mean(bTHREEaccDSECOND)*1000) round(mean(bFOURaccSFIRST)*1000) round(mean(bFOURaccDFIRST)*1000) round(mean(bFOURaccSSECOND)*1000) round(mean(bFOURaccDSECOND)*1000) round(mean(bFIVEaccSFIRST)*1000) round(mean(bFIVEaccDFIRST)*1000) round(mean(bFIVEaccSSECOND)*1000) round(mean(bFIVEaccDSECOND)*1000) round(mean(bSIXaccSFIRST)*1000) round(mean(bSIXaccDFIRST)*1000) round(mean(bSIXaccSSECOND)*1000) round(mean(bSIXaccDSECOND)*1000)];
%trainingacc = trainingacc/(blocklength/4);


cleandata(k,1:24) = trainingacc;


samecat = 0;
difcat = 0;


% for x = 1:length(recData)
%     
%     if recData(x,1) == recData(x,3)
%         if recData(x,11) == 1
%             samecat = samecat + 1;
%         end
%     else
%         if recData(x,11) == 1
%             difcat = difcat + 1;
%         end
%     end
%     
%     
%     
% end
% samecat = samecat/(numRecTrials/2);
% difcat = difcat/(numRecTrials/2);
%cleandata(k,13:14) = [samecat difcat];
%cleandata(k,15) = [str2num(qtwo_results(1))];



k = k+1;
