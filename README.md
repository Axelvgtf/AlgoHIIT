# AlgoHIIT

## Context

With the progress and development of connected watchs and heart rate monitors (watchs / bands), the number of studies using these technologies has increased since 20s.

In sports science, these technologies are useful for both researchers and research students who want to monitor heart rate.
Among the most commonly tested exercise programs with both health and performance benefits, HIIT (High Intensity Intervals Training) stands out.

Therefore, to facilitate the analysis of data from a HIIT session by a heart rate monitor (watch / band), I created AlgoHIIT.

## AlgoHIIT:

AlgoHIIT is divised into 3 separates programs (GlobalCondition ; HIIT ; RecuperationPostHIIT) which works both separatly or together as you want.
AlgoHIIT file grouping : 
	
	* `DAT` : data extracted from Polar setup in .csv from polarflow website
	* `PRG` : HIIT, GlobalCondition and RecuperationPostHIIT script and function include in the script 
	* `RES` : Graphic and results report.
	
Each program has its advantages:


### GlobalCondition

`GlobalCondition.sce` is useful if you want to look at HIIT as well as recovery period and extracts data/plot from your BPM during global condition.
This program allows you :

* Automatically save your BPM averages at regular intervals in a csv file
* Determine your average BPM throughout the session
* Realize a complete plot of the session by discriminating the warm-up, the HIIT and the recovery period
* Realize a complete plot based on BPM average intervals (smoother) with warm-up, HIIT and the recovery period

Each plot and BPM average is automatically saved on folder RES

These data tells you more about your vascular stress, an overall cinetic of your recuperation and if you are reached -or not- your goal in BPM terms.

#### Usage

* Clone or download the repository
* On your computer, open `GlobalCondition.sce`, indicate the time of your warm-up and HIIT (line 64/69), then run the script with F5 or click the button with grey triangle to make an overview of your HIIT protocol + Recuperation post HIIT in terms of BPM. 

Notes: the default block duration period for regular intervals is : 60s (line 147)


### HIIT

`HIIT.sce` is useful is you want to look more closely at HIIT and extracts data/plot from your BPM during HIIT
This program allows you :

* Automatically save your BPM averages at your interval of HIIT in a csv file
* Automatically save your BPM averages from High intensity intervals in a csv file
* Automatically save your BPM averages from rest intervals in csv file
* Determine your average BPM troughout the HIIT
* Overview of your time above YOUR BPM zone of interest during your HIIT
* Your max BPM reach during HIIT
* Realize a complete plot of the HIIT with line of your average BPM and your zone of interest to determine if you reach the goal
* Realize a smoother plot based on averages BPM (you determine) with line of your average BPM and your zone of interest

Each plot and BPM average is automatically saved on folder RES

#### Usage

* Clone or download the repository
* On your computer, open `HIIT.sce`, indicate your max BPM (line 52), your zone of interest (line 54), the time of your warm-up and HIIT (line 64/69), your interval regulation (line 152), then run the script with F5 or click the button with grey triangle to make an overview of your HIIT protocol in terms of BPM. 

Notes: the default block duration period for regular intervals is : 20s (line 217)

### RecuperationPostHIIT

`RecuperationPostHIIT.sce` is useful is you want to look more closely on HIIT and extracts data/plot from your BPM during your recuperation post HIIT.
This program allows you :

* Automatically save your BPM averages at regular intervals (you determine) of your recuperation post HIIT period in a csv file
* Realize a complete plot of your recuperation period with line based on average BPM

Each plot and BPM average is automatically saved on folder RES

## Usage

* Clone or download the repository
* On your computer, open `RecuperationPostHIIT.sce` then run the script with F5 or click the button with grey triangle to make an overview of your recuperation after your HIIT protocol in terms of BPM.

Notes: the default block duration period for regular intervals is : 20s (line 217)

## Examples of display you can have with AlgoHIIT

## GlobalCondition Part

![](https://github.com/Axelvgtf/AlgoHIIT/blob/main/Global%20Condition.png)

## HIIT Part 

![](https://github.com/Axelvgtf/AlgoHIIT/blob/main/HIIT.png)

** Recuperation Part

![](https://github.com/Axelvgtf/AlgoHIIT/blob/main/Recuperation.png)
	  
## Notes 
	  
* Install [Scilab](https://www.scilab.org) scilab on your computer, For mac Users: click [here](https://www.utc.fr/~mottelet/scilab_for_macOS.html)

* The .csv file from Polar Flow website must be with the first colum is time in seconds and the thirs colums is your BPM recorded as with Polar H10

* Do not modify the names and organisation of the directories.
  The `DAT`+`PRG`+`RES` structure is expected when initialising in `InitTRT.sce`
  

Don't hesitate to tell me if you have any issues with the algorithm or if you want help to make it better 

Enjoy :)

-Axelvgtf
