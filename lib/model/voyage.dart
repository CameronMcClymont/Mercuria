class Voyage {
  final String vesselName;
  final String destination;
  final double weightCapacityBeforeExtraCargo;
  double? weightCapacityAfterExtraCargo;
  final int spaceCapacityBeforeExtraCargo;
  int? spaceCapacityAfterExtraCargo;
  final DateTime arrivalDate;

  Voyage(this.vesselName, this.destination, this.weightCapacityBeforeExtraCargo, this.weightCapacityAfterExtraCargo, this.spaceCapacityBeforeExtraCargo, this.spaceCapacityAfterExtraCargo, this.arrivalDate);

  Voyage.clone(Voyage voyage): this(voyage.vesselName, voyage.destination, voyage.weightCapacityBeforeExtraCargo, voyage.weightCapacityAfterExtraCargo, voyage.spaceCapacityBeforeExtraCargo, voyage.spaceCapacityAfterExtraCargo, voyage.arrivalDate);
}