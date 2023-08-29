import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/screens/add_new_item_screen.dart';
import 'package:shopping_app/widgets/groceries_list/groceries_list.dart';
import 'package:http/http.dart' as http;

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  List<GroceryItem> _groceriesItems = [];

  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  void _loadItems() async {
    final url = Uri.https(
        'flutter-prep-9a614-default-rtdb.firebaseio.com', 'shopping-list.json');
    final response = await http.get(url);
    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in decodedResponse.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.categoryName == item.value['category'])
          .value;
      loadedItems.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: category,
      ));
    }
    setState(() {
      _groceriesItems = loadedItems;
    });
  }

  void _addItem() async {
    final addedItem = await Navigator.of(context)
        .push<GroceryItem>(MaterialPageRoute(builder: (ctx) {
      return const AddNewItemScreen();
    }));

    if (addedItem == null) {
      return;
    }

    setState(() {
      _groceriesItems.add(addedItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceriesItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = _groceriesItems.isEmpty
        ? const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'No items added yet.',
                ),
              ],
            ),
          )
        : Column(
            children: [
              GroceriesList(
                groceries: _groceriesItems,
                onRemoveItem: _removeItem,
              ),
            ],
          );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
