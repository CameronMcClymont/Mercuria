import 'package:challenge_3/model/cargo.dart';
import 'package:challenge_3/model/voyage.dart';
import 'package:challenge_3/widgets/cargoWidget.dart';
import 'package:challenge_3/widgets/vesselWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MatchPage extends StatefulWidget {
  List<Voyage> voyageList;
  List<Cargo> cargoList;

  MatchPage({Key? key, required this.voyageList, required this.cargoList}) : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  int tempPage = 1;
  bool matched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Voyages and Cargo'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (_) {
            if (widget.voyageList.isEmpty) {
              return const Center(child: Text('No voyages yet.'));
            } else if (widget.cargoList.isEmpty) {
              return const Center(child: Text('No cargo yet.'));
            }

            if (matched) {
              List<Voyage> voyageList = List.of(widget.voyageList.map((voyage) => Voyage.clone(voyage))).toList();
              List<Cargo> cargoList = List.of(widget.cargoList.map((cargo) => Cargo.clone(cargo))).toList();

              Map<Voyage, List<Cargo>> cargoAssignments = {};

              for (Voyage voyage in voyageList) {
                List<Cargo> cargoToRemove = [];
                voyage.weightCapacityAfterExtraCargo = voyage.weightCapacityBeforeExtraCargo;
                voyage.spaceCapacityAfterExtraCargo = voyage.spaceCapacityBeforeExtraCargo;

                for (Cargo cargo in cargoList) {
                  bool destinationMatches = voyage.destination.toLowerCase() == cargo.destination.toLowerCase();
                  bool arrivesInTime = voyage.arrivalDate.isBefore(cargo.dueDate) || voyage.arrivalDate == cargo.dueDate;
                  bool sufficientWeightCapacity = voyage.weightCapacityAfterExtraCargo! >= cargo.weight;
                  bool sufficientSpaceCapacity = voyage.spaceCapacityAfterExtraCargo! >= 1;

                  if (destinationMatches && arrivesInTime && sufficientWeightCapacity && sufficientSpaceCapacity) {
                    // 'Load' the cargo
                    voyage.weightCapacityAfterExtraCargo = voyage.weightCapacityAfterExtraCargo! - cargo.weight;
                    voyage.spaceCapacityAfterExtraCargo = voyage.spaceCapacityAfterExtraCargo! - 1;
                    cargoToRemove.add(cargo);

                    // Assign it to this voyage
                    if (cargoAssignments.containsKey(voyage)) {
                      cargoAssignments[voyage]!.add(cargo);
                    } else {
                      cargoAssignments[voyage] = [cargo];
                    }
                  }
                }

                for (Cargo cargo in cargoToRemove) {
                  cargoList.remove(cargo);
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Unmatched Cargo',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Builder(
                    builder: (_) {
                      if (cargoList.isEmpty) {
                        return const Text('All cargo was matched!');
                      } else {
                        return MasonryGridView.count(
                          shrinkWrap: true,
                          itemCount: cargoList.length,
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          itemBuilder: (_, i) {
                            return CargoWidget(cargo: cargoList[i]);
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Upcoming Voyages',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  MasonryGridView.count(
                    shrinkWrap: true,
                    itemCount: cargoAssignments.entries.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 4,
                    itemBuilder: (_, i) {
                      List entries = cargoAssignments.entries.toList();
                      return VesselWidget(voyage: entries[i].key, cargoList: entries[i].value);
                    },
                  ),
                  const SizedBox(height: 16),
                  // FutureBuilder<http.Response>(
                  //   future: http.get(
                  //     Uri.parse('https://api.hackathon.mercuria-apps.com/api/ais-hourly/?page=$tempPage'),
                  //     headers: {
                  //       // Todo: security of API token
                  //       HttpHeaders.authorizationHeader: 'Token 9ca61ddaff632398f35fcaa19348fec9b3fbd449',
                  //     },
                  //   ),
                  //   builder: (_, AsyncSnapshot<http.Response> response) {
                  //     if (response.hasData) {
                  //       try {
                  //         final body = json.decode(response.data!.body);
                  //         return Text('Data (${body['results'].length} results, ${body["count"]}): ${body['results'][800]}');
                  //       } catch (e) {
                  //         return Text('Error: $e');
                  //       }
                  //     } else if (response.hasError) {
                  //       return Text('Error: ${response.error}');
                  //     } else {
                  //       return LoadingAnimationWidget.waveDots(
                  //         color: Theme.of(context).primaryColor,
                  //         size: 40,
                  //       );
                  //     }
                  //   },
                  // ),
                  // TextField(
                  //   autofocus: true,
                  //   textInputAction: TextInputAction.go,
                  //   decoration: const InputDecoration(labelText: 'Update page'),
                  //   onSubmitted: (String value) {
                  //     setState(() {
                  //       tempPage = int.parse(value);
                  //     });
                  //   },
                  // ),
                ],
              );
            } else {
              List<Voyage> voyageList = List.of(widget.voyageList.map((voyage) => Voyage.clone(voyage))).toList();
              List<Cargo> cargoList = List.of(widget.cargoList.map((cargo) => Cargo.clone(cargo))).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cargo to match',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  MasonryGridView.count(
                    shrinkWrap: true,
                    itemCount: cargoList.length,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder: (_, i) {
                      return CargoWidget(cargo: cargoList[i]);
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Upcoming Voyages',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  MasonryGridView.count(
                    shrinkWrap: true,
                    itemCount: voyageList.length,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder: (_, i) {
                      return VesselWidget(voyage: voyageList[i], cargoList: []);
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              matched = !matched;
            });
          },
          tooltip: matched ? 'Revert' : 'Match',
          child: matched ? const Icon(Icons.alt_route_rounded) : const Icon(Icons.compare_arrows),
        ),
      ),
    );
  }
}
