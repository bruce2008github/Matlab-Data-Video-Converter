function [outArray, dataLength] = DataFramer(inArray)
%DATAFRAMER Convert data into appropriate video frame
%   Detailed explanation goes here

FrameWidth = 1920;
Frameheight = 1080;
BlockSizeI = 1;
BlockSizeJ = 1;
Repeat = 1;

BlockEndI = FrameWidth/BlockSizeI;
BlockEndJ = Frameheight/BlockSizeJ;
if (floor(BlockEndI) ~= ceil(BlockEndI)) || ...
        (floor(BlockEndJ) ~= ceil(BlockEndJ))
    error('The specified block sizes cannot be fit into 1080p video');
end
outArray = uint8(zeros([Frameheight FrameWidth 3 ceil(numel(inArray)/(BlockEndI*BlockEndJ*3))]));
inArraySize = numel(inArray);
disp('inArrayElementCount:');
disp(inArraySize);
disp('outArraySize:');
disp(size(outArray));
disp('outArrayElementCount:');
disp(numel(outArray)/(BlockSizeI*BlockSizeJ));

dataLength = inArraySize;

%element number
m = 1;
disp('Processing frames');
disp('     ');
for l = 1:size(outArray, 4)
    %colour channel
    for k = 1:size(outArray, 3)
        for i = 1:BlockEndI
            for j = 1:BlockEndJ
                outArray(((j-1)*BlockSizeJ+1):(j*BlockSizeJ), ...
                    ((i-1)*BlockSizeI+1):(i*BlockSizeI), ...
                    k, l) = inArray(m);
                m = m + 1;
                fprintf('\b\b\b\b\b\b%05.2f%%', m/inArraySize*100);
                if m > inArraySize
                    disp(' ');
                    disp('Terminated at:');
                    disp(m - 1);
                    return; 
                end
            end
        end
    end
end
disp(' ');
end
