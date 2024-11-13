import 'dart:math';
import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String gender = "Male";
  String bmiResult = "";
  String resultText = "";

  void calculateBMI() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    final double height = double.tryParse(heightController.text) ?? 0;
    final double weight = double.tryParse(weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      final double bmi = weight / pow(height / 100, 2);
      setState(() {
        bmiResult = bmi.toStringAsFixed(1);
        resultText = getBMIDescription(bmi);
      });
    }
  }

  void clearFields() {
    setState(() {
      ageController.clear();
      heightController.clear();
      weightController.clear();
      gender = "Male";
      bmiResult = "";
      resultText = "";
    });
  }

  String getBMIDescription(double bmi) {
    if (bmi >= 25.0) {
      return 'Overweight';
    } else if (bmi > 18.5) {
      return 'Normal weight';
    } else {
      return 'Underweight';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "BMI Calculator",
                style: TextStyle(fontSize: 25),
              ),
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an age.';
                }
                final age = int.tryParse(value);
                if (age == null || age <= 0 || age > 120) {
                  return 'Please enter a valid age between 1 and 120.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: gender,
              items: ["Male", "Female"]
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  gender = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: heightController,
              decoration: const InputDecoration(
                labelText: "Height (cm)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a height.';
                }
                final height = double.tryParse(value);
                if (height == null || height < 30 || height > 300) {
                  return 'Please enter a valid height between 30 and 300 cm.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a weight.';
                }
                final weight = double.tryParse(value);
                if (weight == null || weight <= 0 || weight > 500) {
                  return 'Please enter a valid weight between 1 and 500 kg.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: calculateBMI,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Calculate BMI",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: clearFields,
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
            Text(
              bmiResult.isNotEmpty ? "BMI: $bmiResult" : "",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              resultText,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
