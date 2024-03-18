classdef MRCDMO < ALGORITHM
% <multi> <real/integer/label/binary/permutation> <dynamic>
% Multiregional Co-evolutionary Algorithm


% This function is written by Guopeng Chen

    methods
        function main(Algorithm,Problem)
            %% Generate random population
            Population = Problem.Initialization();
            PopDec = Population.decs;
            center = {};
            obj1=[];
            obj2=[];
            Last_T_Population=[];
            %% Optimization
            while Algorithm.NotTerminated(Population)
                obj1 = Problem.CalObj(ones(size(PopDec(1,:))));
                if isequal(obj1,obj2) ||isempty(obj2)
                    LastPopulation=Population; %保存上一代的种群
                else % 目标函数发生变化
                    Problem.DrawObj(Population) 
                    pause(0.1);
                    [Population,Last_T_Population,center] = Reinitialization_M(Problem,Population,LastPopulation,Last_T_Population,center);
                end
                obj2 = Problem.CalObj(ones(size(PopDec(1,:))));

                % Generate offspring randomly
                MatingPool = randperm(Problem.N);
                Offspring  = OperatorGA(Problem,Population(MatingPool));
                
                % Elitism strategy
                UniPop = [Population,Offspring];
                PopObj = UniPop.objs;
                [FrontNo,MaxFNo] = NDSort(PopObj,Problem.N);

                % The number of individuals to be selected in the last
                % non-dominated front
                K = Problem.N - sum(FrontNo<MaxFNo);

                if K ~= 0
                    % Normalization
                    pareto_population = find(FrontNo<MaxFNo);
                    last_population   = find(FrontNo == MaxFNo);
                    Zmin = min(PopObj(FrontNo == MaxFNo,:));
                    Zmax = max(PopObj(FrontNo == MaxFNo,:));
                    S = sum(FrontNo == MaxFNo);
                    MaxFnorm = (PopObj(last_population,:)-repmat(Zmin,S,1))./repmat(Zmax-Zmin,S,1);

                    % Clustering-based reference points generation
                    [Ref] = Reference_Generation( MaxFnorm,Problem.M,K);

                    % Clustering-based environmental selection
                    [reference_population] = Reference_Point_Selection(MaxFnorm,last_population,Ref,K,Problem.M);
                else
                    pareto_population    = find(FrontNo<=MaxFNo);
                    reference_population = [];
                end
                Population = UniPop([pareto_population,reference_population]);
                Population = Problem.SetAdd(Population);
                % PopObj=Population.objs;
                % scatter3(PopObj(:,1),PopObj(:,2),PopObj(:,3));
                % pause(0.5)
            end
        end
    end
end