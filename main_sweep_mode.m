clear;

%% set scanning parameters

lambda=1.5:0.01:1.6; % set labmda scanning range
bus_width=2:0.03:2.3; %  unit: um

%% initiallize result matrix
neff_matrix=zeros(length(lambda),length(bus_width));

%% basic parameters (should not be changed while in other folder)
rb_instructor='bus';  % select calculate bus or ring

r_ring=240; % radius unit: um

ring_width=4;  % length unit: um

thickness=265;  % height unit: nm

gap=0.7;  %  unit: um

% bus_width=2.2; %  unit: um

n_guess_facotr=1.55;

%% call function 
for n=1:length(bus_width)
    neff_matrix(n,:)=sweep_mode(rb_instructor, r_ring, ring_width, thickness, gap, bus_width(n), n_guess_facotr, lambda);
end

%% data storage

save('bus_width_scanning.mat','lambda','bus_width','neff_matrix');

%% comparison

load('sweep_ring_mode_r=240_width=4_h=265.mat');
neff_ring=neff;
load('bus_width_scanning.mat');
dev=ones(length(bus_width),length(lambda));
for n=1:length(bus_width)
    for m=1:length(lambda)
        dev(n,m)=abs(real(neff_matrix(n,m)-neff_ring(1,m)));  % get deviation 
    end
end

figure;

for n=1:length(bus_width)
    %scatter(lambda,dev(n,:),'filled','LineWidth',1.5);
    plot(lambda,dev(n,:));
    %legend(['width= ',num2str(bus_width(n))]);
    hold on;
end

for n=1:length(bus_width)
    leg=[leg,'width=',num2str(bus_width(n))];
end

hold off;
