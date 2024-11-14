import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MindanaoRegion extends StatefulWidget {
  final String category;
  final String level;

  const MindanaoRegion({super.key, required this.category, required this.level});

  @override
  // ignore: library_private_types_in_public_api
  _MindanaoRegionState createState() => _MindanaoRegionState();
}

class _MindanaoRegionState extends State<MindanaoRegion> {
  int _currentSlide = 0;
  int _score = 0;
  bool _gameOver = false; // Flag to track game over state

  final List<List<String>> _allAnswers = [
    ['Soccksargen', 'Northern Mindanao', 'CARAGA', 'Davao Region'],
    ['Northern Mindanao', 'CARAGA', 'Davao Region', 'Zamboanga Peninsula'],
    ['CARAGA', 'Davao Region', 'Zamboanga Peninsula', 'Soccksargen'],
    ['Davao Region', 'Zamboanga Peninsula', 'Soccksargen', 'Northern Mindanao'],
    ['Zamboanga Peninsula', 'Soccksargen', 'Northern Mindanao', 'CARAGA']
  ];

  final List<List<String>> _imagePaths = [
    ['assets/mindanao/Easy_Region/Soccksargen/Socc1.jpg','assets/mindanao/Easy_Region/Soccksargen/Socc2.jpg', 'assets/mindanao/Easy_Region/Soccksargen/Socc3.jpg'],
    ['assets/mindanao/Easy_Region/Northern Mindanao/NM1.jpg', 'assets/mindanao/Easy_Region/Northern Mindanao/NM2.jpg', 'assets/mindanao/Easy_Region/Northern Mindanao/NM3.jpg'],
    ['assets/mindanao/Easy_Region/CARAGA/CARAGA1.jpg', 'assets/mindanao/Easy_Region/CARAGA/CARAGA2.jpg', 'assets/mindanao/Easy_Region/CARAGA/CARAGA3.jpg'],
    ['assets/mindanao/Easy_Region/Davao Region/Davao1.jpg', 'assets/mindanao/Easy_Region/Davao Region/Davao2.jpg', 'assets/mindanao/Easy_Region/Davao Region/Davao3.jpg'],
    ['assets/mindanao/Easy_Region/Zamboanga Peninsula/ZP1.jpg', 'assets/mindanao/Easy_Region/Zamboanga Peninsula/ZP2.jpg', 'assets/mindanao/Easy_Region/Zamboanga Peninsula/ZP3.jpg']
  ];

  List<List<String>> _shuffledAnswers = [];

  @override
  void initState() {
    super.initState();
    _shuffledAnswers = _allAnswers.map((answers) {
      List<String> shuffled = List.from(answers)..shuffle();
      return shuffled;
    }).toList();
  }

  void _nextSlide() {
    setState(() {
      if (_currentSlide < _imagePaths.length - 1) {
        _currentSlide++;
      } else {
        if (_currentSlide == _imagePaths.length - 1) {
          // Display total score when all sets of slides are answered
          _gameOver = true; // Set game over flag
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Game Over'),
                content: Text('Your final score is $_score out of ${_imagePaths.length}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.pop(context); // Navigate back to the CategoryPage
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        }
        _currentSlide = 0; // Reset the current slide to restart the game
      }
    });
  }

  void _checkAnswer(String selectedAnswer) {
    if (!_gameOver) {
      String correctAnswer = _allAnswers[_currentSlide][0]; // Directly access the correct answer at index 0
      bool isCorrect = selectedAnswer == correctAnswer;
      if (isCorrect) {
        setState(() {
          _score++;
        });
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(isCorrect ? 'CORRECT!' : 'WRONG!'),
            content: Text(isCorrect ? 'Your answer is correct.' : 'Your answer is wrong.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _nextSlide();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return _gameOver || await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Exit Game?'),
              content: const Text('Are you sure you want to exit the game? Your progress will be lost.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mindanao Regions (Easy)'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              bool exit = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Exit Game?'),
                    content: const Text('Are you sure you want to exit the game? Your progress will be lost.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              ) ?? false;
              if (exit) {
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
          ),
        ),
        backgroundColor: Colors.lightBlue[50],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Question ${_currentSlide + 1} of ${_imagePaths.length}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: _imagePaths[_currentSlide].length,
                options: CarouselOptions(
                  height: 300,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {},
                ),
                itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                  return Image.asset(
                    _imagePaths[_currentSlide][index],
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  );
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _shuffledAnswers[_currentSlide].map((answer) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          _checkAnswer(answer);
                        },
                        child: Text(answer),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Score: $_score',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MindanaoRegion(category: "General", level: "Easy"),
  ));
}
