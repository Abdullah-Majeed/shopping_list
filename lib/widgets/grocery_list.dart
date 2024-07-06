import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _grocertItemList = [];
  var isLoading = true;
  String? _error;
  // late Future<List<GroceryItem>> _loadedItems;
  //  Future<List<GroceryItem>> _loadItems() async
void _loadItems() async {
    final url = Uri.https(
        'groceries-390c4-default-rtdb.firebaseio.com', 'grocery-list.json');
    try {
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      setState(() {
        _error = "Failed to fetch data. please try again later.";
      });
      // throw Exception("Failed to fetch data, please try again later.");
    }

    if (response.body == 'null') {
      setState(() {
        isLoading = false;
      });
      // return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItemList = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItemList.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: category,
      ));
    }
    // return loadedItemList;
    setState(() {
      _grocertItemList = loadedItemList;
      isLoading = false;
    });
    } catch (error) {
      setState(() {
        _error = "Something went wrong, please try again.";
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.push<GroceryItem?>(
        context, MaterialPageRoute(builder: (ctx) => const NewItem()));
    if (newItem == null) {
      return;
    }
    setState(() {
      _grocertItemList.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final itemIndex = _grocertItemList.indexOf(item);
    setState(() {
      _grocertItemList.remove(item);
    });
    final url = Uri.https('groceries-390c4-default-rtdb.firebaseio.com',
        'grocery-list/${item.id}.json');
    final response = await http.delete(url);

    if (!context.mounted) {
      return;
    }
    if (response.statusCode >= 400) {
      setState(() {
        _grocertItemList.insert(itemIndex, item);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          'Failed to delete item. please try again.',
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text(
            'Item deleted.',
          ),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () async {
                setState(() {
                  _grocertItemList.insert(itemIndex, item);
                });
                final url = Uri.https(
                    'groceries-390c4-default-rtdb.firebaseio.com',
                    'grocery-list.json');
                await http.post(url,
                    headers: {
                      'Content-Type': 'application/json',
                    },
                    body: json.encode({
                      'name': item.name,
                      'quantity': item.quantity,
                      'category': item.category.title,
                    }));
              }),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
    // _loadedItems = _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
        child: Text(
      'No item found. Start adding some!',
      style: TextStyle(color: Colors.white),
    ));
    if (isLoading) {
      mainContent = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_error != null) {
      mainContent = Center(
          child: Text(
        _error!,
        style: const TextStyle(color: Colors.red),
      ));
    }
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
        body: mainContent,
        //  FutureBuilder(
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     if (snapshot.hasError) {
        //       return Center(
        //           child: Text(
        //         snapshot.error.toString(),
        //         style: const TextStyle(color: Colors.red),
        //       ));
        //     }
        //     if (snapshot.data!.isEmpty) {
        //       return const Center(
        //           child: Text(
        //         'No item found. Start adding some!',
        //         style: TextStyle(color: Colors.white),
        //       ));
        //     }
        //     return ListView.builder(
        //       itemCount: snapshot.data!.length,
        //       itemBuilder: (ctx, index) => Dismissible(
        //         key: ValueKey(snapshot.data![index]),
        //         background: Container(
        //           color: Theme.of(context).colorScheme.error.withOpacity(1.0),
        //           margin: Theme.of(context).cardTheme.margin,
        //         ),
        //         onDismissed: (direction) =>
        //             _removeItem(snapshot.data![index]),
        //         child: ListTile(
        //           title: Text(snapshot.data![index].name),
        //           leading: Container(
        //             width: 24,
        //             height: 24,
        //             color: snapshot.data![index].category.color,
        //           ),
        //           trailing: Text(snapshot.data![index].quantity.toString()),
        //         ),
        //       ),
        //     );
        //   },
        //   future: _loadedItems,
        // )
        );
  }
}
