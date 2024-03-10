import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable default back button
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Content
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
            child: Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.black.withOpacity(0.5), // Semi-transparent black background
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'About 1lok 3 Slides',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Welcome to 1lok 3 Slides, the ultimate destination for exploring the beauty and diversity of the Philippines!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Our Mission',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'At 1lok 3 Slides, our mission is to engage and educate users about the rich culture, heritage, and geography of the Philippines through an immersive and enjoyable gameplay experience. We aim to promote learning and appreciation for the country\'s remarkable destinations and landmarks.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Our Vision',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'We envision 1lok 3 Slides as a platform that inspires curiosity and fosters a deeper understanding of the Philippines\' unique places and attractions. Through our game, we hope to spark a sense of adventure and discovery while showcasing the beauty of our country.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Why Choose 1lok 3 Slides?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Educational Content: Explore the Philippines through carefully curated images that highlight its natural beauty and cultural significance.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '- Engaging Gameplay: Challenge yourself with puzzles that require observation, critical thinking, and cultural knowledge.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '- Interactive Learning: Learn about different regions, cities, and provinces of the Philippines in a fun and interactive way.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '- Child-Friendly: Designed with children in mind, 1lok 3 Slides provides a safe and enjoyable gaming experience for all ages.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Meet the Team',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Lumaban: Backend Developer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Gellido: Frontend Developer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Matanog: Project Manager',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Azaula: QA Tester',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Join us on this exciting journey of discovery and adventure with 1lok 3 Slides! Experience the Philippines like never before.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            ),
          ),
        ],
      ),
    );
  }
}
