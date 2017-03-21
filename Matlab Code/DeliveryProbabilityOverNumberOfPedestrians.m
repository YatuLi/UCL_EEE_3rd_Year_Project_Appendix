% Author: Yatu Li, University College London, 2017
% Subplot of MessageStates in terms of each metrix of performance,
% Line Plots

%% Load the MessageStates from Workspace, all LHS are 9-by-1 column vectors. 
% The sequence: DDR; ER; SAW; EADR; EAER; EASAW; DDRNE; ERNE; SAWNE.
% Originate 3 independent variables for curves;
NumOfPed = [170 340 510];
% 170
StartedAll  = MessageStates (:, 1);
RelayedAll = MessageStates (:, 2);
AbortedAll = MessageStates (:, 3);
DropedAll = MessageStates (:, 4);
DeliveryProAll = MessageStates (:, 5);
OverheadRatAll = MessageStates (:,6);
LatencyAvgAll = MessageStates (:, 7);
BufferTimeAll = MessageStates (:, 8);
% 510 - Sec
StartedAllSec  = MessageStatesSec (:, 1);
RelayedAllSec = MessageStatesSec (:, 2);
AbortedAllSec = MessageStatesSec (:, 3);
DropedAllSec = MessageStatesSec (:, 4);
DeliveryProAllSec = MessageStatesSec (:, 5);
OverheadRatAllSec = MessageStatesSec (:,6);
LatencyAvgAllSec = MessageStatesSec (:, 7);
BufferTimeAllSec = MessageStatesSec (:, 8);
% 340 - Thi
StartedAllThi  = MessageStatesThi (:, 1);
RelayedAllThi = MessageStatesThi (:, 2);
AbortedAllThi = MessageStatesThi (:, 3);
DropedAllThi = MessageStatesThi (:, 4);
DeliveryProAllThi = MessageStatesThi (:, 5);
OverheadRatAllThi = MessageStatesThi (:,6);
LatencyAvgAllThi = MessageStatesThi (:, 7);
BufferTimeAllThi = MessageStatesThi (:, 8);

%% Delivery Probability
DP_DRNE = [DeliveryProAll(7) DeliveryProAllThi(7) DeliveryProAllSec(7)];
DP_DR = [DeliveryProAll(1) DeliveryProAllThi(1) DeliveryProAllSec(1)];
DP_EADR = [DeliveryProAll(4) DeliveryProAllThi(4) DeliveryProAllSec(4)];

DP_ERNE = [DeliveryProAll(8) DeliveryProAllThi(8) DeliveryProAllSec(8)];
DP_ER = [DeliveryProAll(2) DeliveryProAllThi(2) DeliveryProAllSec(2)];
DP_EAER = [DeliveryProAll(5) DeliveryProAllThi(5) DeliveryProAllSec(5)];

DP_SAWNE = [DeliveryProAll(9) DeliveryProAllThi(9) DeliveryProAllSec(9)];
DP_SAW = [DeliveryProAll(3) DeliveryProAllThi(3) DeliveryProAllSec(3)];
DP_EASAW = [DeliveryProAll(6) DeliveryProAllThi(6) DeliveryProAllSec(6)];

%% DD
SubMSDPPlot1 = figure;
set(SubMSDPPlot1, 'name', 'Delivery Probability for Direct Delivery', 'numbertitle', 'off');
plot(NumOfPed, DP_DRNE, '-blue+', NumOfPed, DP_DR, '-green*', NumOfPed, DP_EADR, '-redx' );
hold on
grid on
ylim([0 0.15]);
yticks([0, 0.05, 0.10, 0.15]);
yticklabels({'0', '5%', '10%', '15%'});
legend('Ideal' , 'RegularEnergyModel', 'EnergyAware');
legend('Location', 'NorthEast');
set(legend, 'location','bestoutside');
title('Delivery Probability for Direct Delivery');
ylabel('Deliv Probability');
xlabel('Num of Pedestrians');
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Epidemic
SubMSDPPlot2 = figure;
set(SubMSDPPlot2, 'name', 'Delivery Probability for Epidemic', 'numbertitle', 'off');
plot(NumOfPed, DP_ERNE, '-blue+', NumOfPed, DP_ER, '-green*', NumOfPed, DP_EAER, '-redx' );
hold on
grid on
ylim([0 0.15]);
yticklabels({'0', '5%', '10%', '15%'});
yticks([0, 0.05, 0.10, 0.15]);
legend('Ideal' , 'RegularEnergyModel', 'EnergyAware');
legend('Location', 'NorthEast');
set(legend, 'location','bestoutside');
title('Delivery Probability for Epidemic');
ylabel('Deliv Probability');
xlabel('Num of Pedestrians');
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Spary and Wait
SubMSDPPlot3 = figure;
set(SubMSDPPlot3, 'name', 'Delivery Probability for Spray and Wait', 'numbertitle', 'off');
plot(NumOfPed, DP_SAWNE, '-blue+', NumOfPed, DP_SAW, '-green*', NumOfPed, DP_EASAW, '-redx' );
hold on
grid on
ylim([0 0.25]);
yticklabels({'0', '5%', '10%', '15%', '20%', '25%'});
yticks([0, 0.05, 0.10, 0.15 0.20 0.25]);
legend('Ideal' , 'RegularEnergyModel', 'EnergyAware ');
legend('Location', 'NorthEast');
set(legend, 'location','bestoutside');
title('Delivery Probability for Spray and Wait');
ylabel('Deliv Probability');
xlabel('Num of Pedestrians');
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off




