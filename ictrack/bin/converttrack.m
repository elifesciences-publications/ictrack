M = 4;
N = 4;

T = length(tracks);
for t = 1:T
    
    t
    
    labels = tracks(t).labels;
    ms = tracks(t).m;
    ns = tracks(t).n;
    objs = tracks(t).obj;
    trnos = tracks(t).trno;
    
    count = 1;
    
    for m = 1:M
        for n = 1:N            
            s = regionprops(labels(:,:,m,n),'PixelIdxList');  % get the pixel index list for the image          
            
            if isempty(s)
                continue
            end
            s(end).trno = [];   %                         
            thismn = intersect(find(ms == m), find(ns == n));  % these are the indices corresponding to objects in this frame
            
            if (~isempty(thismn))
                for i = thismn'   % loop through all the objects
                    s(objs(i)).trno = trnos(i);
                end
            end
            % assign all the objects to the structure
            % need tracks(t).obj(1)            m,n,num,idx,tr                
            for i = 1:length(s)
                tracks2(t).obj(count).m = m;
                tracks2(t).obj(count).n = n;
                tracks2(t).obj(count).num = i;
                tracks2(t).obj(count).idx = s(i).PixelIdxList;
                
                if (~isempty(s(i).trno))
                    tracks2(t).obj(count).trno = s(i).trno;
                else
                    tracks2(t).obj(count).trno = 0;
                end
                count = count+1;
            end
        end
    end    
end
save('tracks2.mat','tracks2');
