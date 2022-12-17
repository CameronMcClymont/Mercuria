import 'package:flutter/material.dart';

import '../voyage.dart';

class RegisterVoyagePage extends StatefulWidget {
  void Function(Voyage) onConfirm;

  RegisterVoyagePage({Key? key, required this.onConfirm}) : super(key: key);

  @override
  State<RegisterVoyagePage> createState() => _RegisterVoyagePageState();
}

class _RegisterVoyagePageState extends State<RegisterVoyagePage> {
  late TextEditingController capacityController;

  void _onConfirm() {
    double? capacity = double.tryParse(capacityController.text);
    if (capacity == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Value: "${capacityController.text}" is invalid.'), duration: const Duration(seconds: 2)));
      return;
    }

    widget.onConfirm(Voyage(capacity));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    capacityController = TextEditingController();
  }

  @override
  void dispose() {
    capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Voyage'),
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
                controller: capacityController,
                textInputAction: TextInputAction.go,
                decoration: const InputDecoration(labelText: 'Available Cargo Capacity', hintText: '4.2 (metric tons)'),
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
