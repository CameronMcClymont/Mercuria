import 'package:flutter/material.dart';

import '../model/voyage.dart';

class RegisterVoyagePage extends StatefulWidget {
  void Function(Voyage) onConfirm;

  RegisterVoyagePage({Key? key, required this.onConfirm}) : super(key: key);

  @override
  State<RegisterVoyagePage> createState() => _RegisterVoyagePageState();
}

class _RegisterVoyagePageState extends State<RegisterVoyagePage> {
  late TextEditingController destController;
  late TextEditingController capacityController;
  DateTime? arrivalDate;

  void _onConfirm() {
    String dest = destController.text;

    double? capacity = double.tryParse(capacityController.text);
    if (capacity == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Value: "${capacityController.text}" is invalid.'), duration: const Duration(seconds: 2)));
      return;
    }

    if (arrivalDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('A arrival date must be selected.'), duration: Duration(seconds: 2)));
      return;
    }

    widget.onConfirm(Voyage(dest, capacity, null, arrivalDate!));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    destController = TextEditingController();
    capacityController = TextEditingController();
  }

  @override
  void dispose() {
    destController.dispose();
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
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                autofocus: true,
                controller: destController,
                decoration: const InputDecoration(labelText: 'Voyage Destination'),
              ),
              TextField(
                controller: capacityController,
                decoration: const InputDecoration(labelText: 'Available Cargo Capacity', hintText: '4.2 (metric tons)'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  arrivalDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );

                  setState(() {});
                },
                child: const Text('Pick Arrival Date'),
              ),
              const SizedBox(height: 8),
              Text(arrivalDate == null ? 'Arrival date: not picked' : 'Arrival date: ${arrivalDate!.year}-${arrivalDate!.month}-${arrivalDate!.day}'),
              const SizedBox(height: 8),
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
