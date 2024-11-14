import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class VisayasCity extends StatefulWidget {
  final String category;
  final String level;

  const VisayasCity({super.key, required this.category, required this.level});

  @override
  // ignore: library_private_types_in_public_api
  _VisayasCityState createState() => _VisayasCityState();
}

class _VisayasCityState extends State<VisayasCity> {
  int _currentSlide = 0;
  int _score = 0;
  bool _gameOver = false; // Flag to track game over state

  final List<List<String>> _allAnswers = [
    ['Bacolod City', 'Bago City', 'Calbayog City', 'Cebu City'],
    ['Dumaguete City', 'Iloilo City', 'Ormoc City', 'Roxas City'],
    ['Tacloban City', 'Tagbilaran City', 'Bacolod City', 'Bago City'],
    ['Calbayog City', 'Cebu City', 'Dumaguete City', 'Iloilo City'],
    ['Ormoc City', 'Roxas City', 'Tacloban City', 'Tagbilaran City'],
    ['Bago City', 'Calbayog City', 'Cebu City', 'Dumaguete City'],
    ['Iloilo City', 'Ormoc City', 'Roxas City', 'Tacloban City'],
    ['Tagbilaran City', 'Bacolod City', 'Bago City', 'Calbayog City'],
    ['Cebu City', 'Dumaguete City', 'Iloilo City', 'Ormoc City'],
    ['Roxas City', 'Tacloban City', 'Tagbilaran City', 'Bacolod City']
  ];

  final List<List<String>> _imagePaths = [
    ['assets/visayas/Hard_City/Bacolod City/Bacolod1.jpg', 'assets/visayas/Hard_City/Bacolod City/Bacolod2.jpg', 'assets/visayas/Hard_City/Bacolod City/Bacolod3.jpg'],
    ['assets/visayas/Hard_City/Dumaguete City/Dumaguete1.jpg', 'assets/visayas/Hard_City/Dumaguete City/Dumaguete2.jpg', 'assets/visayas/Hard_City/Dumaguete City/Dumaguete3.jpg'],
    ['assets/visayas/Hard_City/Tacloban City/Tacloban1.jpg', 'assets/visayas/Hard_City/Tacloban City/Tacloban2.jpg', 'assets/visayas/Hard_City/Tacloban City/Tacloban3.jpg'],
    ['assets/visayas/Hard_City/Calbayog City/Calbayog1.jpg', 'assets/visayas/Hard_City/Calbayog City/Calbayog2.jpg', 'assets/visayas/Hard_City/Calbayog City/Calbayog3.jpg'],
    ['assets/visayas/Hard_City/Ormoc City/Ormoc1.jpg', 'assets/visayas/Hard_City/Ormoc City/Ormoc2.jpg', 'assets/visayas/Hard_City/Ormoc City/Ormoc3.jpg'],
    ['assets/visayas/Hard_City/Bago City/Bago1.jpg', 'assets/visayas/Hard_City/Bago City/Bago2.jpg', 'assets/visayas/Hard_City/Bago City/Bago3.jpg'],
    ['assets/visayas/Hard_City/Iloilo City/Iloilo1.jpg', 'assets/visayas/Hard_City/Iloilo City/Iloilo2.jpg', 'assets/visayas/Hard_City/Iloilo City/Iloilo3.jpg'],
    ['assets/visayas/Hard_City/Tagbilaran City/Tagbilaran1.jpg', 'assets/visayas/Hard_City/Tagbilaran City/Tagbilaran2.jpg', 'assets/visayas/Hard_City/Tagbilaran City/Tagbilaran3.jpg'],
    ['assets/visayas/Hard_City/Cebu City/Cebu1.jpg', 'assets/visayas/Hard_City/Cebu City/Cebu2.jpg', 'assets/visayas/Hard_City/Cebu City/Cebu3.jpg'],
    ['assets/visayas/Hard_City/Roxas City/Roxas1.jpg', 'assets/visayas/Hard_City/Roxas City/Roxas2.jpg', 'assets/visayas/Hard_City/Roxas City/Roxas3.jpg']
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
          title: const Text('Visayas Cities (Hard)'),
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
    home: VisayasCity(category: "General", level: "Easy"),
  ));
}
