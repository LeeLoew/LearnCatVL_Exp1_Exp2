%This was updated to extract same cat vs difcat accuracy from the original
%anlysis file.
  
%first lets make a same vs dif variable in the 10th column and set 1/2 fir
%first or second image of pair
data(1:length(data),10) = 0;



for n = 1:length(data)
    
    
    if n == length(data)
        break;
    end
    
    if data(n,6)+1 == data(n+1,6)
        if data(n,7) == data(n+1,7)
            data(n,10) = 1;
            data(n,11) = 1; %first image of pair
            data(n+1,10) = 1;
            data(n+1,11) = 2; %second image of pair
        elseif data(n,10) ~= 1
            data(n,10) = 2;
            data(n,11) = 1;%first image of pair
            data(n+1,10) = 2;
            data(n+1,11) = 2; %second image of pair
        end
        
        
   
    end
    
    
    
    
    
    
end
one =1;
two = 1;
three = 1;
four = 1;
SameFirst = [];
SameSecond = [];
DifFirst = [];
DifSecond = [];

for n = 1:length(data)
    
    
   if data(n,10) == 1
       if data(n,11) == 1
           SameFirst(one,:) = data(n,:);
           one = one+1;
       else
           SameSecond(two,:) = data(n,:);
           two = two+1;
       end
   elseif data(n,10) == 2
       if data(n,11) == 1
           DifFirst(three,:) = data(n,:);
           three = three+1;
       else
           DifSecond(four,:) = data(n,:);
           four = four+1;
           
       end
   end
    
    
    
    
    
end













