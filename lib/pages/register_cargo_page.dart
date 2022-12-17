import 'package:challenge_3/cargo.dart';
import 'package:flutter/material.dart';

class RegisterCargoPage extends StatefulWidget {
  void Function(Cargo) onConfirm;

  RegisterCargoPage({Key? key, required this.onConfirm}) : super(key: key);

  @override
  State<RegisterCargoPage> createState() => _RegisterCargoPageState();
}

class _RegisterCargoPageState extends State<RegisterCargoPage> {
  late TextEditingController sizeController;
  late TextEditingController weightController;

  void _onConfirm() {
    double? size = double.tryParse(sizeController.text);
    if (size == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Size: "${sizeController.text}" is invalid.'), duration: const Duration(seconds: 2)));
      return;
    }

    double? weight = double.tryParse(weightController.text);
    if (weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Weight: "${weightController.text}" is invalid.'), duration: const Duration(seconds: 2)));
      return;
    }

    widget.onConfirm(Cargo(size, weight));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    sizeController = TextEditingController();
    weightController = TextEditingController();
  }

  @override
  void dispose() {
    sizeController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Cargo'),
        centerTitle: false,
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                autofocus: true,
                controller: weightController,
                textInputAction: TextInputAction.go,
                decoration: const InputDecoration(labelText: 'Cargo Size', hintText: '22.8 (cubic meters)'),
                onSubmitted: (_) {
                  _onConfirm();
                },
              ),
              TextField(
                controller: sizeController,
                textInputAction: TextInputAction.go,
                decoration: const InputDecoration(labelText: 'Cargo Weight', hintText: '1.1 (metric tons)'),
                onSubmitted: (_) {
                  _onConfirm();
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  _onConfirm();
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
