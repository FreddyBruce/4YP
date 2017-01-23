%DRAWS THE NETWORK BASED ON COMMUNITY STRUCTURE
% It requires a "Groups" variable and a weights
% "W" variable, while it outputs a figure object
% 
% The W (NxN) is the usual weight matrix (you can also provide the
% adjacency matrix A, for the case of a unweighted graph)
% 
% The Groups array is a cell(Kx1) where K is the number of communities.
% Each element Groups{k} stores the indices (from 1 to N) of elements
% that belong to community-k. For example, for N=5 and K=2 communities,
% the Groups array might be:
% Groups = {
% [ 3 4 1]
% [ 2 5]
% }

% Ioannis Psorakis, PARG 2010

function cg = community_graph(Groups,W)
%% INITIALIZATIONs

%RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));

Wmax = max(max(W));
A=1*(W>0);

N = size(W,1);
groups_number = max(size(Groups));
coordinate_multiplier = 10;

%% PRODUCE GRID
grid_occupation = zeros(groups_number);
grid_XY = zeros(groups_number,2);

%% ASSIGN GROUPS TO GRID POINTS
for i=1:groups_number
    found_empty=false;
    while ~found_empty
        occ_index_X = ceil(rand(1)*groups_number);
        occ_index_Y = ceil(rand(1)*groups_number);
        if grid_occupation(occ_index_X,occ_index_Y)==0
            grid_occupation(occ_index_X,occ_index_Y) = i;
            grid_XY(i,:) = [occ_index_X occ_index_Y].*coordinate_multiplier;
            found_empty=true;
        end
    end 
end

%% ASSIGN COORDINATES TO EACH NODE
nodesXY = zeros(N,2);
for i = 1:N
    [group_membership isunique] = find_group_membership(Groups,i);

    if ~isunique
       theta = 2*pi*rand(1);
       r=(coordinate_multiplier/2)*(1.01- degree(W(:,Groups{group_membership,1}),i)/length(Groups{group_membership,1}));
       x = r*cos(theta);
       y = r*sin(theta);
    else
        x=0;
        y=0;        
    end
    nodesXY(i,1) = grid_XY(group_membership,1) + x;
    nodesXY(i,2) = grid_XY(group_membership,2) + y;
end

%% PLOT
clf
hold on
cg = scatter(nodesXY(:,1),nodesXY(:,2));

for i=1:groups_number
   circle(grid_XY(i,:),coordinate_multiplier/2,1000,'--b');
end

for i=1:N-1
    for j=i+1:N
        if W(i,j)>0
            line([nodesXY(i,1) nodesXY(j,1)],[nodesXY(i,2) nodesXY(j,2)],...
                'Color',[(W(i,j)/Wmax) 1-(W(i,j)/Wmax) 0],'LineWidth',ceil(2*((W(i,j)/Wmax))));
        end
    end
end

title(strcat('Community network'));
for i=1:N
   text(nodesXY(i,1),nodesXY(i,2),num2str(i),'BackgroundColor',[.7 .9 .7]); 
end
hold off
end

function [group isunique] = find_group_membership(Groups,elem)
    number = max(size(Groups));
    for i=1:number
        if ~isempty( find(Groups{i}==elem) )
           group=i;
           if length(Groups{i})==1
               isunique=true;
           else
               isunique=false;
           end
           break;
        end
    end
end

%% AUXILIARY FUNCTIONs
function H=circle(center,radius,NOP,style)
% NOT MY FUNCTION, DOWNLOADED FROM MATHWORKS WEB SITE
%---------------------------------------------------------------------------------------------
% H=CIRCLE(CENTER,RADIUS,NOP,STYLE)
% This routine draws a circle with center defined as
% a vector CENTER, radius as a scaler RADIS. NOP is 
% the number of points on the circle. As to STYLE,
% use it the same way as you use the rountine PLOT.
% Since the handle of the object is returned, you
% use routine SET to get the best result.
%
%   Usage Examples,
%
%   circle([1,3],3,1000,':'); 
%   circle([2,4],2,1000,'--');
%
%   Zhenhai Wang <zhenhai@ieee.org>
%   Version 1.00
%   December, 2002
%---------------------------------------------------------------------------------------------

if (nargin <3),
 error('Please see help for INPUT DATA.');
elseif (nargin==3)
    style='b-';
end;
THETA=linspace(0,2*pi,NOP);
RHO=ones(1,NOP)*radius;
[X,Y] = pol2cart(THETA,RHO);
X=X+center(1);
Y=Y+center(2);
H=plot(X,Y,style);
axis square;
end

function k = degree(A,nodes)
A(A~=0)=1;

if ~exist('nodes','var')
    nodes = 1:1:size(A,1);
end

k=sum(A(nodes,:),2);
end