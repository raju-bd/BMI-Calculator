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
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
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
        return const Color(0xFF0061A4);
      case 'Normal Weight':
        return const Color(0xFF386A20);
      case 'Overweight':
        return const Color(0xFFF57C00);
      case 'Obesity':
        return const Color(0xFFB3261E);
      default:
        return const Color(0xFF49454F);
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
                const SizedBox(height: 16),

                // Header text
                Text(
                  'Calculate Your BMI',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  'Enter your details below to check your health status',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF79747E),
                      ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Weight input field
                TextFormField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    hintText: 'Enter weight',
                    suffixText: 'kg',
                    prefixIcon: const Icon(Icons.monitor_weight_outlined),
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

                const SizedBox(height: 16),

                // Height input field
                TextFormField(
                  controller: _heightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Height',
                    hintText: 'Enter height',
                    suffixText: 'cm',
                    prefixIcon: const Icon(Icons.height_outlined),
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

                const SizedBox(height: 24),

                // Calculate button - prominent and easy to tap
                ElevatedButton(
                  onPressed: _calculateBMI,
                  child: const Text('Calculate BMI'),
                ),

                const SizedBox(height: 12),

                // Reset button - outlined style to distinguish from calculate
                OutlinedButton(
                  onPressed: _resetFields,
                  child: const Text('Reset'),
                ),

                const SizedBox(height: 24),

                // Result card - shows the BMI result or an instructional message
                _buildResultCard(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the result card with modern styling
  Widget _buildResultCard() {
    final bool hasResult = _bmiResult != null && _bmiCategory != null;

    return Card(
      color: hasResult
          ? _getCategoryColor(_bmiCategory!).withOpacity(0.08)
          : null,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Result label
            Text(
              'BMI RESULT',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 16),

            // If we have a result, show it; otherwise show instructions
            if (hasResult) ...[
              // Display the BMI value with 2 decimal places
              AnimatedScale(
                scale: hasResult ? 1.0 : 0.8,
                duration: const Duration(milliseconds: 400),
                curve: Curves.elasticOut,
                child: Text(
                  _bmiResult!.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getCategoryColor(_bmiCategory!),
                      ),
                ),
              ),

              const SizedBox(height: 12),

              // Display the category with an icon
              AnimatedOpacity(
                opacity: hasResult ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(_bmiCategory!).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getCategoryIcon(_bmiCategory!),
                        color: _getCategoryColor(_bmiCategory!),
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _bmiCategory!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: _getCategoryColor(_bmiCategory!),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              // Instructional message before calculation
              Icon(
                Icons.calculate_outlined,
                size: 56,
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
    );
  }
}
