class Voyage {
  final String destination;
  final double capacityBeforeExtraCargo;
  double? capacityAfterExtraCargo;
  final DateTime arrivalDate;

  Voyage(this.destination, this.capacityBeforeExtraCargo, this.capacityAfterExtraCargo, this.arrivalDate);

  Voyage.clone(Voyage voyage): this(voyage.destination, voyage.capacityBeforeExtraCargo, voyage.capacityAfterExtraCargo, voyage.arrivalDate);
}