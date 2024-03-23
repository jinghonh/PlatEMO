function NewPopulation = CRM_Initialization(Problem,Population)

end

function NewPopulation = RM_rand(Problem,Population)
    MR=0.5;
    NP=floor(Problem.N/3); %自己假设
    NewDecs=zeros(NP,Problem.D);
    [FrontNo,~] = NDSort(Population.objs,Problem.N);
    [~,FrontIndex]=sort(FrontNo,'descend');
    bestDec=Population(FrontIndex(end)).dec;
    for i=1:NP
        xnew=zeros(1,Problem.D);
        if rand<MR %Create xnew i by Cauchy mutation 
            for j=1:Problem.N
                xnew(j)=cauchy(bestDec(j),0.1,1);                              %(3)
            end
        else
            xr1=Problem.lower+rand(1,Problem.D).*(Problem.upper-Problem.lower);%(4)
            xr2=Problem.lower+rand(1,Problem.D).*(Problem.upper-Problem.lower);%(5)
            xnew=Population(i).dec+2*rand.*(xr1-xr2);                          %(6)
        end
        NewDecs(i,:)=xnew;
    end
    NewPopulation = Problem.Evaluation(NewDecs);
end

function NewPopulation = RM_TrSP(Problem,Population)
    [FrontNo,~] = NDSort(Population.decs,Problem.N);
    Pd=Population(FrontNo==1).decs;
    Cd=mean(Pd);
    CrowdDis = CrowdingDistance(Population.decs,FrontNo);
    Pb=Population(CrowdDis==inf).decs;
    SD=[Pd;Cd;Pb]; %SD is the source domain

    N_TD=length(SD)*2;
    TD=Generate_Random_Solutions(Problem,N_TD);
        


    
end

function NewPopulation = RM_M(Problem,Population)

end

function rndc=cauchy(x0,gamma,size)
    pd = makedist('tLocationScale','mu',x0,'sigma',gamma,'nu',1);
    rndc = random(pd,size);
end

function x = Generate_Random_Solutions(Problem,Num)
    x=repmat(Problem.lower,Num,1)+rand(Num,Problem.D).*repmat((Problem.upper-Problem.lower),Num,1);
end