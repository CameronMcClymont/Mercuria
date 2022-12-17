import 'package:challenge_3/model/cargo.dart';
import 'package:challenge_3/model/voyage.dart';
import 'package:challenge_3/widgets/cargoWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class VesselWidget extends StatefulWidget {
  final Voyage voyage;
  final List<Cargo> cargoList;

  const VesselWidget({Key? key, required this.voyage, required this.cargoList}) : super(key: key);

  @override
  State<VesselWidget> createState() => _VesselWidgetState();
}

class _VesselWidgetState extends State<VesselWidget> {
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
                Text('Voyage destination: ${widget.voyage.destination}'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(width: 4),
                Text('Arriving on: ${widget.voyage.arrivalDate.year}-${widget.voyage.arrivalDate.month}-${widget.voyage.arrivalDate.day}'),
              ],
            ),
            if (widget.voyage.capacityAfterExtraCargo != null) Row(
              children: [
                const Icon(Icons.space_bar),
                const SizedBox(width: 4),
                Text('Capacity change: ${widget.voyage.capacityBeforeExtraCargo} -> ${widget.voyage.capacityAfterExtraCargo}'),
              ],
            ),
            MasonryGridView.count(
              shrinkWrap: true,
              itemCount: widget.cargoList.length,
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (_, j) {
                return CargoWidget(cargo: widget.cargoList[j]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
