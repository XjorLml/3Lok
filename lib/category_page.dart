import 'package:flutter/material.dart';
import 'package:flutter_app/categories/cities/luzon_cities_page.dart';
import 'package:flutter_app/categories/provinces/luzon_provinces_page.dart';
import 'package:flutter_app/categories/cities/mindanao_cities_page.dart';
import 'package:flutter_app/categories/provinces/mindanao_provinces_page.dart';
import 'package:flutter_app/categories/cities/visayas_cities_page.dart';
import 'package:flutter_app/categories/provinces/visayas_provinces_page.dart';
import 'package:flutter_app/categories/regions/visayas_regions_page.dart';
import 'package:flutter_app/categories/regions/minadanao_regions_page.dart';
//import 'game_page.dart';
import 'categories/regions/luzon_regions_page.dart.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String _selectedCategory = '';
  String _selectedLevel = '';

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _selectLevel(String level) {
    setState(() {
      _selectedLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable default back button
        title: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back),
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
      backgroundColor: Colors.lightBlue[50],
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Choose a Category',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _selectCategory('Luzon'),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: _selectedCategory == 'Luzon'
                                ? Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/luzon.jpg',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Text(
                          'Luzon',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectCategory('Visayas'),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: _selectedCategory == 'Visayas'
                                ? Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/visayas.jpg',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Text(
                          'Visayas',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectCategory('Mindanao'),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: _selectedCategory == 'Mindanao'
                                ? Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/mindanao.jpg',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Text(
                          'Mindanao',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Choose a Level',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _selectLevel('Regions'),
                    child: Container(
                      color: _selectedLevel == 'Regions'
                          ? Colors.green
                          : Colors.blue[100],
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Region (easy)',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectLevel('Provinces'),
                    child: Container(
                      color: _selectedLevel == 'Provinces'
                          ? Colors.orange
                          : Colors.blue[100],
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Province (medium)',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectLevel('Cities'),
                    child: Container(
                      color: _selectedLevel == 'Cities'
                          ? Colors.red
                          : Colors.blue[100],
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Cities (hard)',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_selectedCategory == 'Luzon' &&
                      _selectedLevel == 'Regions') {
                    // Navigate to the game page with the selected category and level
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LuzonRegion(
                          category: _selectedCategory,
                          level: _selectedLevel,
                        ),
                      ),
                    );
                  }
                  if (_selectedCategory == 'Luzon' &&
                      _selectedLevel == 'Provinces') {
                    // Navigate to the game page with the selected category and level
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LuzonProvince(
                          category: _selectedCategory,
                          level: _selectedLevel,
                        ),
                      ),
                    );
                  }
                  if (_selectedCategory == 'Luzon' &&
                      _selectedLevel == 'Cities') {
                    // Navigate to the game page with the selected category and level
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LuzonCity(
                          category: _selectedCategory,
                          level: _selectedLevel,
                        ),
                      ),
                    );
                  }
                  if (_selectedCategory == 'Visayas' &&
                      _selectedLevel == 'Regions') {
                    // Navigate to the game page with the selected category and level
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VisayasRegion(
                          category: _selectedCategory,
                          level: _selectedLevel,
                        ),
                      ),
                    );
                  }
                  if (_selectedCategory == 'Visayas' &&
                      _selectedLevel == 'Provinces') {
                    // Navigate to the game page with the selected category and level
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VisayasProvince(
                          category: _selectedCategory,
                          level: _selectedLevel,
                        ),
                      ),
                    );
                  }
                  if (_selectedCategory == 'Visayas' &&
                      _selectedLevel == 'Cities') {
                    // Navigate to the game page with the selected category and level
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VisayasCity(
                          category: _selectedCategory,
                          level: _selectedLevel,
                        ),
                      ),
                    );
                  }
                  if (_selectedCategory == 'Mindanao' &&
                      _selectedLevel == 'Regions') {
                    // Navigate to the game page with the selected category and level
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MindanaoRegion(
                          category: _selectedCategory,
                          level: _selectedLevel,
                        ),
                      ),
                    );
                  }
                  if (_selectedCategory == 'Mindanao' &&
                      _selectedLevel == 'Provinces') {
                    // Navigate to the game page with the selected category and level
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MindanaoProvince(
                          category: _selectedCategory,
                          level: _selectedLevel,
                        ),
                      ),
                    );
                  }
                  if (_selectedCategory == 'Mindanao' &&
                      _selectedLevel == 'Cities') {
                    // Navigate to the game page with the selected category and level
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MindanaoCity(
                          category: _selectedCategory,
                          level: _selectedLevel,
                        ),
                      ),
                    );
                  } else {
                    // Show a message or handle the case where no category or level is selected
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: _selectedCategory.isNotEmpty &&
                          _selectedLevel.isNotEmpty
                      ? Colors.blue
                      : Colors.grey,
                ),
                child: const Text('Play'),
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
