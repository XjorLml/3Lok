import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GamePage extends StatefulWidget {
  final String category;
  final String level;

  GamePage({required this.category, required this.level});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _currentSlide = 0;
  List<String> _answers = ['Answer 1', 'Answer 2', 'Answer 3', 'Answer 4'];

  void _nextSlide() {
    setState(() {
      if (_currentSlide < 2) {
        _currentSlide++;
      } else {
        _currentSlide = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Slide image carousel
            CarouselSlider.builder(
              itemCount: 3, // Number of slides
              options: CarouselOptions(
                height: 300,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false, // Disable auto play for now
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  // Handle page change if needed
                },
              ),
              itemBuilder:
                  (BuildContext context, int index, int pageViewIndex) {
                return Image.asset(
                  'assets/luzon/pasig${index + 1}.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                );
              },
            ),
            SizedBox(height: 20.0),
            // Answer buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _answers.map((answer) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Button color
                        onPrimary: Colors.white, // Text color
                      ),
                      onPressed: () {
                        // Check if the answer is correct
                        // For now, let's just move to the next slide
                        _nextSlide();
                      },
                      child: Text(answer),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
