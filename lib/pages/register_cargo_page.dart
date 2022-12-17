import 'package:challenge_3/model/cargo.dart';
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
  late TextEditingController destController;
  DateTime? dueDate;

  void _onConfirm() {
    double? width = double.tryParse(sizeController.text);
    if (width == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Width: "${sizeController.text}" is invalid.'), duration: const Duration(seconds: 2)));
      return;
    }

    double? weight = double.tryParse(weightController.text);
    if (weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Weight: "${weightController.text}" is invalid.'), duration: const Duration(seconds: 2)));
      return;
    }

    String dest = destController.text;

    if (dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('A due date must be selected.'), duration: Duration(seconds: 2)));
      return;
    }

    widget.onConfirm(Cargo(weight, dest, dueDate!));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    sizeController = TextEditingController();
    weightController = TextEditingController();
    destController = TextEditingController();
  }

  @override
  void dispose() {
    sizeController.dispose();
    weightController.dispose();
    destController.dispose();
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
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                autofocus: true,
                controller: sizeController,
                decoration: const InputDecoration(labelText: 'Size', hintText: '22.8 (meters)'),
              ),
              TextField(
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Cargo Weight', hintText: '1.1 (metric tons)'),
              ),
              TextField(
                controller: destController,
                decoration: const InputDecoration(labelText: 'Destination Port'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  dueDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );

                  setState(() {});
                },
                child: const Text('Pick Due Date'),
              ),
              const SizedBox(height: 8),
              Text(dueDate == null ? 'Due date: not picked' : 'Due date: ${dueDate!.year}-${dueDate!.month}-${dueDate!.day}'),
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
