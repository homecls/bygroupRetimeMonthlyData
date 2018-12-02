%% *'bygroupRetimeMonthlyEom.m'*: Fillmissing of time in monthly panel data
%% 1 Objective
%
% For every city or group, this function make sure that each year have
% 12 months
%
%% 2 Syntax
% 
% T2 = bygroupRetime(T, vtime, vG)
%
% *Input*
% 
% # T = A table with group variable and time variable
% # vtime = the time variable name  
% # vG = group variable name
%
% *Output*
% 
% # Tout = Table of fullfilled monthly panel data
% 
%% 3 Example
%
% T2 = bygroupRetime(T, 'Datnum', {'Province','City'})
% 
%% 4 See also
%
% retimeTableMonthlyEcom.m retimeTableMonthlyEomWithAllMonthInYear.m
% 
% *Author*: linrenwen@gmail.com 2018-12-1 16:34:38
% 
%% 5 Code
function Tout = bygroupRetimeMonthlyEom(T, vtime, vG)
% T2 = bygroupRetime(T, vtime, vG)
% T2 = bygroupRetime(T, vtime)
narginchk(2,3);
switch nargin
    case 2 % no group 
        
    case 3
        % covert timedata to datenum type
        Dtime = makeitDatenum(T.(vtime));
        DTime = makeitEom(Dtime);
        T.(vtime) = DTime;
        
        % find the group number
        GT = T(:,vG);
        [G,Gset] = findgroups(GT);
        vGno = strcat('GroupNo',strjoin(vG,''));
        T.(vGno) = G;
        
        % replicate the group number and monthly time, then export it to
        % table
        fn = @(x,y){[repmat(y(1),12*(max(year(x))-min(year(x))+1),1),...
            ( geneomInterval([min(year(x)),1],[max(year(x)),12]))...
            ]};
        ys = splitapply(fn,Dtime,G,G);
        y = vertcat(ys{:});
        Ttmp = array2table([y],'VariableNames',{vGno,vtime});
        
        % merge the table of time and table of original data
        Tout = outerjoin(Ttmp,T,'Keys',{vGno,vtime}, 'MergeKeys' ,1);
        % fullfill the group variables
        Tout{:,vG}= Gset{Tout.(vGno),:}; 
        
    otherwise
        narginchk(2,3);
end

end
