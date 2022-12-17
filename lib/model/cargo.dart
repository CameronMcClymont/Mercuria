class Cargo {
  final double weight;
  final String destination;
  final DateTime dueDate;

  Cargo(this.weight, this.destination, this.dueDate);

  Cargo.clone(Cargo cargo): this(cargo.weight, cargo.destination, cargo.dueDate);
}