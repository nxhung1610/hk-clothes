class OrderMenuItems {
  static const List<OrderMenuItem> listMenu = [itemDone, itemDelete];

  static const itemDone = OrderMenuItem(
    text: "Done Order",
    value: 1,
  );

  static const itemDelete = OrderMenuItem(
    text: "Cancel Order",
    value: 2,
  );
}

class OrderMenuItem {
  final String text;
  final int value;
  const OrderMenuItem({this.value, this.text});
}
