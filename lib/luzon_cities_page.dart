import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:audioplayers/audioplayers.dart';

class LuzonCity extends StatefulWidget {
  final String category;
  final String level;

  LuzonCity({required this.category, required this.level});

  @override
  _LuzonCityState createState() => _LuzonCityState();
}

class _LuzonCityState extends State<LuzonCity> {
  int _currentSlide = 0;
  int _score = 0;
  bool _gameOver = false; // Flag to track game over state

  List<List<String>> _allAnswers = [
    ['Antipolo City', 'Batangas City', 'Olongapo City', 'Tagaytay City'],
    ['Baguio City', 'Antipolo City', 'Calamba City', 'Pasig City'],
    ['Pasig City', 'Baguio City', 'Gapan City', 'Antipolo City'],
    ['Olongapo City', 'Tagaytay City', 'Baguio City', 'Gapan City'],
    ['Calamba City', 'Marikina City', 'Pasig City', 'Taguig City'],
    ['Marikina City', 'Antipolo City', 'Gapan City', 'Olongapo City'],
    ['Batangas City', 'Baguio City', 'Tagaytay City', 'Calamba City'],
    ['Tagaytay City', 'Pasig City', 'Marikina City', 'Antipolo City'],
    ['Gapan City', 'Olongapo City', 'Taguig City', 'Baguio City'],
    ['Taguig City', 'Calamba City', 'Batangas City', 'Pasig City']
  ];

  List<List<String>> _imagePaths = [
    ['assets/luzon/Average_Cities/Antipolo City/Antips1.jpg', 'assets/luzon/Average_Cities/Antipolo City/Antips2.jpg', 'assets/luzon/Average_Cities/Antipolo City/Antips3.jpg',],
    ['assets/luzon/Average_Cities/Baguio City/Baguio1.jpg', 'assets/luzon/Average_Cities/Baguio City/Baguio2.jpg', 'assets/luzon/Average_Cities/Baguio City/Baguio3.jpg'],
    ['assets/luzon/Average_Cities/Pasig City/Pasig1.jpg', 'assets/luzon/Average_Cities/Pasig City/Pasig2.jpg', 'assets/luzon/Average_Cities/Pasig City/Pasig3.png'],
    ['assets/luzon/Average_Cities/Olongapo City/Olongapo1.jpg', 'assets/luzon/Average_Cities/Olongapo City/Olongapo2.jpg', 'assets/luzon/Average_Cities/Olongapo City/Olongapo3.jpg'],
    ['assets/luzon/Average_Cities/Calamba City/Calamba1.jpg', 'assets/luzon/Average_Cities/Calamba City/Calamba2.jpg', 'assets/luzon/Average_Cities/Calamba City/Calamba3.webp'],
    ['assets/luzon/Average_Cities/Marikina City/Marikina1.jpg', 'assets/luzon/Average_Cities/Marikina City/Marikina2.jpg', 'assets/luzon/Average_Cities/Marikina City/Marikina3.jpg'],
    ['assets/luzon/Average_Cities/Batangas City/Batangas1.jpg', 'assets/luzon/Average_Cities/Batangas City/Batangas2.jpg', 'assets/luzon/Average_Cities/Batangas City/Batangas3.png'],
    ['assets/luzon/Average_Cities/Tagaytay City/Tagaytay1.jpg', 'assets/luzon/Average_Cities/Tagaytay City/Tagaytay2.jpg', 'assets/luzon/Average_Cities/Tagaytay City/Tagaytay3.png'],
    ['assets/luzon/Average_Cities/Gapan City/Gapan1.jpg', 'assets/luzon/Average_Cities/Gapan City/Gapan2.png', 'assets/luzon/Average_Cities/Gapan City/Gapan3.jpg'],
    ['assets/luzon/Average_Cities/Taguig City/Taguig1.jpg', 'assets/luzon/Average_Cities/Taguig City/Taguig2.jpg', 'assets/luzon/Average_Cities/Taguig City/Taguig3.jpg'],


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
        AudioCache _audioCache = AudioCache();
        _audioCache.play('mohad.mp3');
      }
      bool isWrong = selectedAnswer != correctAnswer;
      if (isWrong) {
        AudioCache _audioCache = AudioCache();
        _audioCache.play('lose.mp3');
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
          title: Text('Luzon Cities (Hard)'),
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
    home: LuzonCity(category: "General", level: "Easy"),
  ));
}
