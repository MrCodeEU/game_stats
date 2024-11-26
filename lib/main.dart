import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Stats Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Game Stats Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<List<int>> _scores = List.generate(3, (_) => List.filled(5, 0));
  final List<String> _players = ['Player 1', 'Player 2', 'Player 3'];

  void _updateScore(int playerIndex, int roundIndex, int score) {
    setState(() {
      _scores[playerIndex][roundIndex] = score;
    });
  }

  int _getTotalScore(int playerIndex) {
    return _scores[playerIndex].reduce((a, b) => a + b);
  }

  String _getLeader() {
    int maxScore = -1;
    String leader = '';
    for (int i = 0; i < _players.length; i++) {
      int totalScore = _getTotalScore(i);
      if (totalScore > maxScore) {
        maxScore = totalScore;
        leader = _players[i];
      }
    }
    return leader;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Current Leader: ${_getLeader()}'),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    const Text('Player'),
                    for (int i = 1; i <= 5; i++) Text('Round $i'),
                    const Text('Total'),
                  ],
                ),
                for (int i = 0; i < _players.length; i++)
                  TableRow(
                    children: [
                      Text(_players[i]),
                      for (int j = 0; j < 5; j++)
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            int score = int.tryParse(value) ?? 0;
                            _updateScore(i, j, score);
                          },
                          decoration: InputDecoration(
                            hintText: _scores[i][j].toString(),
                          ),
                        ),
                      Text(_getTotalScore(i).toString()),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
