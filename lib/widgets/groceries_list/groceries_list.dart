import 'package:flutter/material.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/widgets/groceries_list/groceries_list_item.dart';

class GroceriesList extends StatelessWidget {
  final List<GroceryItem> groceries;
  final void Function(GroceryItem) onRemoveItem;
  const GroceriesList(
      {super.key, required this.groceries, required this.onRemoveItem});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: groceries.length,
          itemBuilder: (ctx, pos) => Dismissible(
                key: ValueKey(groceries[pos].id),
                child: GroceriesListItem(
                  groceryColor: groceries[pos].category.categoryColor,
                  groceryName: groceries[pos].name,
                  groceryQuantity: groceries[pos].quantity.toString(),
                ),
                onDismissed: (direction) {
                  onRemoveItem(groceries[pos]);
                },
              )),
    );
  }
}
