function DataGet()
%% load data
% macOS n=4
% windows n=3
n=4;

data1=xlsread('InputData.xlsx','Pucks');
data2=xlsread('InputData.xlsx','Tickets');
data3=xlsread('InputData.xlsx','Gates');
data2(:,3)=data2(:,3)-43119;
data2(:,5)=data2(:,5)-43119;
Z=length(data1);% Number of flights
N=length(data3);% Number of  gates
Passenger=length(data2);% Number of passengers
date_a=data2(:,3);
date_d=data2(:,5);
ta_i=data1(:,n+14)*24*60;% the time of arrival
td_i=data1(:,n+15)*24*60;% the time of departure
Bii=zeros(Z,Z);
transfer_time=[15,20,35,40;20,15,40,35;35,40,20,30;40,45,30,20];% trasnfer time

%% ���Aij
arrive_i=data1(:,n);
depart_i=data1(:,n+5);
size_i=data1(:,n+1);% the size of body for flight
arrive_j=data3(:,1);
depart_j=data3(:,2);
size_j=data3(:,3);% the size of body for gate
Aij=zeros(Z,N);
arrive_ij=zeros(Z,N);
depart_ij=zeros(Z,N);
size_ij=zeros(Z,N);
for i=1:Z
    for j=1:N
        if arrive_i(i)==arrive_j(j)
            arrive_ij(i,j)=1;
        elseif arrive_j(j)==3
             arrive_ij(i,j)=1; 
        end
        if depart_i(i)==depart_j(j)
            depart_ij(i,j)=1;
        elseif depart_j(j)==3
             depart_ij(i,j)=1; 
        end
        if size_i(i)==size_j(j)
            size_ij(i,j)=1;
        end
    end
end
Aij=arrive_ij.*depart_ij.*size_ij;% is flight i matched to gate j

for i1=1:Z
    for i2=1:Z
        if i1~=i2 && ta_i(i2)-td_i(i1)>=45
            Bii(i2,i1)=1;   %% Judging whether two flights conflict
            Bii(i1,i2)=1;
        end
    end
end
save data

end