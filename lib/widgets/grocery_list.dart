import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _grocertItemList = [];
  void _addItem() async {
    final newItem = await Navigator.push<GroceryItem>(
        context, MaterialPageRoute(builder: (ctx) => const NewItem()));
    if (newItem != null) {
      setState(() {
        _grocertItemList = [..._grocertItemList, newItem];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries '),
        actions: [
          IconButton(
            onPressed: () {
              _addItem();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _grocertItemList.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(_grocertItemList[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: _grocertItemList[index].category.color,
          ),
          trailing: Text(_grocertItemList[index].quantity.toString()),
        ),
      ),
    );
  }
}
