import 'package:challenge_3/model/cargo.dart';
import 'package:challenge_3/cargo_list.dart';
import 'package:challenge_3/match_page.dart';
import 'package:challenge_3/model/voyage.dart';
import 'package:challenge_3/voyages_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Voyage> voyage_list = [Voyage('test', 123, null, DateTime.now())];
  List<Cargo> cargo_list = [Cargo(1, 'test', DateTime.now()), Cargo(2, 'test', DateTime.now())];

  void _onConfirmVoyage(Voyage voyage) {
    setState(() {
      voyage_list.add(voyage);
    });
  }

  void _onConfirmCargo(Cargo cargo) {
    setState(() {
      cargo_list.add(cargo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: VoyagesList(
                    onConfirmVoyage: _onConfirmVoyage,
                    voyageList: voyage_list,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CargoList(
                    onConfirmCargo: _onConfirmCargo,
                    cargoList: cargo_list,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MatchPage(voyageList: voyage_list, cargoList: cargo_list)),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Match!'),
            ),
          ),
        ],
      ),
    );
  }
}
