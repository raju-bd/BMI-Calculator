import 'package:flutter/material.dart';
import 'developer_info_screen.dart';

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
        return const Color(0xFF26A69A);
      case 'Normal Weight':
        return const Color(0xFF2E7D32);
      case 'Overweight':
        return const Color(0xFFF57C00);
      case 'Obesity':
        return const Color(0xFFB3261E);
      default:
        return const Color(0xFF1B5E20);
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
        // Using Center + ConstrainedBox to prevent blank space on wide screens
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
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
                            color: const Color(0xFF2E7D32),
                          ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    // Weight input field
                    _buildAnimatedField(
                      index: 0,
                      child: TextFormField(
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
                    ),

                    const SizedBox(height: 16),

                    // Height input field
                    _buildAnimatedField(
                      index: 1,
                      child: TextFormField(
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
                    ),

                    // Hint for height conversion
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 6),
                      child: Text(
                        '1 feet = 30.48 cm',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                               color: const Color(0xFF2E7D32),
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Calculate button - animated on press
                    _buildAnimatedButton(
                      onPressed: _calculateBMI,
                      label: 'Calculate BMI',
                      isPrimary: true,
                    ),

                    // Reset button - only visible after calculation
                    if (_bmiResult != null && _bmiCategory != null) ...[
                      const SizedBox(height: 12),
                      _buildAnimatedButton(
                        onPressed: _resetFields,
                        label: 'Reset',
                        isPrimary: false,
                      ),
                    ],

                    const SizedBox(height: 20),

                    // Result card - shows the BMI result or an instructional message
                    _buildResultCard(),

                    const SizedBox(height: 5),

                    // Developer info navigation link
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DeveloperInfoScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.person_outline_rounded),
                      label: const Text('Developer Info'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds an animated input field with staggered entrance animation
  Widget _buildAnimatedField({required int index, required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 150)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  /// Builds an animated button with press feedback
  Widget _buildAnimatedButton({
    required VoidCallback onPressed,
    required String label,
    required bool isPrimary,
  }) {
    final button = isPrimary
        ? ElevatedButton(onPressed: onPressed, child: Text(label))
        : OutlinedButton(onPressed: onPressed, child: Text(label));

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.95, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: button,
    );
  }

  /// Builds the result card with modern styling
  Widget _buildResultCard() {
    final bool hasResult = _bmiResult != null && _bmiCategory != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: hasResult
            ? _getCategoryColor(_bmiCategory!).withValues(alpha: 0.08)
            : const Color(0xFFFEF7FF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: hasResult
              ? _getCategoryColor(_bmiCategory!).withValues(alpha: 0.2)
               : const Color(0xFFE8F5E9),
          width: 1.5,
        ),
        boxShadow: hasResult
            ? [
                BoxShadow(
                  color: _getCategoryColor(_bmiCategory!).withValues(alpha: 0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: const Color(0xFF1D1B20).withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
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
              // BMI gauge visualization
              _buildBmiGauge(_bmiResult!, _bmiCategory!),

              const SizedBox(height: 20),

              // Display the BMI value with 2 decimal places
              AnimatedScale(
                scale: hasResult ? 1.0 : 0.8,
                duration: const Duration(milliseconds: 500),
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

              // Display the category with an animated badge
              AnimatedOpacity(
                opacity: hasResult ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getCategoryColor(_bmiCategory!).withValues(alpha: 0.2),
                          _getCategoryColor(_bmiCategory!).withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getCategoryColor(_bmiCategory!).withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedRotation(
                          turns: hasResult ? 0 : 1,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.elasticOut,
                          child: Icon(
                            _getCategoryIcon(_bmiCategory!),
                            color: _getCategoryColor(_bmiCategory!),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _bmiCategory!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: _getCategoryColor(_bmiCategory!),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ] else ...[
              // Instructional message before calculation
              AnimatedOpacity(
                opacity: hasResult ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
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
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Builds a visual BMI gauge indicator
  Widget _buildBmiGauge(double bmi, String category) {
    // BMI scale: 10 to 40 mapped to 0-1
    final double minBmi = 10.0;
    final double maxBmi = 40.0;
    final double clampedBmi = bmi.clamp(minBmi, maxBmi);
    final double progress = (clampedBmi - minBmi) / (maxBmi - minBmi);

    // Determine gauge color based on category
    final Color gaugeColor = _getCategoryColor(category);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: progress),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Column(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFFE8F5E9),
              ),
              child: FractionallySizedBox(
                widthFactor: value,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [
                        gaugeColor,
                        gaugeColor.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Underweight',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF2E7D32),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  'Obesity',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFB3261E),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
