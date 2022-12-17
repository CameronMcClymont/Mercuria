import 'package:challenge_3/model/voyage.dart';
import 'package:challenge_3/pages/register_voyage_page.dart';
import 'package:flutter/material.dart';

class VoyagesList extends StatefulWidget {
  void Function(Voyage) onConfirmVoyage;
  List<Voyage> voyageList;

  VoyagesList({Key? key, required this.voyageList, required this.onConfirmVoyage}) : super(key: key);

  @override
  State<VoyagesList> createState() => _VoyagesListState();
}

class _VoyagesListState extends State<VoyagesList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'Upcoming voyages:',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.voyageList.length,
          itemBuilder: (context, i) {
            Voyage voyage = widget.voyageList[i];
            return ListTile(
              title: Text('Destination: ${voyage.destination}, capacity (weight): ${voyage.weightCapacityBeforeExtraCargo} tonnes, arrival date: ${voyage.arrivalDate.year}-${voyage.arrivalDate.month}-${voyage.arrivalDate.day}'),
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
                MaterialPageRoute(builder: (context) => RegisterVoyagePage(onConfirm: widget.onConfirmVoyage)),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Register Voyage'),
            ),
          ),
        ),
      ],
    );
  }
}
