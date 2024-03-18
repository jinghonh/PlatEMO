function [Population,center,h] = MRP(Problem,Population,LastPopulation,center)
% 划分子区域
    obj_g=Population.objs;
    obj_g_1=LastPopulation.objs;
    u=max(obj_g);
    l=min(obj_g);
    delta_f=(obj_g-obj_g_1)./(u-l);
    mu=mean(abs(delta_f));
    delta=mean(mean(delta_f-repmat(mu,size(delta_f,1),1)));
    M=size(obj_g,2);
    k1=M+1;
    k2=M*2;
    k=ceil(k1+delta*(k2-k1));
    fprintf("k=%d\n",k);
    [W,~]=UniformPoint(k,size(obj_g,2),"MUD");
% 个体关联
    distance=zeros(size(obj_g,1),k);
    for i = 1:size(distance,1)
        for j = 1:size(distance,2)
            distance(i,j)=Point2VectorDistance(obj_g(i,:),W(j,:));
        end
    end
    
    [~,h]=min(distance,[],2);
    % 先验证分区是否正确
    % figure
    % scatter(obj_g(:,1),obj_g(:,2));
    % hold on
    % scatter(obj_g_1(:,1),obj_g_1(:,2))
    % for i = 1:size(W, 1)
    %     direction_vector = W(i,:);
    %     plot([0, direction_vector(1)], [0, direction_vector(2)], 'LineWidth', 2);
    % end

% 确定进化步长
    % 确定中心点位置
    % k个区域有k个中心点，每个中心点为1*N的向量
    decs=Population.decs;
    center_t = zeros(k,size(decs,2));
    
    for i = 1:k
        center_t(i,:) = mean(decs(h==i,:));
    end
    center{end+1}=center_t;
    if size(center,2)<=1
    else
        delta_c=center{end}-center{end-1};
        for i = 1:length(decs)
            decs(i,:)=decs(i,:)+delta_c(h(i),:);
        end
        % Population.decs=decs;
        % PopObj=Problem.CalObj(decs);
        % Population = SOLUTION(decs,PopObj,Population.cons,zeros(size(decs,1),1)+Problem.FE);

        % Population = SOLUTION(decs,PopObj,Population.cons);
    end
    Population = Problem.Evaluation(decs);
    Problem.FE=Problem.FE - length(Population);
    
    

end

function distance = Point2VectorDistance(point, vector)
    
    % 计算点到向量的投影点
    projection_point = (dot(point, vector) / dot(vector, vector)) * vector;
    
    % 计算点到投影点的距离
    distance = norm(point - projection_point);
end