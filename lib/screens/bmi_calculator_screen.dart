import 'package:flutter/material.dart';

/// BMI Calculator Screen
///
/// This screen allows users to enter their weight (kg) and height (cm),
/// calculate their BMI, and view the result with category indication.
class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  // Controllers for the weight and height input fields
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  // State variables to hold the calculated BMI and its category
  double? _bmiResult;
  String? _bmiCategory;

  // Form key for validating the input fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    // This prevents memory leaks
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  /// Calculates the BMI based on weight and height inputs.
  ///
  /// BMI formula: weight (kg) / height (m) ^ 2
  /// Height is converted from cm to meters before calculation.
  void _calculateBMI() {
    // First, validate the form inputs
    if (!_formKey.currentState!.validate()) {
      return; // Don't calculate if validation fails
    }

    // Dismiss the keyboard after successful validation
    FocusScope.of(context).unfocus();

    // Parse the input values using tryParse for safety
    final double? weight = double.tryParse(_weightController.text);
    final double? heightCm = double.tryParse(_heightController.text);

    // Additional validation for parsed values
    if (weight == null || weight <= 0) {
      _showError('Please enter a valid weight greater than 0.');
      return;
    }

    if (heightCm == null || heightCm <= 0) {
      _showError('Please enter a valid height greater than 0.');
      return;
    }

    // Convert height from centimeters to meters
    final double heightM = heightCm / 100;

    // Calculate BMI using the standard formula
    final double bmi = weight / (heightM * heightM);

    // Determine the BMI category based on the calculated value
    String category;
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 25.0) {
      category = 'Normal Weight';
    } else if (bmi < 30.0) {
      category = 'Overweight';
    } else {
      category = 'Obesity';
    }

    // Update the UI with the calculated result
    setState(() {
      _bmiResult = bmi;
      _bmiCategory = category;
    });
  }

  /// Resets all input fields and clears the calculated result.
  void _resetFields() {
    // Clear the text controllers
    _weightController.clear();
    _heightController.clear();

    // Reset the form validation state
    _formKey.currentState?.reset();

    // Clear the result and category
    setState(() {
      _bmiResult = null;
      _bmiCategory = null;
    });

    // Dismiss the keyboard if it's open
    FocusScope.of(context).unfocus();
  }

  /// Shows a snackbar with the given error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  /// Returns the appropriate icon for the given BMI category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Underweight':
        return Icons.warning_amber_rounded;
      case 'Normal Weight':
        return Icons.check_circle_rounded;
      case 'Overweight':
        return Icons.warning_rounded;
      case 'Obesity':
        return Icons.dangerous_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  /// Returns the appropriate color for the given BMI category
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.blue;
      case 'Normal Weight':
        return Colors.green;
      case 'Overweight':
        return Colors.orange;
      case 'Obesity':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using SafeArea to avoid system UI overlaps (notch, status bar, etc.)
    return SafeArea(
      child: Scaffold(
        // App bar with the title of the app
        appBar: AppBar(
          title: const Text('BMI Calculator'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        // Using SingleChildScrollView to prevent overflow on small screens
        body: SingleChildScrollView(
          // Padding to give some space from the edges
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              // CrossAxisAlignment.stretch makes children take full width
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // Header text
                Text(
                  'Calculate Your BMI',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Weight input field
                TextFormField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Weight',
                    hintText: 'Enter weight',
                    suffixText: 'kg',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.monitor_weight_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight.';
                    }
                    final double? weight = double.tryParse(value);
                    if (weight == null) {
                      return 'Please enter a valid number.';
                    }
                    if (weight <= 0) {
                      return 'Weight must be greater than 0.';
                    }
                    return null; // Validation passed
                  },
                ),

                const SizedBox(height: 20),

                // Height input field
                TextFormField(
                  controller: _heightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Height',
                    hintText: 'Enter height',
                    suffixText: 'cm',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.height_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height.';
                    }
                    final double? height = double.tryParse(value);
                    if (height == null) {
                      return 'Please enter a valid number.';
                    }
                    if (height <= 0) {
                      return 'Height must be greater than 0.';
                    }
                    return null; // Validation passed
                  },
                ),

                const SizedBox(height: 30),

                // Calculate button - prominent and easy to tap
                ElevatedButton(
                  onPressed: _calculateBMI,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Calculate BMI'),
                ),

                const SizedBox(height: 20),

                // Reset button - outlined style to distinguish from calculate
                OutlinedButton(
                  onPressed: _resetFields,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Reset'),
                ),

                const SizedBox(height: 30),

                // Result card - shows the BMI result or an instructional message
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // Result label
                        Text(
                          'BMI RESULT',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                        ),

                        const SizedBox(height: 16),

                        // If we have a result, show it; otherwise show instructions
                        if (_bmiResult != null && _bmiCategory != null) ...[
                          // Display the BMI value with 2 decimal places
                          Text(
                            _bmiResult!.toStringAsFixed(2),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: _getCategoryColor(_bmiCategory!),
                                ),
                          ),

                          const SizedBox(height: 12),

                          // Display the category with an icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getCategoryIcon(_bmiCategory!),
                                color: _getCategoryColor(_bmiCategory!),
                                size: 28,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _bmiCategory!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: _getCategoryColor(_bmiCategory!),
                                    ),
                              ),
                            ],
                          ),
                        ] else ...[
                          // Instructional message before calculation
                          Icon(
                            Icons.calculate_outlined,
                            size: 64,
                            color: Theme.of(context).disabledColor,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Enter your height and weight\nto calculate your BMI.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).disabledColor,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
