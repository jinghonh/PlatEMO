function [Remain] = ReplacementUniformity(Population,N,Front,Weight)
% Select N solutions from Population, where N <=|Population| 

%------------------------------- Copyright --------------------------------
% Copyright (c) 2024 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

% This function is written by Gladston Moreira

%% Description
% The next generation population is formed by a representative subset R of 
% a population P of approximate solutions generated by a multi-objective 
% evolutionary algorithm, with cardinality |Population|, according to the 
% uniformity measure.

    %% Start                                                     
    B.decs = Population.decs;
    B.wgts = Weight;
    Next   = (1:length(Population));
 
    R.wgts = zeros(N,size(B.wgts,2));
    R.decs = zeros(N,size(B.decs,2));       

    % Auxiliar counting
    ii=1;
    
    %% Greedy heuristic for uniformity
    
    % Find xi and xj in NP(non-dominated solutions of Population) with 
    % maximum wd(xi; xj) (dominance-weighted uniformity function).  
    ind = Front == min(Front);
    if sum(ind) == 1
        Aux.decs = B.decs(ind,:);
        Aux.wgts = B.wgts(ind,:);
        Aux.next = Next(ind);
        %
        nFront = Front(~ind);
        C.decs = B.decs(~ind,:);
        C.wgts = B.wgts(~ind,:); 
        nNext = Next(~ind);
        ind1 = nFront == min(nFront);
        Aux.decs = [Aux.decs;C.decs(ind1,:)];
        Aux.wgts = [Aux.wgts;C.wgts(ind1,:)];
        Aux.next = [Aux.next nNext(ind1)];
        [D,I] = distDWU(Aux,Aux,-1);
        [~, j] = max(D);
        R.decs(ii,:) = Aux.decs(j,:);
        R.wgts(ii,:) = Aux.wgts(j,:);
        ii = ii + 1;
        R.decs(ii,:) = Aux.decs(I(j),:);
        R.wgts(ii,:) = Aux.wgts(I(j),:);
        B.decs(Aux.next([j I(j)]),:)=[];
        B.wgts(Aux.next([j I(j)]),:)=[];
        Remain = Next(Aux.next([j I(j)]));
        Next(Aux.next([j I(j)]))=[];
    else      
        Aux.decs = B.decs(ind,:);
        Aux.wgts = B.wgts(ind,:);
        Aux.next = Next(ind);
        [D,I] = distDWU(Aux,Aux,-1);
        [~, j] = max(D);
        R.decs(ii,:) = Aux.decs(j,:);
        R.wgts(ii,:) = Aux.wgts(j,:);
        ii = ii + 1;
        R.decs(ii,:) = Aux.decs(I(j),:);
        R.wgts(ii,:) = Aux.wgts(I(j),:);
        B.decs(Aux.next([j I(j)]),:)=[];
        B.wgts(Aux.next([j I(j)]),:)=[];
        Remain = Next(Aux.next([j I(j)]));
        Next(Aux.next([j I(j)]))=[];
    end
    
    while ii < N
        ii = ii + 1;
        [D,~] = distDWU(R,B,1);
        [~, j] = max(D);
        R.decs(ii,:) = B.decs(j,:);
        R.wgts(ii,:) = B.wgts(j,:);
        B.decs(j,:) = [];
        B.wgts(j,:) = [];
        Remain(ii) = Next(j);
        Next(j) = [];
    end   
end

function [D,I] = distDWU(X,Y,varargin)
    
    %   [D,I] = distDWU(X,Y,K) returns a K-by-MY matrix I
    %   containing indices of the observations in X corresponding to the K
    %   smallest pairwise distances in D. [D,I] = distDWU(X,Y,-K) returns
    %   indices corresponding to the K largest pairwise
    %   distances.

    WX = X.wgts;
    WY = Y.wgts;

    X = X.decs;
    Y = Y.decs;

    [nx] = size(X,1);
    [ny] = size(Y,1);

    p = size(X,2);

    outClass = class(X);

    smallestLargestFlag = varargin{1};
    nD = abs(smallestLargestFlag);
    D = zeros(nD,ny,outClass); % X and Y were single/double, or cast to double
    I = zeros(nD,ny,outClass);
   
    for i = 1:ny
        dsq = zeros(nx,1,outClass);
        for q = 1:p
            dsq = dsq + (X(:,q) - Y(i,q)).^2;
        end
        wgts = abs(WX(:,1)-WY(i,1));
        dsq = sqrt(dsq);
        dsq = dsq./((wgts+1));
        [D(:,i),I(:,i)] = partialSort(dsq,smallestLargestFlag);        
    end
end

function [D,I] = partialSort(D,smallestLargest)
    if smallestLargest > 0
        n = smallestLargest;
    else
        %sort(D,'descend') puts the NaN values at the beginning of the sorted list.
        %That is not what we want here.
        D = D*-1;
        n = -smallestLargest;
    end

    if nargout < 2
        D = sort(D,1);
        D = D(1:n,:);
    else
        [D,I] = sort(D,1);
        D = D(1:n,:);
        I = I(1:n,:);
    end

    if smallestLargest < 0
        D = D * -1;
    end
end