import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    // Get Range Numbers
    final items = [
      for (var i = _currentRangeValues.start; i <= _currentRangeValues.end; i++)
        i.toString()
    ];

    // content: container(context) <-- Pour afficher la range des chiffres les un apres les autres

    container(context) {
      return (Container(
        height: 300.0,
        width: 300.0,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
      ));
    }

    // Alternative en une seule ligne
    //content: Text(numbers().toString()),
    numbers() {
      return items.map((number) => number);
    }

    // dialog alert
    final AlertDialog dialog = AlertDialog(
      title: const Text('Résultat'),
      content: container(context),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('FERMER'),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Fizz Buzz"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.pink[600],
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
              print('Bonjour');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: const EdgeInsets.all(15),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Text(
                    "Choisissez un interval",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 100,
                    divisions: 25,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                          context: context, builder: (context) => dialog);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      //axe principale - horizontale plus petit possible
                      children: const [
                        Icon(Icons.format_list_numbered),
                        Text(
                          "Afficher les résultats",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
