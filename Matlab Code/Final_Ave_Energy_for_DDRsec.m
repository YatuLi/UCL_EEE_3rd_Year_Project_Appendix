% Author: Yatu Li, University College London, 2017
%% 510 Pedestrains
% Import data from text file and give out 1 * 48 Ave Energy for Pedestrains for plots
%
% Each time, when we have adjusted the directory of the
% XXXEnergy_Level_Report, we only need to change the filename.
%% Initialize variables.
filename = 'C:\Users\Yatu\Documents\UCL\3rd Year\Project\ONE 1.6\the-one-1.6.0\Yatu''s Files\19_02_2017\Reports\DR2\DDRouter_Scenario_EnergyLevelReport.txt';
delimiter = ' ';

%% Read columns of data as text:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric text to numbers.
% Replace non-numeric text with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2]
    % Converts text in the input cell array to numbers. Replaced non-numeric
    % text with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric text to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
DDRouterScenarioEnergyLevelReportSec = cell2mat(raw);
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me R;

%% get imported Energy Levels into 48 splitted column vector format
Splitted_DDR_MatSec = reshape(DDRouterScenarioEnergyLevelReportSec(:,2), 535, 48);
PurePedestrainsForDDRSec = Splitted_DDR_MatSec ([4:63 66:125 128:187 190:249 252:311 314: 373 376:435 440:499 500:529], :);
TotalEnergyOfAllPedestrainsSec = sum(PurePedestrainsForDDRSec);
FinalAnswerOfDDRSec = TotalEnergyOfAllPedestrainsSec * (1/510);
% to insert the Avgerage Energy in the beginning of the Day
FinalAnswerOfDDRSec = [10e+03 FinalAnswerOfDDRSec(1,:)];
% to convert the Average Energy into percentage
PercentFinalAnswerOfDDRSec = FinalAnswerOfDDRSec * (1/(10e+03));

clearvars TotalEnergyOfAllPedestrainsSec;
%% End