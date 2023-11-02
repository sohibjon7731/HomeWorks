import 'dart:math';
import 'package:flutter/material.dart';

/* import 'package:flutter/material.dart'; */

void main() {
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<int> items = [0, 1, 2, 3, 4];

  int randomNumber=0;
  void getRandomInt(int min, int max) {
    final random = Random();
    int number = min + random.nextInt(max - min + 1);
    setState(() {
      randomNumber = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              getRandomInt(0, 4);
            });
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Random number: $randomNumber"),
        ),
        body: Container(
          height: 250,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                if (randomNumber == items[index]) {
                  return Dismissible(
                    key: Key("$item"),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete),
                    ),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      if (items.contains(randomNumber)) {
                        items.remove(randomNumber);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$item dismissed')),
                        );
                      } /* else {
                        print("Hello World");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Hello World"),),);
                      } */
                      print(items);
                    },
                    child: ListTile(
                      title: Text("Items: $item"),
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Items: $item",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
