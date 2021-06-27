class MenuItems {
  static const List<MenuItem> listMenu = [itemDelete];

  static const itemDelete = MenuItem(
    text: "Delete",
    value: 1,
  );
}

class MenuItem {
  final String text;
  final int value;
  const MenuItem({this.value, this.text});
}
