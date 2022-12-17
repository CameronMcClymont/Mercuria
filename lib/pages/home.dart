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
  List<Voyage> voyageList = [
    Voyage('Destroyer', 'Cape Town, South Africa', 23, null, 5, null, DateTime.now().add(const Duration(days: 1))),
    Voyage('HMS Mercuria', 'Singapore', 6, null, 1, null, DateTime.now()),
  ];
  List<Cargo> cargoList = [
    Cargo(4, 'Cape Town, South Africa', DateTime.now().add(const Duration(days: 1))),
    Cargo(7, 'Cape Town, South Africa', DateTime.now().add(const Duration(days: 1))),
    Cargo(4, 'Mars', DateTime.now().add(const Duration(days: 2))),
    Cargo(3, 'Singapore', DateTime.now().add(const Duration(days: 4))),
    Cargo(2, 'Singapore', DateTime.now().add(const Duration(days: 4))),
    Cargo(3, 'Cape Town, South Africa', DateTime.now()),
    Cargo(32, 'Cape Town, South Africa', DateTime.now().add(const Duration(days: 4))),
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
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MatchPage(voyageList: voyageList, cargoList: cargoList)),
            );
          },
          tooltip: 'Match',
          child: const Icon(Icons.compare_arrows),
        ),
      ),
    );
  }
}
