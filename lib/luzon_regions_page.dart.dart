import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LuzonRegion extends StatefulWidget {
  final String category;
  final String level;

  LuzonRegion({required this.category, required this.level});

  @override
  _LuzonRegionState createState() => _LuzonRegionState();
}

class _LuzonRegionState extends State<LuzonRegion> {
  int _currentSlide = 0;
  int _score = 0;
  bool _gameOver = false; // Flag to track game over state

  List<List<String>> _allAnswers = [
    ['Central Luzon', 'CALABARZON', 'MIMAROPA', 'CAR'],
    //['CAR', 'Cagayan Valley', 'Ilocos Region', 'Bicol Region'],
    ['MIMAROPA', 'CALABARZON', 'Bicol Region', 'Cagayan Valley'],
    ['Cagayan Valley', 'MIMAROPA', 'CAR', 'NCR'],
    ['Bicol Region', 'Central Luzon', 'Cagayan Valley', 'Ilocos Region'],
    //['Ilocos Region', 'Bicol Region', 'CAR', 'CALABARZON'],
    ['NCR', 'Ilocos Region', 'CAR', 'Cagayan Valley'],
    //['CALABARZON', 'Central Luzon', 'Bicol Region', 'Cagayan Valley'],
  ];

  List<List<String>> _imagePaths = [
    ['assets/luzon/Easy_Region/Central/Central1.jpg', 'assets/luzon/Easy_Region/Central/Central2.jpg', 'assets/luzon/Easy_Region/Central/Central3.jpg'],
    //['assets/luzon/Easy_Region/CAR/CAR1.jpg', 'assets/luzon/Easy_Region/CAR/CAR2.jpg', 'assets/luzon/Easy_Region/CAR/CAR3.jpg'],
    ['assets/luzon/Easy_Region/MIMAROPA/4b1.webp', 'assets/luzon/Easy_Region/MIMAROPA/4b2.jpg', 'assets/luzon/Easy_Region/MIMAROPA/4b3.jpg'],
    ['assets/luzon/Easy_Region/Cagayan Valley/CV1.jpg', 'assets/luzon/Easy_Region/Cagayan Valley/CV2.jpg', 'assets/luzon/Easy_Region/Cagayan Valley/CV3.jpg'],
    ['assets/luzon/Easy_Region/Bicol/Bicol1.jpg', 'assets/luzon/Easy_Region/Bicol/Bicol2.webp', 'assets/luzon/Easy_Region/Bicol/Bicol3.jpg'],
    //['assets/luzon/Easy_Region/Ilocos/Ilocos1.webp', 'assets/luzon/Easy_Region/Ilocos/Ilocos2.jpg', 'assets/luzon/Easy_Region/Ilocos/Ilocos3.jpg'],
    ['assets/luzon/Easy_Region/NCR/NCR1.jpg', 'assets/luzon/Easy_Region/NCR/NCR2.jpg', 'assets/luzon/Easy_Region/NCR/NCR3.jpg'],
    //['assets/luzon/Easy_Region/CALABARZON/4a1.webp', 'assets/luzon/Easy_Region/CALABARZON/4a2.webp', 'assets/luzon/Easy_Region/CALABARZON/4a3.jpg'],
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
                title: Text('Game Over'),
                content: Text('Your final score is $_score out of ${_imagePaths.length}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.pop(context); // Navigate back to the CategoryPage
                    },
                    child: Text('Close'),
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
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _gameOver || await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Exit Game?'),
              content: Text('Are you sure you want to exit the game? Your progress will be lost.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Luzon Regions'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              bool exit = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Exit Game?'),
                    content: Text('Are you sure you want to exit the game? Your progress will be lost.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  );
                },
              ) ?? false;
              if (exit) {
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
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _shuffledAnswers[_currentSlide].map((answer) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
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
              SizedBox(height: 20.0),
              Text(
                'Score: $_score',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LuzonRegion(category: "General", level: "Easy"),
  ));
}
