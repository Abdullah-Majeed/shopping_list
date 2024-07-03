import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _grocertItemList = [];
  void _addItem() async {
    final newItem = await Navigator.push<GroceryItem?>(
        context, MaterialPageRoute(builder: (ctx) => const NewItem()));
    print(newItem);
    if (newItem == null) {
      return;
    }
    setState(() {
      _grocertItemList.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    final itemIndex = _grocertItemList.indexOf(item);
    setState(() {
      _grocertItemList.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text(
          'Item deleted.',
        ),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _grocertItemList.insert(itemIndex, item);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
        child: Text(
      'No item found. Start adding some!',
      style: TextStyle(color: Colors.white),
    ));

    if (_grocertItemList.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: _grocertItemList.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_grocertItemList[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(1.0),
            margin: Theme.of(context).cardTheme.margin,
          ),
          onDismissed: (direction) => _removeItem(_grocertItemList[index]),
          child: ListTile(
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
        body: mainContent);
  }
}
