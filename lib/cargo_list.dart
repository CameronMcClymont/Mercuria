import 'package:challenge_3/cargo.dart';
import 'package:challenge_3/pages/register_cargo_page.dart';
import 'package:challenge_3/pages/register_voyage_page.dart';
import 'package:flutter/material.dart';

class CargoList extends StatefulWidget {
  void Function(Cargo) onConfirmCargo;
  List<Cargo> cargo_list;

  CargoList({Key? key, required this.onConfirmCargo, required this.cargo_list}) : super(key: key);

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
            'Registered cargo:',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.cargo_list.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text('Size: ${widget.cargo_list[i].size}, weight: ${widget.cargo_list[i].weight}'),
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
