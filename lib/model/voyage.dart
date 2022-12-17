class Voyage {
  final String vesselName;
  final String destination;
  final double capacityBeforeExtraCargo;
  double? capacityAfterExtraCargo;
  final DateTime arrivalDate;

  Voyage(this.vesselName, this.destination, this.capacityBeforeExtraCargo, this.capacityAfterExtraCargo, this.arrivalDate);

  Voyage.clone(Voyage voyage): this(voyage.vesselName, voyage.destination, voyage.capacityBeforeExtraCargo, voyage.capacityAfterExtraCargo, voyage.arrivalDate);
}