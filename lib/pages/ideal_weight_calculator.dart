import 'package:flutter/material.dart';

class IdealWeightCalculator extends StatefulWidget {
  const IdealWeightCalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IdealWeightCalculatorState createState() => _IdealWeightCalculatorState();
}

class _IdealWeightCalculatorState extends State<IdealWeightCalculator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String gender = 'Male';
  double idealWeight = 0.0;

  // Calculate Ideal Weight using Devine Formula
  void calculateIdealWeight() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    final int height = int.tryParse(heightController.text) ?? 0;

    setState(() {
      if (gender == 'Male') {
        idealWeight = 50 + 2.3 * ((height - 152) / 2.54);
      } else {
        idealWeight = 45.5 + 2.3 * ((height - 152) / 2.54);
      }
    });
  }

  // Clear all inputs
  void clearInputs() {
    setState(() {
      ageController.clear();
      heightController.clear();
      gender = 'Male';
      idealWeight = 0.0;
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
                'Ideal Weight Calculator',
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
            DropdownButtonFormField<String>(
              value: gender,
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  gender = newValue!;
                });
              },
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
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
                    onPressed: calculateIdealWeight,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Calculate Ideal Weight",
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
            if (idealWeight > 0)
              Text(
                'Your Ideal Weight is ${idealWeight.toStringAsFixed(1)} kg',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
