% Author: Yatu Li, University College London, 2017
% To plot the bar charts of Started, Relayed, Aborted, Delivery Probability
% Overhead Ratio and Average Latency


%% 170 Pedestrains 
% MessageStates is a 9*8 numeric Matrix imported from the Excel,
% MessagesState.xlsx
% 9 different Routers, RegularEnergy, EnergyAware and NoEnergy.
% Within each group, the sequence of Routers is: DDR, ER and SAW
StartedAll  = MessageStates (:, 1);
RelayedAll = MessageStates (:, 2);
AbortedAll = MessageStates (:, 3);
DropedAll = MessageStates (:, 4);
DeliveryProAll = MessageStates (:, 5);
OverheadRatAll = MessageStates (:,6);
LatencyAvgAll = MessageStates (:, 7);
BufferTimeAll = MessageStates (:, 8);

% Delivery Pro
f1 = figure;
set(f1, 'name', 'Delivery Probability with 170 Pedestrains', 'numbertitle', 'off');
DPAY = [DeliveryProAll(7) DeliveryProAll(4) DeliveryProAll(1);
        DeliveryProAll(8) DeliveryProAll(5) DeliveryProAll(2);
        DeliveryProAll(9) DeliveryProAll(6) DeliveryProAll(3)]
DPB = bar(DPAY);
hold on
grid on
LimitsOf_f1 = axis;
% alter the y-limits of bar chart of f1, x-axix is remained
ylim([0 0.2]);
% add up the percentage ticks on y-axis
yticks([0, 0.02, 0.04 0.06, 0.08, 0.10, 0.12, 0.14, 0.16, 0.18, 0.20]);
yticklabels({'0', '2%','4%', '6%','8%','10%','12%','14%','16%','18%','20%'});
set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'});
DPL = cell(1,3);
DPL{1} = 'Ideal';
DPL{2} = 'EnergyAware';
DPL{3} = 'RegularEnergyModel';
DPLegend = legend(DPB,DPL);
set(DPLegend, 'Location', 'BestOutside');
title('Delivery Probability Comparsion');
ylabel('Delivery Probability');
xlabel('Routing Schemes');
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Latency Avg
f2 = figure;
set(f2, 'name', 'Average Latency with 170 Pedestrains', 'numbertitle', 'off');
LAY = [LatencyAvgAll(7) LatencyAvgAll(4) LatencyAvgAll(1);
        LatencyAvgAll(8) LatencyAvgAll(5) LatencyAvgAll(2);
        LatencyAvgAll(9) LatencyAvgAll(6) LatencyAvgAll(3)]
LAB = bar(LAY);
hold on
grid on
% get current plot's handler to change its property, like y-limits.
%f2Hand = LAB.;
% return the limits of the initial axis
%LimitsOf_f2 = f2Hand.axis;
% Alter the y-limit of the graph
ylim([0 4500]);

set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'}, 'fontsize', 20);
LAL = cell(1,3);
LAL{1} = 'Ideal';
LAL{2} = 'EnergyAware';
LAL{3} = 'RegularEnergyModel';
LALegend = legend(LAB,LAL);
set(LALegend, 'Location', 'BestOutside');
title('Average Latency Comparsion', 'fontsize', 20);
ylabel('Average Latency (s)', 'fontsize', 20);
xlabel('Routing Schemes', 'fontsize', 20);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Overhead Avg
f3 = figure;
set(f3, 'name', 'Average Overhead Ratio with 170 Pedestrains', 'numbertitle', 'off');
OAY = [OverheadRatAll(7) OverheadRatAll(4) OverheadRatAll(1);
        OverheadRatAll(8) OverheadRatAll(5) OverheadRatAll(2);
        OverheadRatAll(9) OverheadRatAll(6) OverheadRatAll(3)]
OAB = bar(OAY);
hold on
grid on

% Alter the y-limit of the graph
ylim([0 550]);

set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'});
OAL = cell(1,3);
OAL{1} = 'Ideal';
OAL{2} = 'EnergyAware';
OAL{3} = 'RegularEnergyModel';
OALegend = legend(OAB,OAL);

% reserved for change the limts of the y-axis in case of 499 is too close
% to 500, being the upper limit of y-axis in this bar char. 21/02/2017
% axis = ([0.5, 3.5, 0, 1000]);
set(OALegend, 'Location', 'BestOutside');
title('Average Overhead Ratio Comparison');
ylabel('Average Overhead Ratio');
xlabel('Routing Schemes');
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Buffer Time Avg
f4 = figure;
set(f4, 'name', 'Average Buffer Time with 170 Pedestrains', 'numbertitle', 'off');
BTAY = [BufferTimeAll(7) BufferTimeAll(4) BufferTimeAll(1);
        BufferTimeAll(8) BufferTimeAll(5) BufferTimeAll(2);
        BufferTimeAll(9) BufferTimeAll(6) BufferTimeAll(3)]
BTAB = bar(BTAY);
hold on
grid on

set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'});
BTAL = cell(1,3);
BTAL{1} = 'Ideal';
BTAL{2} = 'EnergyAware';
BTAL{3} = 'RegularEnergyModel';
BTALegend = legend(BTAB,OAL);

% reserved for change the limts of the y-axis in case of 499 is too close
% to 500, being the upper limit of y-axis in this bar char. 21/02/2017
% axis = ([0.5, 3.5, 0, 1000]);
set(BTALegend, 'Location', 'BestOutside');
title('Average Buffer Time Comparison with 170 Pedestrians');
ylabel('Average Buffer Time (s)');
xlabel('Routing Schemes');
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off





%% 510 Pedestrains
% MessageStatesSec is a 9*8 numeric Matrix imported from the Excel,
% MessagesState.xlsx
% 9 different Routers, RegularEnergy, EnergyAware and NoEnergy.
% Within each group, the sequence of Routers is: DDR, ER and SAW

StartedAllSec  = MessageStatesSec (:, 1);
RelayedAllSec = MessageStatesSec (:, 2);
AbortedAllSec = MessageStatesSec (:, 3);
DropedAllSec = MessageStatesSec (:, 4);
DeliveryProAllSec = MessageStatesSec (:, 5);
OverheadRatAllSec = MessageStatesSec (:,6);
LatencyAvgAllSec = MessageStatesSec (:, 7);
BufferTimeAllSec = MessageStatesSec (:, 8);

%% Delivery Pro
f5 = figure;
set(f5, 'name', 'Delivery Probability with 510 Pedestrains', 'numbertitle', 'off');
DPA2Y = [DeliveryProAllSec(7) DeliveryProAllSec(4) DeliveryProAllSec(1);
        DeliveryProAllSec(8) DeliveryProAllSec(5) DeliveryProAllSec(2);
        DeliveryProAllSec(9) DeliveryProAllSec(6) DeliveryProAllSec(3)];
DP2B = bar(DPA2Y);
hold on
grid on
% alter the y-limits of bar chart of f1, x-axix is remained
ylim([0 0.22]);

% add up the percentage ticks on y-axis
yticks([0, 0.02, 0.04 0.06, 0.08, 0.10, 0.12, 0.14, 0.16, 0.18, 0.20, 0.22]);
yticklabels({'0', '2%','4%', '6%','8%','10%','12%','14%','16%','18%','20%','22%'});
set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'});
DP2L = cell(1,3);
DP2L{1} = 'Ideal';
DP2L{2} = 'EnergyAware';
DP2L{3} = 'RegularEnergyModel';
DP2Legend = legend(DP2B,DP2L);
set(DP2Legend, 'Location', 'BestOutside');
title('Delivery Probability Comparsion');
ylabel('Delivery Probability');
xlabel('Routing Schemes');
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Latency Avg
f6 = figure;
set(f6, 'name', 'Average Latency with 510 Pedestrains', 'numbertitle', 'off');
LA2Y = [LatencyAvgAllSec(7) LatencyAvgAllSec(4) LatencyAvgAllSec(1);
        LatencyAvgAllSec(8) LatencyAvgAllSec(5) LatencyAvgAllSec(2);
        LatencyAvgAllSec(9) LatencyAvgAllSec(6) LatencyAvgAllSec(3)]
LA2B = bar(LA2Y);
hold on
grid on
set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'}, 'fontsize', 20);
LA2L = cell(1,3);
LA2L{1} = 'Ideal';
LA2L{2} = 'EnergyAware';
LA2L{3} = 'RegularEnergyModel';
LA2Legend = legend(LA2B,LA2L);
set(LA2Legend, 'Location', 'BestOutside');
title('Average Latency Comparsion', 'fontsize', 20);
ylabel('Average Latency (s)', 'fontsize', 20);
xlabel('Routing Schemes', 'fontsize', 20);

hold off

%% Overhead Avg
f7 = figure;
set(f7, 'name', 'Average Overhead Ratio with 510 Pedestrains', 'numbertitle', 'off');
OA2Y = [OverheadRatAllSec(7) OverheadRatAllSec(4) OverheadRatAllSec(1);
        OverheadRatAllSec(8) OverheadRatAllSec(5) OverheadRatAllSec(2);
        OverheadRatAllSec(9) OverheadRatAllSec(6) OverheadRatAllSec(3)]
OA2B = bar(OA2Y);
hold on
grid on
set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'}, 'fontsize', 20);
OA2L = cell(1,3);
OA2L{1} = 'Ideal';
OA2L{2} = 'EnergyAware';
OA2L{3} = 'RegularEnergyModel';
OA2Legend = legend(OA2B,OA2L);

% reserved for change the limts of the y-axis in case of 499 is too close
% to 500, being the upper limit of y-axis in this bar char. 21/02/2017
% axis = ([0.5, 3.5, 0, 1000]);
set(OA2Legend, 'Location', 'BestOutside');
title('Average Overhead Ratio Comparison', 'fontsize', 20);
ylabel('Average Overhead Ratio', 'fontsize', 20);
xlabel('Routing Schemes', 'fontsize', 20);
hold off

%% Buffer Time Avg
f8 = figure;
set(f8, 'name', 'Average Buffer Time with 510 Pedestrains', 'numbertitle', 'off');
BTA2Y = [BufferTimeAllSec(7) BufferTimeAllSec(4) BufferTimeAllSec(1);
        BufferTimeAllSec(8) BufferTimeAllSec(5) BufferTimeAllSec(2);
        BufferTimeAllSec(9) BufferTimeAllSec(6) BufferTimeAllSec(3)]
BTA2B = bar(BTA2Y);
hold on
grid on

set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'}, 'fontsize', 20);
BTA2L = cell(1,3);
BTA2L{1} = 'Ideal';
BTA2L{2} = 'EnergyAware';
BTA2L{3} = 'RegularEnergyModel';
BTA2Legend = legend(BTA2B,OA2L);

% reserved for change the limts of the y-axis in case of 499 is too close
% to 500, being the upper limit of y-axis in this bar char. 21/02/2017
% axis = ([0.5, 3.5, 0, 1000]);
set(BTA2Legend, 'Location', 'BestOutside');
title('Average Buffer Time Comparison ', 'fontsize', 18);
ylabel('Average Buffer Time (s)', 'fontsize', 20);
xlabel('Routing Schemes', 'fontsize', 20);
hold off





%% 340 Pedestrains
% MessageStatesSec is a 9*8 numeric Matrix imported from the Excel,
% MessagesState.xlsx
% 9 different Routers, RegularEnergy, EnergyAware and NoEnergy.
% Within each group, the sequence of Routers is: DDR, ER and SAW

StartedAllThi  = MessageStatesThi (:, 1);
RelayedAllThi = MessageStatesThi (:, 2);
AbortedAllThi = MessageStatesThi (:, 3);
DropedAllThi = MessageStatesThi (:, 4);
DeliveryProAllThi = MessageStatesThi (:, 5);
OverheadRatAllThi = MessageStatesThi (:,6);
LatencyAvgAllThi = MessageStatesThi (:, 7);
BufferTimeAllThi = MessageStatesThi (:, 8);

%% Delivery Pro
f9 = figure;
set(f9, 'name', 'Delivery Probability with 340 Pedestrains', 'numbertitle', 'off');
DPA3Y = [DeliveryProAllThi(7) DeliveryProAllThi(4) DeliveryProAllThi(1);
        DeliveryProAllThi(8) DeliveryProAllThi(5) DeliveryProAllThi(2);
        DeliveryProAllThi(9) DeliveryProAllThi(6) DeliveryProAllThi(3)];
DP3B = bar(DPA3Y);
hold on
grid on
% alter the y-limits of bar chart of f1, x-axix is remained
ylim([0 0.22]);
% add up the percentage ticks on y-axis
yticks([0, 0.02, 0.04 0.06, 0.08, 0.10, 0.12, 0.14, 0.16, 0.18, 0.20, 0.22]);
yticklabels({'0', '2%','4%', '6%','8%','10%','12%','14%','16%','18%','20%', '22%'});
set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'});
DP3L = cell(1,3);
DP3L{1} = 'Ideal';
DP3L{2} = 'EnergyAware';
DP3L{3} = 'RegularEnergyModel';
DP3Legend = legend(DP3B,DP3L);
set(DP3Legend, 'Location', 'BestOutside');
title('Delivery Probability Comparsion');
ylabel('Delivery Probability');
xlabel('Routing Schemes');
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Latency Avg
f10 = figure;
set(f10, 'name', 'Average Latency with 340 Pedestrains', 'numbertitle', 'off');
LA3Y = [LatencyAvgAllThi(7) LatencyAvgAllThi(4) LatencyAvgAllThi(1);
        LatencyAvgAllThi(8) LatencyAvgAllThi(5) LatencyAvgAllThi(2);
        LatencyAvgAllThi(9) LatencyAvgAllThi(6) LatencyAvgAllThi(3)]
LA3B = bar(LA3Y);
hold on
grid on

ylim([0 7000]);
set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'});
LA3L = cell(1,3);
LA3L{1} = 'Ideal';
LA3L{2} = 'EnergyAware';
LA3L{3} = 'RegularEnergyModel';
LA3Legend = legend(LA3B,LA3L);
set(LA3Legend, 'Location', 'BestOutside');
title('Average Latency Comparsion');
ylabel('Average Latency (s)');
xlabel('Routing Schemes');
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Overhead Avg
f11 = figure;
set(f11, 'name', 'Average Overhead Ratio with 340 Pedestrains', 'numbertitle', 'off');
OA3Y = [OverheadRatAllThi(7) OverheadRatAllThi(4) OverheadRatAllThi(1);
        OverheadRatAllThi(8) OverheadRatAllThi(5) OverheadRatAllThi(2);
        OverheadRatAllThi(9) OverheadRatAllThi(6) OverheadRatAllThi(3)]
OA3B = bar(OA3Y);
hold on
grid on
set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'}, 'fontsize', 20);
OA3L = cell(1,3);
OA3L{1} = 'Ideal';
OA3L{2} = 'EnergyAware';
OA3L{3} = 'RegularEnergyModel';
OA3Legend = legend(OA3B,OA3L);

% reserved for change the limts of the y-axis in case of 499 is too close
% to 500, being the upper limit of y-axis in this bar char. 21/02/2017
% axis = ([0.5, 3.5, 0, 1000]);
set(OA3Legend, 'Location', 'BestOutside');
title('Average Overhead Ratio Comparison', 'fontsize', 20);
ylabel('Average Overhead Ratio', 'fontsize', 20);
xlabel('Routing Schemes', 'fontsize', 20);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Buffer Time Avg
f12 = figure;
set(f12, 'name', 'Average Buffer Time with 510 Pedestrains', 'numbertitle', 'off');
BTA3Y = [BufferTimeAllThi(7) BufferTimeAllThi(4) BufferTimeAllThi(1);
        BufferTimeAllThi(8) BufferTimeAllThi(5) BufferTimeAllThi(2);
        BufferTimeAllThi(9) BufferTimeAllThi(6) BufferTimeAllThi(3)]
BTA3B = bar(BTA3Y);
hold on
grid on

set(gca, 'XTickLabel', {'Direct Delivery', 'Epidemic', 'SprayAndWait'}, 'fontsize', 20);
BTA3L = cell(1,3);
BTA3L{1} = 'Ideal';
BTA3L{2} = 'EnergyAware';
BTA3L{3} = 'RegularEnergyModel';
BTA3Legend = legend(BTA3B,OA3L);

% reserved for change the limts of the y-axis in case of 499 is too close
% to 500, being the upper limit of y-axis in this bar char. 21/02/2017
% axis = ([0.5, 3.5, 0, 1000]);
set(BTA3Legend, 'Location', 'BestOutside');
title('Average Buffer Time Comparison', 'fontsize', 18);
ylabel('Average Buffer Time (s)', 'fontsize', 20);
xlabel('Routing Schemes', 'fontsize', 20);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off
