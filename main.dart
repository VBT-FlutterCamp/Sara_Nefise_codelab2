import 'items.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp1());
}

// #docregion MyApp
class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  // #docregion build
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Startup Name Generator',
      debugShowCheckedModeBanner: false,
      home: Codelab(),
    );
  }
}

class _CodelabState extends State<Codelab> {
  final _saved = <String>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    // Add lines from here...
                    MaterialPageRoute<void>(
                      builder: (context) {
                        final tiles = _saved.map(
                          (pair) {
                            return ListTile(
                              title: Text(
                                pair,
                                style: _biggerFont,
                              ),
                            );
                          },
                        );
                        final divided = tiles.isNotEmpty
                            ? ListTile.divideTiles(
                                context: context,
                                tiles: tiles,
                              ).toList()
                            : <Widget>[];

                        return Scaffold(
                          appBar: AppBar(
                            title: const Text('Saved Suggestions'),
                          ),
                          body: ListView(children: divided),
                        );
                      },
                    ), // ...to here.
                  );
                },
                child: const Icon(
                  Icons.list,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              items[index].Item_text,
              style: _biggerFont,
            ),
            trailing: Icon(
              items[index].Isclicked ? Icons.favorite : Icons.favorite_border,
              color: items[index].Isclicked ? Colors.red : null,
              semanticLabel:
                  items[index].Isclicked ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (items[index].Isclicked) {
                  _saved.remove(items[index].Item_text);
                  items[index].Isclicked = false;
                } else {
                  _saved.add(items[index].Item_text);

                  items[index].Isclicked = true;
                }
              });
            },
          );
        },
      ),
    );
  }
}

class Codelab extends StatefulWidget {
  const Codelab({Key? key}) : super(key: key);

  @override
  State<Codelab> createState() => _CodelabState();
}
