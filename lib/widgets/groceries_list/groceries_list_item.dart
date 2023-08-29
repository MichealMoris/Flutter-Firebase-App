import 'package:flutter/material.dart';

class GroceriesListItem extends StatelessWidget {
  final Color groceryColor;
  final String groceryName;
  final String groceryQuantity;

  const GroceriesListItem(
      {super.key,
      required this.groceryColor,
      required this.groceryName,
      required this.groceryQuantity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: groceryColor,
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
      ),
      title: Text(groceryName),
      trailing: Text(groceryQuantity),
    );
  }
}
