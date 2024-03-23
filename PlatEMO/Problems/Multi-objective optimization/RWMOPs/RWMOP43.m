classdef RWMOP43 < PROBLEM
% <multi> <real> <constrained>
% Optimal power flow for minimizing fuel cost, and active power loss

%------------------------------- Reference --------------------------------
% A. Kumar, G. Wu, M. Ali, Q. Luo, R. Mallipeddi, P. Suganthan, and S. Das,
% A benchmark-suite of real-world constrained multi-objective optimization
% problems and some baseline results, Swarm and Evolutionary Computation,
% 2021, 67: 100961.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2024 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        %% Initialization
        function Setting(obj)
            obj.M        = 2;
            obj.D        = 34;
            obj.lower    = [-ones(1,26),zeros(1,8)];
            obj.upper    = ones(1,34);
            obj.encoding = ones(1,obj.D);
        end
        %% Evaluate multiple solutions
        function Population = Evaluation(obj,varargin)
            x = varargin{1};
            G = [   6.0250290557682238e+00  -4.9991316007980346e+00   0.0000000000000000e+00   0.0000000000000000e+00  -1.0258974549701889e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                   -4.9991316007980346e+00   9.5213236108147790e+00  -1.1350191923073958e+00  -1.6860331506149431e+00  -1.7011396670944048e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00  -1.1350191923073958e+00   3.1209949022329564e+00  -1.9859757099255606e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00  -1.6860331506149431e+00  -1.9859757099255606e+00   1.0512989522036175e+01  -6.8409806614956707e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                   -1.0258974549701889e+00  -1.7011396670944048e+00   0.0000000000000000e+00  -6.8409806614956707e+00   9.5680177835602649e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   6.5799234074662225e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -1.9550285631772606e+00  -1.5259674404509740e+00  -3.0989274038379877e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   5.3260550394673585e+00  -3.9020495524474277e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -1.4240054870199310e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -3.9020495524474277e+00   5.7829343061478271e+00  -1.8808847537003996e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -1.9550285631772606e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -1.8808847537003996e+00   3.8359133168776602e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -1.5259674404509740e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   4.0149920272728927e+00  -2.4890245868219187e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -3.0989274038379877e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -2.4890245868219187e+00   6.7249461484662332e+00  -1.1369941578063267e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -1.4240054870199310e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -1.1369941578063267e+00   2.5609996448262580e+00];
            B = [  -1.9447070205514382e+01   1.5263086523179553e+01   0.0000000000000000e+00   0.0000000000000000e+00   4.2349836823348310e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    1.5263086523179553e+01  -3.0272115398779064e+01   4.7818631517577179e+00   5.1158383258720832e+00   5.1939273979697127e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   4.7818631517577179e+00  -9.8223801293516395e+00   5.0688169775939205e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   5.1158383258720832e+00   5.0688169775939205e+00  -3.8654171207607796e+01   2.1578553981691588e+01   0.0000000000000000e+00   4.8895126603173411e+00   0.0000000000000000e+00   1.8554995578159004e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    4.2349836823348310e+00   5.1939273979697127e+00   0.0000000000000000e+00   2.1578553981691588e+01  -3.5533639456044824e+01   4.2574453352533839e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   4.2574453352533839e+00  -1.7340732809919110e+01   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   4.0940743442404415e+00   3.1759639650294003e+00   6.1027554481931157e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   4.8895126603173411e+00   0.0000000000000000e+00   0.0000000000000000e+00  -1.9549005948264654e+01   5.6769798467215438e+00   9.0900827197527505e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   5.6769798467215438e+00  -5.6769798467215438e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   1.8554995578159004e+00   0.0000000000000000e+00   0.0000000000000000e+00   9.0900827197527505e+00   0.0000000000000000e+00  -2.4092506375267877e+01   1.0365394127060915e+01   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   3.0290504569306034e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   1.0365394127060915e+01  -1.4768337876521436e+01   4.4029437494605208e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   4.0940743442404415e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   4.4029437494605208e+00  -8.4970180937009623e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   3.1759639650294003e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00  -5.4279385912016123e+00   2.2519746261722120e+00   0.0000000000000000e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   6.1027554481931157e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   2.2519746261722120e+00  -1.0669693549470679e+01   2.3149634751053521e+00;
                    0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   3.0290504569306034e+00   0.0000000000000000e+00   0.0000000000000000e+00   0.0000000000000000e+00   2.3149634751053521e+00  -5.3440139320359554e+00];
            P = [   0.0000000000000000e+00;
                    2.1700000000000000e-01;
                    9.4200000000000006e-01;
                    4.7799999999999998e-01;
                    7.5999999999999998e-02;
                    1.1199999999999999e-01;
                    0.0000000000000000e+00;
                    0.0000000000000000e+00;
                    2.9499999999999998e-01;
                    8.9999999999999997e-02;
                    3.5000000000000003e-02;
                    6.0999999999999999e-02;
                    1.3500000000000001e-01;
                    1.4899999999999999e-01];
            Q = [   0.0000000000000000e+00;
                    1.2700000000000000e-01;
                    1.9000000000000000e-01;
                   -3.9000000000000000e-02;
                    1.6000000000000000e-02;
                    7.4999999999999997e-02;
                    0.0000000000000000e+00;
                    0.0000000000000000e+00;
                    1.6600000000000001e-01;
                    5.7999999999999996e-02;
                    1.8000000000000002e-02;
                    1.6000000000000000e-02;
                    5.7999999999999996e-02;
                    5.0000000000000003e-02];
            Y = G+1j*B;
            % Voltage initilization
            V    = zeros(14,1);
            V(1) = 1;
            Pg   = zeros(14,1);
            Qg   = zeros(14,1);
            ng   = [1,2,3,6,8];
            a1   = [0,0,0,0,0];
            b1   = [ 2, 1.75,1,3.25,3];
            c1   = [ 0.02,0.0175,0.0625, 0.00834, 0.025];
            for i = 1 : size(x,1)
                V(2:14)       = x(i,1:13)+ 1j*x(i,14:26);
                Pg([2,3,6,8]) = x(i,27:30);
                Qg([2,3,6,8]) = x(i,31:34);
                % Current calculation
                I    = Y*V;
                S    = V.*conj(I);
                Psp  = real(S);
                Qsp  = imag(S);
                delP = Psp-Pg+P;
                delQ = Qsp-Qg+Q;
                % Objective calculation
                f(i,1) = sum(a1 + b1.*Pg(ng)' + c1.*(Pg(ng).^2)');
                f(i,2) = real(V(1).*conj(I(1)))+sum(Psp(2:14));
                h(i,:) = [delP(2:14)',delQ(2:14)'];
            end
            Population = SOLUTION(varargin{1},f,abs(h)-1e-4,varargin{2:end});
            obj.FE     = obj.FE + length(Population);
        end
        %% Generate a point for hypervolume calculation
        function R = GetOptimum(obj,~)
            R = [5.7139516e+00   1.2579325e+00];
        end
    end
end