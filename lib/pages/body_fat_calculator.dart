import 'package:flutter/material.dart';

class BodyFatCalculator extends StatefulWidget {
  const BodyFatCalculator({super.key});

  @override
  State<BodyFatCalculator> createState() => _BodyFatCalculatorState();
}

class _BodyFatCalculatorState extends State<BodyFatCalculator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController waistController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String gender = "Male";
  String bodyFatResult = "";
  String bodyFatDescription = "";

  void calculateBodyFat() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    final double waist = double.tryParse(waistController.text) ?? 0;
    final int age = int.tryParse(ageController.text) ?? 0;

    if (waist > 0 && age > 0) {
      final double bodyFatPercentage =
          calculateBodyFatPercentage(waist, age, gender);

      setState(() {
        bodyFatResult = bodyFatPercentage.toStringAsFixed(1);
        bodyFatDescription = getBodyFatDescription(bodyFatPercentage);
      });
    }
  }

  double calculateBodyFatPercentage(double waist, int age, String gender) {
    return gender == "Male"
        ? (waist * 0.74) - (age * 0.082) - 34.89
        : (waist * 0.74) - (age * 0.082) - 28.50;
  }

  String getBodyFatDescription(double bodyFat) {
    if (bodyFat < 10) {
      return "Essential fat";
    } else if (bodyFat < 20) {
      return "Athletes";
    } else if (bodyFat < 30) {
      return "Fitness";
    } else if (bodyFat < 40) {
      return "Acceptable";
    } else {
      return "Obese";
    }
  }

  void clearFields() {
    setState(() {
      ageController.clear();
      waistController.clear();
      gender = "Male";
      bodyFatResult = "";
      bodyFatDescription = "";
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
                "Body Fat Calculator",
                style: TextStyle(fontSize: 25),
              ),
            ),
            TextFormField(
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
              controller: ageController,
              decoration: const InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid waist measurement.';
                }
                return null;
              },
              controller: waistController,
              decoration: const InputDecoration(
                labelText: "Waist Circumference (cm)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: calculateBodyFat,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Calculate Body Fat",
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
              bodyFatResult.isNotEmpty ? "Body Fat: $bodyFatResult%" : "",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              bodyFatDescription,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
