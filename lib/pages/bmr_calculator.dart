import 'package:flutter/material.dart';

class BMRCalculator extends StatefulWidget {
  const BMRCalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BMRCalculatorState createState() => _BMRCalculatorState();
}

class _BMRCalculatorState extends State<BMRCalculator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  double bmr = 0.0;

  // Calculate BMR using the Mifflin-St Jeor Equation
  void calculateBMR() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    final int age = int.tryParse(ageController.text) ?? 0;
    final int weight = int.tryParse(weightController.text) ?? 0;
    final int height = int.tryParse(heightController.text) ?? 0;

    setState(() {
      // BMR calculation for male (modify for female or other factors if needed)
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    });
  }

  // Clear all inputs
  void clearInputs() {
    setState(() {
      ageController.clear();
      weightController.clear();
      heightController.clear();
      bmr = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'BMR Calculator',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter age.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter weight.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: heightController,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter height.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: calculateBMR,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Calculate BMR",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: clearInputs,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Clear",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (bmr > 0)
              Text(
                'Your BMR is ${bmr.toStringAsFixed(1)} kcal/day',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
