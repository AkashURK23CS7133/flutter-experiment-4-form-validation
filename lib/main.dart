// Experiment 4: Form Validation using Stateful Widgets
// Car Mileage Calculator
import 'package:flutter/material.dart';

void main() {
  runApp(const CarMileageApp());
}

class CarMileageApp extends StatelessWidget {
  const CarMileageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Mileage Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MileagePage(),
    );
  }
}

/// Mileage (km/l) = distance (km) / fuel (litres).
double calculateMileage(double distance, double fuel) => distance / fuel;

/// Below 10 = Low, 10 to 15 = Average, above 15 = Excellent.
String efficiencyFor(double mileage) {
  if (mileage < 10) return 'Low Efficiency';
  if (mileage <= 15) return 'Average Efficiency';
  return 'Excellent Efficiency';
}

class MileagePage extends StatefulWidget {
  const MileagePage({super.key});

  @override
  State<MileagePage> createState() => _MileagePageState();
}

class _MileagePageState extends State<MileagePage> {
  final _formKey = GlobalKey<FormState>();
  final _distanceController = TextEditingController();
  final _fuelController = TextEditingController();

  double? _mileage;
  String _efficiency = '';
  String _distanceUsed = '';
  String _fuelUsed = '';

  void _calculateMileage() {
    if (!_formKey.currentState!.validate()) return;

    final distance = double.parse(_distanceController.text.trim());
    final fuel = double.parse(_fuelController.text.trim());
    final result = calculateMileage(distance, fuel);

    setState(() {
      _mileage = result;
      _efficiency = efficiencyFor(result);
      _distanceUsed = _distanceController.text.trim();
      _fuelUsed = _fuelController.text.trim();
    });
  }

  void _clearFields() {
    _formKey.currentState?.reset();
    _distanceController.clear();
    _fuelController.clear();
    setState(() {
      _mileage = null;
      _efficiency = '';
    });
  }

  String? _validateNumber(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $field';
    }
    final number = double.tryParse(value.trim());
    if (number == null) return 'Enter a valid number';
    if (number <= 0) return '${field[0].toUpperCase()}${field.substring(1)} must be greater than zero';
    return null;
  }

  Color get _efficiencyColor {
    switch (_efficiency) {
      case 'Low Efficiency':
        return Colors.red.shade100;
      case 'Average Efficiency':
        return Colors.amber.shade100;
      default:
        return Colors.green.shade100;
    }
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _fuelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7F7),
      appBar: AppBar(
        title: const Text('🚗 Car Mileage Calculator',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFF087C91),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF008F83), Color(0xFF1769C2)],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Column(
                    children: [
                      Text('🚗', style: TextStyle(fontSize: 42)),
                      SizedBox(height: 12),
                      Text('Car Mileage Calculator',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      Text("Calculate your vehicle's fuel efficiency",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Enter Vehicle Details',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          const Text('Fill in both fields to calculate mileage'),
                          const SizedBox(height: 22),
                          TextFormField(
                            key: const Key('distanceField'),
                            controller: _distanceController,
                            keyboardType:
                                const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Distance Travelled',
                              suffixText: 'km',
                              prefixIcon: Icon(Icons.straighten),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => _validateNumber(v, 'distance'),
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            key: const Key('fuelField'),
                            controller: _fuelController,
                            keyboardType:
                                const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Fuel Consumed',
                              suffixText: 'litres',
                              prefixIcon: Icon(Icons.local_gas_station),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => _validateNumber(v, 'fuel'),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _calculateMileage,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Calculate Mileage'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _clearFields,
                    icon: const Icon(Icons.close),
                    label: const Text('Clear'),
                  ),
                ),
                if (_mileage != null) ...[
                  const SizedBox(height: 22),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF006B63), Color(0xFF1769C2)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        const Text('⛽', style: TextStyle(fontSize: 38)),
                        const SizedBox(height: 12),
                        const Text('YOUR CAR MILEAGE',
                            style: TextStyle(color: Colors.white70, letterSpacing: 2)),
                        Text(_mileage!.toStringAsFixed(2),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold)),
                        const Text('km/l',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const Divider(color: Colors.white38, height: 35),
                        Text('Distance: $_distanceUsed km',
                            style: const TextStyle(color: Colors.white)),
                        Text('Fuel Used: $_fuelUsed litres',
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 18),
                        Chip(
                          backgroundColor: _efficiencyColor,
                          label: Text(_efficiency,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
