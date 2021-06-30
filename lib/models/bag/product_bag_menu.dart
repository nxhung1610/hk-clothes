class BagMenuItems {
  static const List<BagMenuItem> listMenu = [itemDelete];

  static const itemDelete = BagMenuItem(
    text: "Delete",
    value: 1,
  );
}

class BagMenuItem {
  final String text;
  final int value;
  const BagMenuItem({this.value, this.text});
}
