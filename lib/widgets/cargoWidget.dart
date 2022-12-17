import 'package:challenge_3/model/cargo.dart';
import 'package:flutter/material.dart';

class CargoWidget extends StatefulWidget {
  final Cargo cargo;

  const CargoWidget({Key? key, required this.cargo}) : super(key: key);

  @override
  State<CargoWidget> createState() => _CargoWidgetState();
}

class _CargoWidgetState extends State<CargoWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.directions),
                const SizedBox(width: 4),
                Text('Destination: ${widget.cargo.destination}'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(width: 4),
                Text('Due date: ${widget.cargo.dueDate.year}-${widget.cargo.dueDate.month}-${widget.cargo.dueDate.day}'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.border_outer),
                const SizedBox(width: 4),
                Text('Weight: ${widget.cargo.weight}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
