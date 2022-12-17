import 'package:challenge_3/model/cargo.dart';
import 'package:challenge_3/pages/register_cargo_page.dart';
import 'package:challenge_3/pages/register_voyage_page.dart';
import 'package:flutter/material.dart';

class CargoList extends StatefulWidget {
  void Function(Cargo) onConfirmCargo;
  List<Cargo> cargoList;

  CargoList({Key? key, required this.onConfirmCargo, required this.cargoList}) : super(key: key);

  @override
  State<CargoList> createState() => _CargoListState();
}

class _CargoListState extends State<CargoList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'Cargo to be shipped:',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.cargoList.length,
          itemBuilder: (context, i) {
            Cargo cargo = widget.cargoList[i];
            return ListTile(
              title: Text('Weight: ${cargo.weight} tonnes, destination: ${cargo.destination}, due date: ${cargo.dueDate.year}-${cargo.dueDate.month}-${cargo.dueDate.day}'),
              onTap: () {},
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterCargoPage(onConfirm: widget.onConfirmCargo)),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Register Cargo'),
            ),
          ),
        ),
      ],
    );
  }
}
