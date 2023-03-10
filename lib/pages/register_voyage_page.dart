import 'package:flutter/material.dart';

import '../model/voyage.dart';

class RegisterVoyagePage extends StatefulWidget {
  void Function(Voyage) onConfirm;

  RegisterVoyagePage({Key? key, required this.onConfirm}) : super(key: key);

  @override
  State<RegisterVoyagePage> createState() => _RegisterVoyagePageState();
}

class _RegisterVoyagePageState extends State<RegisterVoyagePage> {
  late TextEditingController nameController;
  late TextEditingController destController;
  late TextEditingController weightController;
  late TextEditingController spaceController;
  DateTime? arrivalDate;

  void _onConfirm() {
    String name = nameController.text;
    String dest = destController.text;

    double? weight = double.tryParse(weightController.text);
    if (weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Weight: "${weightController.text}" is invalid.'), duration: const Duration(seconds: 2)));
      return;
    }

    int? space = int.tryParse(spaceController.text);
    if (space == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Space: "${spaceController.text}" is invalid.'), duration: const Duration(seconds: 2)));
      return;
    }

    if (arrivalDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('A arrival date must be selected.'), duration: Duration(seconds: 2)));
      return;
    }

    widget.onConfirm(Voyage(name, dest, weight, null, space, null, arrivalDate!));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    destController = TextEditingController();
    weightController = TextEditingController();
    spaceController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    destController.dispose();
    weightController.dispose();
    spaceController.dispose();
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
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Vessel Name'),
              ),
              TextField(
                controller: destController,
                decoration: const InputDecoration(labelText: 'Voyage Destination'),
              ),
              TextField(
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Available Capacity (Weight)', hintText: '4.2 (metric tons)'),
              ),
              TextField(
                controller: spaceController,
                decoration: const InputDecoration(labelText: 'Available Capacity (Space)', hintText: '3 (units)'),
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
