%Optimal Page Replacement algorithm.
%Made by: Vandit Sheth
%Optimal page replacement algorithm is only possible if we have a batch
%system i.e. the order of page calls is known before-hand.
%Here the locality of reference has been taken into consideration. The
%number of page calls are 2000 whereas the number of logical pages are
%2000 and the physical pages range from 1 to 20(the number of logical
%pages). In OPR the page when there is a page fault, first the empty slots
%(having page number 0) are filled. If there is no such slot than the page
%that is referenced again after maximum cycles is replaced. This algorithm
%is best to avoid page faults but it is expensive as the next reference of
%all physical pages will have to be checked. Also, this is only realizable
%if we know the sequence of page references before-hand

function OPR()
clear
ncalls=2000;
nlogical=20;
% calls=ceil(rand(1,ncalls)*nlogical);
result = zeros(1,nlogical);
calls=zeros(1,ncalls);
nlocal = 6;                 % page range of program locality 
locality = (0:9)*0.1;       % ten values of locality parameter

for cnt=1:10
    generate_calls(nlogical, nlocal, locality(cnt));
    for i=1:nlogical
        result(i)=pagefaults(i);
    end
    plot((1:nlogical), result);
    hold on;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function generate_calls( nlogical, nlocal, locality )
%
% nlogical - number of logical pages
% nlocal   - page range of program locality 
% locality - locality parameter (= probablility of making local reference)
%            (note: main program uses an array of 10 locality values)
%
%
tmp = size(calls);
ref_cnt = tmp(2);
%
% create the first nlocal references
calls(1:nlocal) = floor(rand(1,nlocal)*nlogical);
%
% now create the remaining references 
%
% each reference generated is either local or general:
%   local -- uniformly distributed over the last nlocal references
%   general -- uniformly distributed over all nlogical pages
%
% probability of generating local reference = locality 
%
for k = nlocal+1 : ref_cnt
    local = rand() > 1-locality;                % boooean flag for local reference   
    if local
        back_ref = floor(rand()*nlocal);        % within the last nlocal references
        calls(k) = calls(k-back_ref);     %   > that is, local reference
    else
        calls(k) = floor(rand()*nlogical);   % general reference, that is >
                                                % anywhere in logical address space
    end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function npf = pagefaults(nphysical)
    npf=0;
    physical=zeros(1,nphysical);
    nextref=zeros(1,nphysical)+ncalls+2;
    for j=1:ncalls
        found=find(physical==calls(j),1);
        if isempty(found)
            npf=npf+1;
            for k=1:nphysical
                if physical(k)~=0
                    temp=find(calls(j+1:numel(calls))==physical(k),1);
                        if isempty(temp)
                            nextref(k)=ncalls+1;
                        else
                            nextref(k)=temp;                    
                        end
                end
            end
            here=find(nextref==max(nextref),1);
            physical(here)=calls(j);
        end
    end
end
end
