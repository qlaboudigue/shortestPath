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
List<List<List<int>>> paths = [];


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

    /// START GAME
    if (!_blockExists(si, sj)) {
      // Check starting block existence
      print('Starting point is out of boundaries');
    } else {
      // Add starting block to path
      solve(si, sj, [], 0);
    }
  }

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


  // FUNCTIONS
  /// Check if a block is out of boundaries
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

  /// Check if a block is blocked or not
  bool _isBlockReachable(int i, int j) {
    if (map[i][j] != 0) {
      return true;
    } else {
      return false;
    }
  }

  /// Check existence in list
  bool _blockIsInCurrentPath(int i, int j, List<List<int>> currentPath) {
      if (currentPath.any((element) => listEquals(element, [i, j]))) {
        return true;
      } else {
        return false;
      }
  }

  /// Can visit block
  bool _canVisitBlock(int i, int j, List<List<int>> currentPath) {
    if (_blockExists(i, j) && _isBlockReachable(i, j) && !_blockIsInCurrentPath(i, j, currentPath)) {
      return true;
    } else {
      return false;
    }
  }

  /// Format validated path without the first step
  List<List<int>> _formatValidatedPath(List<List<int>> path) {
    List<List<int>> formattedPath = [];
    for(var i = 1; i < path.length; i++){
      formattedPath.add(path[i]);
    }
    return formattedPath;
  }

  /// Solve problem function
  void solve(int i, int j, List<List<int>> currentPath, int index) {


    /// Update visited blocks
    if (i == ei && j == ej) {
      // Case end block has been reached
      // Do nothing
    } else {
      // Add visited block to the list
      // visitedBlocks.add([i, j]);
      // print(_currentPath);
      // currentPath.add([i, j]);
      // paths.add(currentPath);
    }

    currentPath.add([i, j]);



    /// Process
    if (i == ei && j == ej) {
      // Exit condition : ending block has been reached
      print('Current');
      print(currentPath);

      List<List<int>> newPath = _formatValidatedPath(currentPath);
      validatedPaths.add(newPath);

      print('Validated');
      print(validatedPaths);
      // currentPath.clear();

      // return validatedPaths;
    } else {

      // print('Else');
      // Recursive process : visit adjacent blocks
      if (_canVisitBlock(i-1, j, currentPath)) {
        // print('a $index $currentPath');
        index ++;
        // List<List<int>> _current = currentPath;
        solve(i-1, j, currentPath, index);
      }
      if (_canVisitBlock(i, j-1, currentPath)) {
        // print('b $index $currentPath');
        index ++;
        // List<List<int>> _current = currentPath;
        solve(i, j-1, currentPath, index);
      }
      if (_canVisitBlock(i+1, j, currentPath)) {
        // print('c $index $currentPath');
        index ++;
        // List<List<int>> _current = currentPath;
        solve(i+1, j, currentPath, index);
      }
      if (_canVisitBlock(i, j+1, currentPath)) {
        // print('d $index $currentPath');
        index ++;
        // List<List<int>> _current = currentPath;
        solve(i, j+1, currentPath, index);
      }
    }

    currentPath.removeLast();



  }



}

class GraphicalGrid extends StatelessWidget {

  // PROPERTIES
  final Grid grid;

  // CONSTRUCTOR
  const GraphicalGrid({Key? key, required this.grid}) : super(key: key);

  // BUILD
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: grid.slots.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 16.0,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: grid.slots[i].length,
                      itemBuilder: (context, j) {
                    return Row(
                      children: [
                        Text(grid.slots[i][j].isBlocked.toString()),
                        SizedBox(width: 8.0,)
                      ],
                    );
                  }),
                ),
                SizedBox(height: 8.0,)
              ],
            );
      })

    );
  }
}




class Grid {

  // PROPERTIES
  List<List<Slot>> slots = [];

  // CONSTRUCTOR
  Grid({required this.slots});

  // FACTORY
  factory Grid.fromMap(List<List<int>> map) {
    List<List<Slot>> slots = [];
    for(var line in map) {
      List<Slot> singleLine = [];
      for(var element in line) {
        Slot slot = Slot(isVisited: false, isBlocked: element == 1 ? false : true);
        singleLine.add(slot);
      }
      slots.add(singleLine);
    }
    return Grid(slots: slots);
  }


}

class Slot {

  bool isVisited;
  bool isBlocked;

  Slot({required this.isVisited, required this.isBlocked});

}


/*
      // Leaving condition
      while(ci != ei && cj != ej) {
        // Visit closest neighbours
        if(_checkBlockExistence(si-1, sj)) {
          // Block exists
          if (_checkBlockStatus(si-1, sj)) {
            print('${si-1};$sj OK');
            ci = si - 1;
            cj = sj;
          }
        }
        if(_checkBlockExistence(si, sj-1)) {
          // Block exists
          if (_checkBlockStatus(si, sj-1)) {
            print('$si;${sj-1} OK');
            ci = si;
            cj = sj - 1;
          }
        }
        if(_checkBlockExistence(si+1, sj)) {
          // Block exists
          if (_checkBlockStatus(si+1, sj)) {
            print('${si+1};$sj OK');
            ci = si + 1;
            cj = sj;
          }
        }
        if(_checkBlockExistence(si, sj+1)) {
          // Block exists
          if (_checkBlockStatus(si, sj+1)) {
            print('$si;${sj+1} OK');
            ci = si - 1;
            cj = sj + 1;
          }
        }
      }

       */



/*


 /// Process
    if (i == ei && j == ej) {
      // Exit condition : ending block has been reached
      return;
    } else {
      // Recursive process : visit adjacent blocks
      if (_canVisitBlock(i-1, j, visitedBlocks)) {
        // print("a");
        // print('${i-1}, $j');
        _solve(i-1, j);
      }

      if (_canVisitBlock(i, j-1, visitedBlocks)) {
        print('b');
        print('$i, ${j-1}');
        _solve(i, j-1);
      }

      if (_canVisitBlock(i+1, j, visitedBlocks)) {
        print('c');
        print('${i+1}, $j');
        _solve(i+1, j);
      }

      if (_canVisitBlock(i, j+1, visitedBlocks)) {
        print('d');
        print('$i, ${j+1}');
        _solve(i, j+1);
      }

    }
 */


/*


  /// Solve problem function
  List<List<List<int>>> _solve(int i, int j, List<List<int>> currentPath, List<List<List<int>>> validatedPaths) {

    print('$i, $j');

    /// Update visited blocks
    if (i == ei && j == ej) {
      // Case end block has been reached
      // Do nothing
    } else {
      // Add visited block to the list
      // visitedBlocks.add([i, j]);

      // print(_currentPath);
    }

    currentPath.add([i, j]);

    /// Process
    if (i == ei && j == ej) {
      // Exit condition : ending block has been reached
      print('Current');
      print(currentPath);

      List<List<int>> newPath = _formatValidatedPath(currentPath);
      validatedPaths.add(newPath);

      print('Validated');
      print(validatedPaths);
      // currentPath.clear();
      print('Before return');

      return validatedPaths;
      print('After');
    } else {

      // print('Else');
      // Recursive process : visit adjacent blocks
      if (_canVisitBlock(i-1, j, currentPath)) {
        _solve(i-1, j, currentPath, validatedPaths);
        return [];
      }
      if (_canVisitBlock(i, j-1, currentPath)) {
        _solve(i, j-1, currentPath, validatedPaths);
        return [];
      }
      if (_canVisitBlock(i+1, j, currentPath)) {
        _solve(i+1, j, currentPath, validatedPaths);
        return [];
      }
      if (_canVisitBlock(i, j+1, currentPath)) {
        _solve(i, j+1, currentPath, validatedPaths);
        return [];
      }
    }



  }


 */