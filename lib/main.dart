import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _items = [];

  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void _addItem() {
    _items.insert(0, 'Item ${_items.length + 1}');
    _key.currentState!.insertItem(
      0,
      duration: const Duration(seconds: 1),
    );
  }

  void _removeItem(int index) {
    _key.currentState!.removeItem(
      index,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const Card(
            margin: EdgeInsets.all(10.0),
            elevation: 10,
            color: Colors.purple,
            child: ListTile(
              contentPadding: EdgeInsets.all(15.0),
              title: Text(
                "removing",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList'),
      ),
      body: AnimatedList(
          key: _key,
          itemBuilder: (context, index, animation) {
            //SizeTransition is used bec we want to change the size of the animated list
            return SizeTransition(
              sizeFactor: animation,
              key: UniqueKey(),
              child: Card(
                margin: EdgeInsets.all(10.0),
                elevation: 10,
                color: Colors.blue,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(
                    _items[index],
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _removeItem(index);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
