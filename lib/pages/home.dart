import 'package:challenge_3/cargo.dart';
import 'package:challenge_3/cargo_list.dart';
import 'package:challenge_3/match_page.dart';
import 'package:challenge_3/voyage.dart';
import 'package:challenge_3/voyages_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Voyage> voyage_list = [];
  List<Cargo> cargo_list = [];

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: VoyagesList(
                    onConfirmVoyage: _onConfirmVoyage,
                    voyages: voyage_list,
                  ),
                ),
                Expanded(
                  child: CargoList(
                    onConfirmCargo: _onConfirmCargo,
                    cargo_list: cargo_list,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchPage(voyage_list: voyage_list, cargo_list: cargo_list)),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Match!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
