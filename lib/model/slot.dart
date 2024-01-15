class Slot {
  final int index;
  final bool available;
  final bool selected;
  final dynamic id;

  const Slot({
    required this.id,
    required this.index,
    required this.available,
    required this.selected,
  });
}
