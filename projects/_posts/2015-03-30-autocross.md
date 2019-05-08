---
layout: post
title: "Autonomous Ground Vehicle Path Planning for Autocross Tracks"
description: ""
category: projects 
tags: []
comments : false
---
{% include JB/setup %}

In 2015 I recieved my Masters in Computer Engineering from the [University of California Santa Cruz](http://www.ucsc.edu). The thesis proposes a computationally efficient path planning algorithm for an autonomous ground vehicle. A Bézier curve solution is proposed that maintains G2 continuity throughout the track. A dynamic programming algorithm plans two initial paths through the course. The first path minimizes the maximum curvature (MMC), while the second path minimizes the distance traveled. By blending the MMC and shortest paths a pseudo-optimal path is calculated based on the vehicle dynamics. The pseudo-optimal path achieves a shorter lap time than either the MMC or shortest paths.

<img src="{{site.url}}/images/Variables.png" style="width: 250px;" align="right"/>
The improved Bézier pseudo-optimal path is compared to a direct optimal control solution found using pseudospectral methods. This comparison reveals previously unrecognized potential for improvement of the dynamic programming algorithm. The dynamic programming algorithm is shown to be highly dependent on the placement of gates throughout the course and it is found that by adding extra gates along the entrance and exits of complex curves the track time can be greatly improved while keeping computation time low. The solution given in this thesis maintains a linear increase in computation time while approaching the optimal track time.

A complete copy of my thesis can be found [Here]({{site.url}}/Documents/Jash_Thesis.pdf).


