import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GamePage extends StatefulWidget {
  final String category;
  final String level;

  const GamePage({required this.category, required this.level});

  @override
  // ignore: library_private_types_in_public_api
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _currentSlide = 0;
  int _score = 0;
  final List<List<String>> _allAnswers = [
    ['NCR', 'CALABARZON', 'MIMAROPA', 'CAR'],
    ['Cagayan Valley', 'CAR', 'Ilocos Region', 'CENTRAL LUZON'],
    ['CALABARZON', 'CENTRAL LUZON', 'MIMAROPA', 'CAGAYAN VALLEY']
  ];

  final List<List<String>> _imagePaths = [
    ['assets/luzon/pasig1.jpg', 'assets/luzon/pasig2.jpg', 'assets/luzon/pasig3.jpg'],
    ['assets/luzon/CAR1.jpg', 'assets/luzon/CAR2.jpg', 'assets/luzon/CAR3.jpg'],
    ['assets/luzon/MIMAROPA1.jpg', 'assets/luzon/MIMAROPA2.jpg', 'assets/luzon/MIMAROPA3.jpg'],
  ];

    void _nextSlide() {
    setState(() {
      if (_currentSlide < 2) {
        _currentSlide++;
      } else {
        if (_currentSlide == 2) {
          // Display total score when all sets of slides are answered
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Game Over'),
                content: Text('Your final score is $_score out of 3'),
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
    String correctAnswer = _allAnswers[_currentSlide][_currentSlide];
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
          title: Text(isCorrect ? 'Correct!' : 'Wrong!'),
          content: Text(isCorrect ? 'Your answer is correct.' : 'Your answer is incorrect.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nextSlide(); // Move to the next slide
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(
                height: 300,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: false, // Disable infinite scrolling
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
              children: _allAnswers[_currentSlide].map((answer) {
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GamePage(category: "General", level: "Easy"),
  ));
}
