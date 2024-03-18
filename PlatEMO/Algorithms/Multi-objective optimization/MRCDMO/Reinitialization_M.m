function [NewPopulation,Last_T_Population,center] = Reinitialization_M(Problem,Population,LastPopulation,Last_T_Population,center)
    % Re-initialize solutions
    
    [Population_MRP,center,h] = MRP(Problem,Population,LastPopulation,center);
    Population_MRDM = MRDM(Problem,Population,Last_T_Population,h);
    Last_T_Population=LastPopulation;
    
    Population_Archive=[Population_MRP,Population_MRDM];
    FE=Problem.FE;
    Population_Archive=Problem.Evaluation(Population_Archive.decs);
    Problem.FE=FE;
    [FrontNo,~] = NDSort(Population_Archive.objs,Problem.N);
    [~,index]=sort(FrontNo);

    NewPopulation=Population_Archive(index(1:Problem.N));

    % %plot center
    % center3=zeros(3,size(center,2),3);
    % for i=1:size(center,2)
    %     for j=1:3
    %         center3(j,i,:)=center{i}(j,:);
    %     end
    % end
    % for i=1:3
    %     plot3(center3(i,:,1),center3(i,:,2),center3(i,:,3),'-o')
    %     hold on
    % end
    % pause(1)
    % PopObjs=Population.objs;
    % MRDMObjs=Population_MRDM.objs;
    % MRPObjs=Population_MRP.objs;
    % scatter(PopObjs(:,1),PopObjs(:,2))
    % hold on
    % scatter(MRDMObjs(:,1),MRDMObjs(:,2))
    % scatter(MRPObjs(:,1),MRPObjs(:,2))

end