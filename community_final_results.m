
for i = 1:10
    clear P V g W H ib
    [P,V,g,W,H,ib] = enron_dynamic_community_detection(103,1,627);
    
    
    num = num2str(i);
    fileName = strcat('results',num);
    save(fileName);
end