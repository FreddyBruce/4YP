function G = import_gml_directed(fileName)

    inputfile = fopen(fileName);
    A = [];
    l = 0; k = 1;
    
    while 1
        % Get a line from the input file
        tline = fgetl(inputfile);
        
        % Quit if end of file
        if ~ischar(tline)
            break
        end
        
        nums = regexp(tline,'\d+','match'); %get number from string
        if length(nums)
            if l==1
                l=0;
                A(k,2)=str2num(nums{1});
                k=k+1;
                continue;
            end
            A(k,1)=str2num(nums{1});
            l=1;
        else
            l=0;
            continue;
        end
        
    end
    
    for i=1:length(A)
        G(A(i,1)+1,A(i,2)+1) = 1;
        G(A(i,2)+1,A(i,1)+1) = 0;
    end
end