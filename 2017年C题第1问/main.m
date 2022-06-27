clc
clear all
dataget()
load data
[fitness,time]=get_delay_time(Aij1);
iter_max=100;
Zbest=fitness;
tic
for i=1:iter_max
    disp(['the number of iter is ',num2str(i)])
    Aij=ones(length(Aircrafts),length(flights));%Aircrafts i is assigned  flights j
    assign_i=ones(length(flights),1);
    n_A=length(Aircrafts);%the length of Aircrafts
    all_time=0;%the sum of Interval time
    for n=1:n_A
        n_airpot=Aircrafts(n,3);%Departure_airpot
        n_Departure_time=Aircrafts(n,1);%Departure_time
        n_arrive_time=Aircrafts(n,2);%arrive_time
        [pos1,Aij]=find_pos1(n,n_airpot,n_Departure_time,n_arrive_time,Aij);%Random selection of suitable flights
        while ~isempty(pos1)
             port_arrive_time1=flights(pos1,2);%the arrive time of the 1st flight.
             arrive_airpot=flights(pos1,4);
             [pos1,Aij]=find_pos2(n,arrive_airpot,n_arrive_time,port_arrive_time1,Aij);   %Random selection of suitable flights  
        end
    end
    [fitness2,time2]=get_delay_time(Aij);
    if fitness2<fitness
        Aij1=Aij;
        fitness=fitness2;
        time=time2;
    end
    Zbest=[Zbest,fitness];
end
Zbest=Zbest/3600;
figure
xlabel('Number of iterations'); 
ylabel('delay_time(h)');
hold on
plot(Zbest);
toc
for i=1:length(Aircrafts)
    for j=1:length(flights)
        if Aij1(i,j)==0
           air1= No_Aircrafts{i};
           flight1= No_Schedules(j);
           delay_time=time(i,j);
            disp(['No. ', air1 ,' aircraft was assigned to flight No. ' ,num2str(flight1) ,' with a delay of ', num2str(delay_time),'s'])
        end
    end
end