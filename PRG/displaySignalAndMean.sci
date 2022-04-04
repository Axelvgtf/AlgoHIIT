// Copyright (C) 2022 - Corporation - NIERDING Axel
//
// About your license if you have any
//
// Date of creation: 9 mars 2022
//
function graph = displaySignalAndMean(Data,tBeg,tEnd,maxTime,blockDuration)
    n=1                             // Will define a row number in meanValues
while tEnd < maxTime         // Create an iterative loop, as long as tEnd < maxTime  
    meanValues (n,1) = dataMeanOverPeriod(Data,tBeg,tEnd) // calculates the mean values for each block and implements, in meanValues, the new mean at each loop 
    tBeg  =  tBeg + blockDuration  // redefine the beginning of each block at each loop
    tEnd  = tEnd + blockDuration  // redefine the end of each block at each loop
    n = n + 1                 // Add an extra line to meanValue at each loop
end
//


graph = scf()
// Preparing data
x1 = Data(tBeg:blockDuration:$,1)                     // Time data of meanValues
y1 = meanValues(:,1)              // selected data

//
plot2d(x1,y1,style= color("magenta4"))
gce().children.thickness = 3;               // Enlargement of the plot line


endfunction
