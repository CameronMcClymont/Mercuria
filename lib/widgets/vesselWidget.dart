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
            Text(
              widget.voyage.vesselName,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 6),
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
            if (widget.voyage.weightCapacityAfterExtraCargo != null)
              Row(
                children: [
                  const Icon(Icons.border_outer),
                  const SizedBox(width: 4),
                  Text('Capacity change (weight): ${widget.voyage.weightCapacityBeforeExtraCargo} -> ${widget.voyage.weightCapacityAfterExtraCargo}'),
                ],
              ),
            if (widget.voyage.spaceCapacityAfterExtraCargo != null)
              Row(
                children: [
                  const Icon(Icons.space_bar),
                  const SizedBox(width: 4),
                  Text('Capacity change (space): ${widget.voyage.spaceCapacityBeforeExtraCargo} -> ${widget.voyage.spaceCapacityAfterExtraCargo}'),
                ],
              ),
            const SizedBox(height: 12),
            const Text(
              'Extra Cargo',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Builder(
              builder: (_) {
                if (widget.cargoList.isEmpty) {
                  return const Text('No extra cargo');
                } else {
                  return MasonryGridView.count(
                    shrinkWrap: true,
                    itemCount: widget.cargoList.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder: (_, j) {
                      return CargoWidget(cargo: widget.cargoList[j]);
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
