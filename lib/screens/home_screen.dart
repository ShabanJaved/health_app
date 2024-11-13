import 'package:flutter/material.dart';
import 'package:health_app/pages/bmi_calculator.dart';
import 'package:health_app/pages/bmr_calculator.dart';
import 'package:health_app/pages/body_fat_calculator.dart';
import 'package:health_app/pages/ideal_weight_calculator.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<bool> toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  final List<Widget> _pages = [
    const BMICalculator(),
    const BodyFatCalculator(),
    const BMRCalculator(),
    const IdealWeightCalculator(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Health & Fitness Calculator"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: const Center(
                  child: Text(
                    'Health & Fitness Calculator',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: const Text('BMI'),
              selected: _selectedIndex == 0,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Body Fat'),
              selected: _selectedIndex == 1,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_fire_department),
              title: const Text('BMR'),
              selected: _selectedIndex == 2,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.accessibility_new),
              title: const Text('Ideal Weight'),
              selected: _selectedIndex == 3,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(3);
              },
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                  widget.toggleTheme(value);
                });
              },
              secondary: Icon(
                _isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            icon: Icon(
              Icons.accessibility,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'BMI',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            icon: Icon(
              Icons.fitness_center,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Body Fat',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            icon: Icon(
              Icons.local_fire_department,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'BMR',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            icon: Icon(
              Icons.accessibility_new,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Ideal Weight',
          ),
        ],
      ),
    );
  }
}
