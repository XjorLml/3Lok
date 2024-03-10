import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:audioplayers/audioplayers.dart';

class MindanaoProvince extends StatefulWidget {
  final String category;
  final String level;

  MindanaoProvince({required this.category, required this.level});

  @override
  _MindanaoProvinceState createState() => _MindanaoProvinceState();
}

class _MindanaoProvinceState extends State<MindanaoProvince> {
  int _currentSlide = 0;
  int _score = 0;
  bool _gameOver = false; // Flag to track game over state

  List<List<String>> _allAnswers = [
    ['Davao Del Sur', 'Maguindanao', 'Bukidnon', 'Lanao Del Norte'],
    ['Zamboanga Del Sur', 'Misamis Oriental', 'Sultan Kudarat', 'Surigao Del Sur'],
    ['Bukidnon', 'Davao Del Sur', 'Lanao Del Norte', 'Maguindanao'],
    ['Surigao Del Sur', 'Zamboanga Del Sur', 'Misamis Oriental', 'Sultan Kudarat'],
    ['Sultan Kudarat', 'Surigao Del Sur', 'Zamboanga Del Sur', 'Misamis Oriental'],
    ['Lanao Del Norte', 'Bukidnon', 'Davao Del Sur', 'Maguindanao'],
    ['Misamis Oriental', 'Sultan Kudarat', 'Surigao Del Sur', 'Zamboanga Del Sur'],
    ['Maguindanao', 'Lanao Del Norte', 'Bukidnon', 'Davao Del Sur']
  ];

  List<List<String>> _imagePaths = [
    ['assets/mindanao/Average_Province/Davao Del Sur/DDS1.jpg', 'assets/mindanao/Average_Province/Davao Del Sur/DDS2.jpg', 'assets/mindanao/Average_Province/Davao Del Sur/DDS3.jpg'],
    ['assets/mindanao/Average_Province/Zamboanga del Sur/ZDO1.jpg', 'assets/mindanao/Average_Province/Zamboanga del Sur/ZDO2.jpg', 'assets/mindanao/Average_Province/Zamboanga del Sur/ZDO3.jpg'],
    ['assets/mindanao/Average_Province/Bukidnon/Bukidnon1.jpg', 'assets/mindanao/Average_Province/Bukidnon/Bukidnon2.jpg', 'assets/mindanao/Average_Province/Bukidnon/Bukidnon3.jpg'],
    ['assets/mindanao/Average_Province/Surigao del Sur/SDS1.jpg', 'assets/mindanao/Average_Province/Surigao del Sur/SDS2.jpg', 'assets/mindanao/Average_Province/Surigao del Sur/SDS3.jpg'],
    ['assets/mindanao/Average_Province/Sultan Kudarat/SK1.jpg', 'assets/mindanao/Average_Province/Sultan Kudarat/SK2.jpg', 'assets/mindanao/Average_Province/Sultan Kudarat/SK3.jpg'],
    ['assets/mindanao/Average_Province/Lanao del Norte/LDN1.jpg', 'assets/mindanao/Average_Province/Lanao del Norte/LDN2.jpg', 'assets/mindanao/Average_Province/Lanao del Norte/LDN3.jpg'],
    ['assets/mindanao/Average_Province/Misamis Oriental/MO1.jpg', 'assets/mindanao/Average_Province/Misamis Oriental/MO2.jpg', 'assets/mindanao/Average_Province/Misamis Oriental/MO3.jpg'],
    ['assets/mindanao/Average_Province/Maguindanao/Maguindanao1.jpg', 'assets/mindanao/Average_Province/Maguindanao/Maguindanao2.jpg', 'assets/mindanao/Average_Province/Maguindanao/Maguindanao3.jpg'],
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
              if (_score >= 5) {
                  AudioCache _audioCache = AudioCache();
                  _audioCache.play('win.mp3');
                } else {
                  AudioCache _audioCache = AudioCache();
                  _audioCache.play('loser.mp3');
                }
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
        _audioCache.play('correct.mp3');
      }
      bool isWrong = selectedAnswer != correctAnswer;
      if (isWrong) {
        AudioCache _audioCache = AudioCache();
        _audioCache.play('wrong.mp3');
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
          title: Text('Mindanao Provinces (Medium)'),
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
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/orange prov.jpg'),
            fit: BoxFit.cover,
          ),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 69, 69, 196), // Background color
                  borderRadius: BorderRadius.circular(8), // Optional: adds rounded corners
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  'Question ${_currentSlide + 1} of ${_imagePaths.length}',
                  style: TextStyle(
                    color: Colors.white, fontSize: 20 // Text color
                  ),
                ),
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
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 69, 69, 196), // Background color
                  borderRadius: BorderRadius.circular(8), // Optional: adds rounded corners
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  'Score: $_score',
                  style: TextStyle(
                    color: Colors.white, fontSize: 24 // Text color
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MindanaoProvince(category: "General", level: "Easy"),
  ));
}
