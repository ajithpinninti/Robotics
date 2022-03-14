direction = [1 2 3 2]
direc2 = [2 3 4 1]
j = 1;
for i=1:4
   try 
    a(j) = sub2ind([3 3],direction(i),direc2(i));
    j = j+1;
catch E
    continue;    
   end
end
display(a);