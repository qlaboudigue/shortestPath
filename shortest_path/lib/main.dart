import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

List<List<int>> map = [
  [1, 1, 1, 1, 1],
  [1, 1, 0, 0, 1],
  [0, 1, 1, 0, 1],
  [0, 1, 1, 1, 1],
  [1, 1, 0, 1, 1],
  [1, 1, 1, 1, 0],
];

int si = 2;
int sj = 4;

int ei = 1;
int ej = 0;

List<List<List<int>>> validatedPaths = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShortestPath',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();

    /// ------- SHORTEST PATH START
    if (!_blockExists(si, sj)) {
      // Check starting block existence
      print('Starting point is out of boundaries');
    } else {
      solve(si, sj, [], 0); // Solve game
      List<List<int>> shortestPath = validatedPaths[0];
      // Select the shortest path among all validated paths
      for (var path in validatedPaths) {
        if (path.length < shortestPath.length) {
          shortestPath = path;
        }
      }
      List<List<int>> finalMap = map; // Final map displaying results
      for (var point in shortestPath) {
        finalMap[point[0]][point[1]] = 2;
      }
      finalMap[si][sj] = 2; // Add starting point
      finalMap[ei][ej] = 2; // Add ending point
      for (var line in finalMap) {
        print(line);
      }

    }
  }

  // FUNCTIONS
  // Check if a block is out of boundaries
  bool _blockExists(int i, int j) {
    if (map.asMap().containsKey(i)) {
      // print(map[i]);
      if (map[i].asMap().containsKey(j)) {
        // print(map[i][j]);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // Check if a block is blocked or not
  bool _isBlockReachable(int i, int j) {
    if (map[i][j] != 0) {
      return true;
    } else {
      return false;
    }
  }

  // Check existence in list
  bool _blockIsInCurrentPath(int i, int j, List<List<int>> currentPath) {
    if (currentPath.any((element) => listEquals(element, [i, j]))) {
      return true;
    } else {
      return false;
    }
  }

  // Can visit block
  bool _canVisitBlock(int i, int j, List<List<int>> currentPath) {
    if (_blockExists(i, j) && _isBlockReachable(i, j) && !_blockIsInCurrentPath(i, j, currentPath)) {
      return true;
    } else {
      return false;
    }
  }

  // Format validated path without the first step
  List<List<int>> _formatValidatedPath(List<List<int>> path) {
    List<List<int>> formattedPath = [];
    for(var i = 1; i < path.length; i++){
      formattedPath.add(path[i]);
    }
    return formattedPath;
  }

  // Solve problem function
  void solve(int i, int j, List<List<int>> currentPath, int index) {

    // Add current block to the current path
    currentPath.add([i, j]);

    // Process
    if (i == ei && j == ej) {
      // Exit condition : ending block has been reached
      List<List<int>> newPath = _formatValidatedPath(currentPath);
      validatedPaths.add(newPath); // Add validated path to the validated paths list.
    } else {
      // Recursive process : visit adjacent blocks
      if (_canVisitBlock(i-1, j, currentPath)) {
        index ++;
        solve(i-1, j, currentPath, index);
      }
      if (_canVisitBlock(i, j-1, currentPath)) {
        index ++;
        solve(i, j-1, currentPath, index);
      }
      if (_canVisitBlock(i+1, j, currentPath)) {
        index ++;
        solve(i+1, j, currentPath, index);
      }
      if (_canVisitBlock(i, j+1, currentPath)) {
        index ++;
        solve(i, j+1, currentPath, index);
      }
    }

    // Fix the current path issue not being in the scope of a single use of the solve function
    currentPath.removeLast();
  }

  /// ------- SHORTEST PATH END

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // child: GraphicalGrid(grid: grid),
        child: Text(' '),
      ),
    );
  }






}
