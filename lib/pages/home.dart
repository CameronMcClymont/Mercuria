import 'package:challenge_3/cargo_list.dart';
import 'package:challenge_3/match_page.dart';
import 'package:challenge_3/model/cargo.dart';
import 'package:challenge_3/model/voyage.dart';
import 'package:challenge_3/voyages_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Voyage> voyageList = [Voyage('Hunter', 'Cape Town, South Africa', 23, null, DateTime.now())];
  List<Cargo> cargoList = [
    Cargo(4, 'Cape Town, South Africa', DateTime.now()),
    Cargo(7, 'Cape Town, South Africa', DateTime.now()),
    Cargo(2, 'Singapore', DateTime.now().add(const Duration(days: 2))),
  ];

  void _onConfirmVoyage(Voyage voyage) {
    setState(() {
      voyageList.add(voyage);
    });
  }

  void _onConfirmCargo(Cargo cargo) {
    setState(() {
      cargoList.add(cargo);
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
                    voyageList: voyageList,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CargoList(
                    onConfirmCargo: _onConfirmCargo,
                    cargoList: cargoList,
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
                MaterialPageRoute(builder: (context) => MatchPage(voyageList: voyageList, cargoList: cargoList)),
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
