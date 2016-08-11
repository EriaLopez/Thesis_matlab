clear all

firstSample_offset = 15;
samplesPerLine_offset = 9;
firstR_offset = 16;   
firstTheta_offset = 18;  
firstPhi_offset = 19;    
%Formatted matrix columns
col_lineNumber = 1;
col_sampleNumber = 2;
col_R = 3;
col_theta = 4;
col_phi = 5;
col_X = 3;
col_Y = 4;
col_Z = 5;
sampleSize = 5;

matrix = dlmread('C:\Users\Carmina\Documents\Master\Thesis\SRI500File0.txt');
sizeMatrix = size(matrix);
numOfScanLines = sizeMatrix(1);   %each row is a scan line
'Number of Scan Lines in file:'
numOfScanLines
'Samples Per Line:'
samplesPerLine = matrix(1,samplesPerLine_offset)   %assuming all lines have the same number of samples
'Total samples in file:'
totalSamples = numOfScanLines * samplesPerLine

i=1;
sampleOffset = firstSample_offset;
R_offset = firstR_offset;   
theta_offset = firstTheta_offset;  
phi_offset = firstPhi_offset;   
for i_line = 1:3000                             %numOfScanLines
    sampleOffset = firstSample_offset;
    R_offset = firstR_offset;   
    theta_offset = firstTheta_offset;  
    phi_offset = firstPhi_offset;
    for i_sample = 0:100           %(samplesPerLine-1)
        %Line number
        formattedMatrixSph(i,col_lineNumber) = i_line;
        formattedMatrixCart(i,col_lineNumber) = i_line;
        %Sample number
        formattedMatrixSph(i,col_sampleNumber) = matrix(i_line, sampleOffset);
        formattedMatrixCart(i,col_sampleNumber) = matrix(i_line, sampleOffset);
        %Spherical coordinate
        formattedMatrixSph(i,col_R) = matrix(i_line, R_offset);
        formattedMatrixSph(i,col_theta) = matrix(i_line, theta_offset);
        formattedMatrixSph(i,col_phi) = matrix(i_line, phi_offset);
        %Cartesian coordinate
        [formattedMatrixCart(i,col_X), formattedMatrixCart(i,col_Y), formattedMatrixCart(i,col_Z)] = sph2cart(matrix(i_line, theta_offset),matrix(i_line, phi_offset), matrix(i_line, phi_offset));
        
        sampleOffset = sampleOffset + sampleSize;
        R_offset = R_offset + sampleSize;
        theta_offset = theta_offset + sampleSize;
        phi_offset = phi_offset + sampleSize;
        i = i+1;
    end
end

surf(formattedMatrixCart(:,col_X:col_Y))

