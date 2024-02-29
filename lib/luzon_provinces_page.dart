import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LuzonProvince extends StatefulWidget {
  final String category;
  final String level;

  LuzonProvince({required this.category, required this.level});

  @override
  _LuzonProvinceState createState() => _LuzonProvinceState();
}

class _LuzonProvinceState extends State<LuzonProvince> {
  int _currentSlide = 0;
  int _score = 0;
  bool _gameOver = false; // Flag to track game over state

  List<List<String>> _allAnswers = [
    ['Tarlac', 'Quezon', 'Camarines Norte', 'Mountain Province'],
    ['Quezon', 'Camarines Norte', 'Mountain Province', 'NCR 4th District'],
    ['Camarines Norte', 'Mountain Province', 'NCR 4th District', 'Bataan'],
    ['Mountain Province', 'NCR 4th District', 'Bataan', 'Pangasinan'],
    ['NCR 4th District', 'Bataan', 'Pangasinan', 'Zambales'],
    ['Bataan', 'Pangasinan', 'Zambales', 'Tarlac'],
    ['Pangasinan', 'Zambales', 'Tarlac', 'Quezon'],
    ['Zambales', 'Tarlac', 'Quezon', 'Camarines Norte']
  ];

  List<List<String>> _imagePaths = [
    ['assets/luzon/Hard_Provinces/Tarlac/Tarlac1.jpg', 'assets/luzon/Hard_Provinces/Tarlac/Tarlac2.jpg', 'assets/luzon/Hard_Provinces/Tarlac/Tarlac3.jpg'],
    ['assets/luzon/Hard_Provinces/Quezon/Quezon.jpg', 'assets/luzon/Hard_Provinces/Quezon/Quezon2.jpg', 'assets/luzon/Hard_Provinces/Quezon/Quezon3.jpg'],
    ['assets/luzon/Hard_Provinces/Camarines Norte/CM1.jpg', 'assets/luzon/Hard_Provinces/Camarines Norte/CM2.jpg', 'assets/luzon/Hard_Provinces/Camarines Norte/CM3.jpg'],
    ['assets/luzon/Hard_Provinces/Mountain Province/MT1.jpg', 'assets/luzon/Hard_Provinces/Mountain Province/MT2.jpeg', 'assets/luzon/Hard_Provinces/Mountain Province/MT3.webp'],
    ['assets/luzon/Hard_Provinces/NCR 4th District/4th1.png', 'assets/luzon/Hard_Provinces/NCR 4th District/4th2.jpg', 'assets/luzon/Hard_Provinces/NCR 4th District/4th3.jpg'],
    ['assets/luzon/Hard_Provinces/Bataan/Bataan1.jpg', 'assets/luzon/Hard_Provinces/Bataan/Bataan2.jpg', 'assets/luzon/Hard_Provinces/Bataan/Bataan3.jpg'],
    ['assets/luzon/Hard_Provinces/Pangasinan/Pangasinan1.jpg', 'assets/luzon/Hard_Provinces/Pangasinan/Pangasinan2.jpg', 'assets/luzon/Hard_Provinces/Pangasinan/Pangasinan3.jpg'],
    ['assets/luzon/Hard_Provinces/Zambales/Zambales1.jpg', 'assets/luzon/Hard_Provinces/Zambales/Zambales2.jpg', 'assets/luzon/Hard_Provinces/Zambales/Zambales3.jpg']
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
          title: Text('Luzon Region'),
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
    home: LuzonProvince(category: "General", level: "Easy"),
  ));
}
