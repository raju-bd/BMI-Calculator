# BMI Calculator — Flutter Project Specification

## 1. Project Overview

Create a simple, clean, responsive **Flutter BMI Calculator application**.

The application allows users to enter:

- Weight in kilograms (kg)
- Height in centimeters (cm)

The app calculates the user's **Body Mass Index (BMI)** and displays:

- BMI value
- BMI category
- Visual indication based on the category

The application must use **Dart and Flutter only** for the calculation and UI logic.

---

# 2. Objective

Build a Flutter application that calculates BMI using:

```text
BMI = Weight (kg) / Height² (m)
```

Example:

```text
Weight = 70 kg
Height = 170 cm

Height in meters = 170 / 100
                 = 1.70 m

BMI = 70 / (1.70 × 1.70)
    = 24.22
```

Result:

```text
BMI: 24.22
Category: Normal Weight
```

---

# 3. BMI Categories

Use the following classification:

| BMI Range | Category |
|---|---|
| Below 18.5 | Underweight |
| 18.5 – 24.9 | Normal Weight |
| 25.0 – 29.9 | Overweight |
| 30.0 or above | Obesity |

Dart logic:

```dart
if (bmi < 18.5) {
  category = 'Underweight';
} else if (bmi < 25.0) {
  category = 'Normal Weight';
} else if (bmi < 30.0) {
  category = 'Overweight';
} else {
  category = 'Obesity';
}
```

---

# 4. Technical Requirements

## Framework

Use:

```text
Flutter
Dart
```

Use a standard Flutter application structure.

Recommended minimum architecture:

```text
lib/
├── main.dart
└── screens/
    └── bmi_calculator_screen.dart
```

For a small application, keeping the implementation inside `main.dart` is also acceptable, but prefer separating the main screen into its own file if practical.

---

# 5. Restrictions

Do NOT use:

- Firebase
- REST API
- HTTP requests
- Database
- SQLite
- Cloud services
- Backend services
- External BMI APIs
- Authentication
- State-management packages

The BMI calculation must happen locally on the device.

Use:

```dart
setState()
```

for updating the calculation result.

Do not introduce unnecessary third-party dependencies.

Prefer Flutter's built-in widgets and Dart libraries.

---

# 6. User Interface

Create a modern, clean and responsive UI.

The main screen should contain:

```text
┌────────────────────────────────────┐
│          BMI Calculator             │
├────────────────────────────────────┤
│                                    │
│       Calculate Your BMI           │
│                                    │
│  Weight                             │
│  ┌──────────────────────────────┐  │
│  │ Enter weight        kg       │  │
│  └──────────────────────────────┘  │
│                                    │
│  Height                             │
│  ┌──────────────────────────────┐  │
│  │ Enter height        cm       │  │
│  └──────────────────────────────┘  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │       Calculate BMI          │  │
│  └──────────────────────────────┘  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │          BMI Result          │  │
│  │                              │  │
│  │           24.22              │  │
│  │                              │  │
│  │       Normal Weight          │  │
│  │                              │  │
│  └──────────────────────────────┘  │
│                                    │
│           Reset                    │
│                                    │
└────────────────────────────────────┘
```

The exact visual design can be improved as long as all required functionality remains.

---

# 7. Required Flutter Widgets

Use appropriate Flutter widgets including:

- `MaterialApp`
- `Scaffold`
- `AppBar`
- `SafeArea`
- `SingleChildScrollView`
- `Column`
- `Padding`
- `SizedBox`
- `Text`
- `TextField`
- `InputDecoration`
- `ElevatedButton`
- `OutlinedButton`
- `Card` or `Container`
- `Icon`
- `Row`

Use `TextEditingController` for both input fields.

Example:

```dart
final TextEditingController weightController = TextEditingController();
final TextEditingController heightController = TextEditingController();
```

---

# 8. Input Fields

## Weight

Create a TextField for weight.

Requirements:

- Label: `Weight`
- Hint: `Enter weight`
- Unit: `kg`
- Numeric keyboard
- Accept decimal values
- Validate input

Use:

```dart
keyboardType: const TextInputType.numberWithOptions(
  decimal: true,
)
```

---

## Height

Create a TextField for height.

Requirements:

- Label: `Height`
- Hint: `Enter height`
- Unit: `cm`
- Numeric keyboard
- Accept decimal values
- Validate input

Use:

```dart
keyboardType: const TextInputType.numberWithOptions(
  decimal: true,
)
```

---

# 9. Input Validation

Before calculating BMI, validate both fields.

Validation requirements:

### Empty Weight

Display an appropriate validation message:

```text
Please enter your weight.
```

### Empty Height

Display:

```text
Please enter your height.
```

### Invalid Number

Display:

```text
Please enter a valid number.
```

### Zero or Negative Value

Weight must be greater than zero.

Height must be greater than zero.

Display an appropriate message such as:

```text
Weight must be greater than 0.
```

or:

```text
Height must be greater than 0.
```

Prefer using Flutter `Form` and `TextFormField` validation if it improves code quality, but a simple validation implementation is also acceptable.

---

# 10. BMI Calculation

When the user presses **Calculate BMI**:

### Step 1

Read weight:

```dart
final double weight = double.parse(weightController.text);
```

### Step 2

Read height in centimeters:

```dart
final double heightCm = double.parse(heightController.text);
```

### Step 3

Convert centimeters to meters:

```dart
final double heightM = heightCm / 100;
```

### Step 4

Calculate BMI:

```dart
final double bmi = weight / (heightM * heightM);
```

### Step 5

Determine category.

```dart
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
```

### Step 6

Update the UI using:

```dart
setState(() {
  bmiResult = bmi;
  bmiCategory = category;
});
```

---

# 11. State Variables

Use state variables similar to:

```dart
double? bmiResult;
String? bmiCategory;
```

Optionally maintain a visual state:

```dart
IconData? categoryIcon;
```

Do not use external state-management libraries.

---

# 12. Result Display

After successful calculation, display a result card.

Example:

```text
BMI RESULT

24.22

Normal Weight
```

BMI should be displayed with **two decimal places**:

```dart
bmiResult!.toStringAsFixed(2)
```

Before calculation, the result card should either:

- remain hidden, or
- display an instructional message.

Example:

```text
Enter your height and weight
to calculate your BMI.
```

---

# 13. Visual BMI Category Indicator

Add a visual indication based on the BMI category.

Use suitable Flutter UI elements such as:

- Icon
- Emoji
- Progress indicator
- Badge
- Card
- Status text

Example:

### Underweight

```text
⚠️ Underweight
```

### Normal Weight

```text
✓ Normal Weight
```

### Overweight

```text
⚠️ Overweight
```

### Obesity

```text
⚠️ Obesity
```

Use appropriate visual styling for each category.

The UI should clearly distinguish the categories.

---

# 14. Recommended Visual Design

Create a polished modern mobile UI.

Recommended design characteristics:

- Material 3
- Rounded cards
- Good spacing
- Clear typography
- Responsive layout
- Proper input field styling
- Large BMI result
- Clear category indicator
- Accessible contrast
- Avoid excessive decoration

Use `ThemeData` and Material 3.

Example:

```dart
MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    useMaterial3: true,
  ),
  home: const BmiCalculatorScreen(),
);
```

Do not hard-code excessive styling throughout the widget tree.

Prefer reusable constants or helper methods where appropriate.

---

# 15. Calculate Button

Create a prominent:

```text
Calculate BMI
```

button.

When pressed:

1. Validate inputs.
2. Convert height.
3. Calculate BMI.
4. Determine category.
5. Update result.
6. Update visual indicator.

If validation fails:

- Do not calculate.
- Do not display an invalid result.
- Show the validation message.

---

# 16. Reset Button

Create a:

```text
Reset
```

button.

When pressed:

```dart
weightController.clear();
heightController.clear();

setState(() {
  bmiResult = null;
  bmiCategory = null;
});
```

Also clear any validation errors.

After reset, the application should return to its initial state.

---

# 17. Controller Lifecycle

Because `TextEditingController` objects are being used, dispose them properly.

Example:

```dart
@override
void dispose() {
  weightController.dispose();
  heightController.dispose();
  super.dispose();
}
```

---

# 18. Keyboard and UX

Improve the user experience:

- Use numeric keyboards.
- Allow decimal values.
- Dismiss keyboard after calculation if appropriate.
- Prevent unnecessary overflow on small screens.
- Use `SingleChildScrollView`.
- Use appropriate spacing between fields and buttons.

Optional:

```dart
FocusScope.of(context).unfocus();
```

after successful calculation.

---

# 19. Accessibility

The application should be usable by a wide range of users.

Requirements:

- Clear labels
- Meaningful hint text
- Sufficient text size
- Good contrast
- Buttons should be easy to tap
- Avoid relying only on color to communicate the BMI category

---

# 20. Error Handling

Do not allow the application to crash because of invalid user input.

Handle cases such as:

```text
Empty input
Invalid number
Letters in numeric fields
Zero
Negative number
Decimal numbers
Very large numbers
```

Use safe parsing where practical:

```dart
final weight = double.tryParse(weightController.text);
final heightCm = double.tryParse(heightController.text);
```

Prefer `tryParse()` over `double.parse()` for user-entered values.

---

# 21. BMI Calculation Helper

For clean code, create a helper method such as:

```dart
void calculateBMI() {
  final weight = double.tryParse(weightController.text);
  final heightCm = double.tryParse(heightController.text);

  if (weight == null || weight <= 0) {
    return;
  }

  if (heightCm == null || heightCm <= 0) {
    return;
  }

  final heightM = heightCm / 100;
  final bmi = weight / (heightM * heightM);

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

  setState(() {
    bmiResult = bmi;
    bmiCategory = category;
  });
}
```

However, implement proper user-facing validation rather than silently returning from the method.

---

# 22. Suggested Code Structure

Recommended structure:

```text
lib/
│
├── main.dart
│
└── screens/
    └── bmi_calculator_screen.dart
```

`main.dart`:

```dart
import 'package:flutter/material.dart';
import 'screens/bmi_calculator_screen.dart';

void main() {
  runApp(const BmiCalculatorApp());
}

class BmiCalculatorApp extends StatelessWidget {
  const BmiCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const BmiCalculatorScreen(),
    );
  }
}
```

---

# 23. Functional Requirements Checklist

The implementation must satisfy all of the following:

- [ ] Flutter application created
- [ ] Material 3 enabled
- [ ] BMI Calculator screen created
- [ ] Weight input created
- [ ] Height input created
- [ ] Weight accepts kg
- [ ] Height accepts cm
- [ ] Numeric keyboard enabled
- [ ] Decimal values supported
- [ ] Empty input validation
- [ ] Invalid number validation
- [ ] Zero validation
- [ ] Negative number validation
- [ ] Height converted from cm to meters
- [ ] BMI calculated locally
- [ ] BMI category determined
- [ ] BMI displayed to 2 decimal places
- [ ] Category displayed
- [ ] Visual category indicator implemented
- [ ] Calculate BMI button implemented
- [ ] Reset button implemented
- [ ] `setState()` used
- [ ] Controllers disposed
- [ ] No Firebase
- [ ] No API
- [ ] No database
- [ ] No backend
- [ ] No unnecessary dependencies
- [ ] Responsive UI
- [ ] Keyboard handling implemented
- [ ] Application does not crash on invalid input

---

# 24. Testing Scenarios

Test the application with the following values.

## Test 1 — Underweight

```text
Weight: 50 kg
Height: 175 cm
```

Expected:

```text
BMI: 16.33
Category: Underweight
```

---

## Test 2 — Normal Weight

```text
Weight: 70 kg
Height: 170 cm
```

Expected:

```text
BMI: 24.22
Category: Normal Weight
```

---

## Test 3 — Overweight

```text
Weight: 85 kg
Height: 170 cm
```

Expected:

```text
BMI: 29.41
Category: Overweight
```

---

## Test 4 — Obesity

```text
Weight: 100 kg
Height: 170 cm
```

Expected:

```text
BMI: 34.60
Category: Obesity
```

---

## Test 5 — Empty Input

```text
Weight: empty
Height: empty
```

Expected:

```text
Validation error
```

Application must not crash.

---

## Test 6 — Zero

```text
Weight: 0
Height: 170
```

Expected:

```text
Weight must be greater than 0.
```

---

## Test 7 — Negative Value

```text
Weight: -70
Height: 170
```

Expected:

```text
Weight must be greater than 0.
```

---

## Test 8 — Invalid Text

```text
Weight: abc
Height: xyz
```

Expected:

```text
Please enter a valid number.
```

Application must not crash.

---

# 25. Code Quality Requirements

Write clean, readable and maintainable Dart code.

Follow Flutter best practices.

Requirements:

- Use `const` wherever possible.
- Use meaningful variable names.
- Avoid unnecessary rebuilds.
- Avoid duplicated code.
- Dispose controllers.
- Keep business logic understandable.
- Keep UI code organized.
- Avoid unnecessary packages.
- Avoid deprecated Flutter APIs.
- Do not introduce over-engineering.

---

# 26. Final Deliverable

The final Flutter project should be runnable using:

```bash
flutter pub get
flutter run
```

The application should launch directly into the BMI Calculator screen.

No backend setup should be required.

No API key should be required.

No database configuration should be required.

---

# 27. Kilo Code Implementation Instructions

When implementing this project:

1. Inspect the existing Flutter project structure first.
2. Do not unnecessarily recreate the entire project if a Flutter project already exists.
3. Implement the BMI Calculator using the existing project structure where appropriate.
4. Create or modify only the required files.
5. Do not add Firebase, APIs, databases, or unnecessary packages.
6. Use Flutter Material 3.
7. Implement all validation requirements.
8. Use `setState()` for BMI result updates.
9. Ensure the Reset button completely resets the screen.
10. Test the BMI calculation using the provided test cases.
11. Check for Dart analyzer errors.
12. Check for Flutter compilation errors.
13. Fix any errors before considering the implementation complete.
14. Keep the final implementation simple, clean and production-quality.
15. Do not replace working project configuration unless necessary.

---

# 28. Definition of Done

The task is complete only when:

```text
✓ User can enter weight
✓ User can enter height
✓ User can calculate BMI
✓ Invalid input is handled
✓ BMI is calculated correctly
✓ BMI is displayed with 2 decimals
✓ BMI category is displayed
✓ Category has a visual indication
✓ Reset clears everything
✓ UI works on different screen sizes
✓ No application crashes from invalid input
✓ No external services are used
✓ No database is used
✓ No unnecessary dependencies are introduced
✓ Flutter analyzer passes
✓ Application builds successfully
```

**Build the application according to this specification and prioritize correctness, clean UI, simple Dart logic, and maintainability.**