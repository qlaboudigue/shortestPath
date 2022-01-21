# shortestPath

## First approach

The first step consisted in web search about shortest path existing algorithms.
Algorithms like A*, Dijktra have been studied before jumping into the exercise.

## Process and Progress

A first choice was not to use existing and obscure algorithms but to build one on my own.  
I've spent time on paper trying to simulate the problem solving process.  
From the starting point, the goal was to explore direct "neighbours".  
This process has been reproduced until the visited point was the ending point (given in the exercise).  
The solution was to use a recursive function explained that way :  
  
Visit neighbours of a given point until the visited point corresponds to the end point. Save all the paths and choose the shortest one.

Difficulties happened regarding the current path being either a global variable or a local variable.  
A solution has been found by using the current path as a parameter of the solving function.
A few days have been spent debugging the current path not acting in the scope of a single solving function in the whole recursive process.  
A fix consisting in removing the last item of the list has been found.

## Install

The project has been developin Android studio with the Flutter SDK in Dart but the code can be copy pasted in dartpad.dev in the main() method and adding at the top of the editor the following import :  
import 'package:flutter/foundation.dart';

## Result

Result is displayed the following with "2" showing the shortest path
[2, 2, 2, 2, 2]
[2, 1, 0, 0, 2]
[0, 1, 1, 0, 2]
[0, 1, 1, 1, 1]
[1, 1, 0, 1, 1]
[1, 1, 1, 1, 0]
