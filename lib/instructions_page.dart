import 'package:flutter/material.dart';
import 'category_page.dart'; // Import the CategoryPage

class InstructionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // Use 80% of the screen width
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'How to Play "Tri-Slides 1Loc"',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '1. Select a Category: Choose a category to begin – Luzon, Visayas, or Mindanao.\n',
                        ),
                        TextSpan(
                          text:
                              '2. Choose a Level: Pick a level of difficulty :\n ',
                        ),
                        TextSpan(
                          text: 'Regions (easy),\n ',
                          style: TextStyle(color: Colors.green),
                        ),
                        TextSpan(
                          text: 'Provinces (average)\n ',
                          style: TextStyle(color: Colors.orange),
                        ),
                        TextSpan(
                          text: 'Cities (hard).\n',
                          style: TextStyle(color: Colors.red),
                        ),
                        TextSpan(
                          text:
                              '3. Identify the Location: Analyze the three photos presented to you.\n',
                        ),
                        TextSpan(
                          text:
                              '4. Select Your Answer: Choose the location you believe is depicted in the photos.\n',
                        ),
                        TextSpan(
                          text:
                              '5. Learn and Explore: Read about the location\'s history and trivia.\n',
                        ),
                        TextSpan(
                          text:
                              '6. Enjoy the Game: Have fun exploring the Philippines and testing your knowledge!\n',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the categories page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryPage()),
                      );
                    },
                    child: Text('Ready to play'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
