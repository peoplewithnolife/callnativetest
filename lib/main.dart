import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _lastPress = "None";

  static const platform = MethodChannel('samples.flutter.dev/testola');
  static const platformTwo = MethodChannel('samples.flutter.dev/testolatwo');

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _button1() async {
    String resultString;
    try {
      final int result = await platform.invokeMethod('getChannelOne');
      resultString = 'channel 1 $result';
    } on PlatformException catch (e) {
      resultString = 'error ${e.message}';
    }
    setState(() {
      _lastPress = resultString;
    });
  }

  void _button2() async {
    String resultString;
    try {
      final String result = await platformTwo.invokeMethod('getChannelTwo');
      resultString = 'c2 $result';
    } on PlatformException catch (e) {
      resultString = 'error ${e.message}';
    }
    setState(() {
      _lastPress = resultString;
    });
    setState(() {
      _lastPress = resultString;
    });
  }

  void _button3() {
    setState(() {
      _lastPress = "Button Three";
    });
  }

  void _button4() {
    setState(() {
      _lastPress = "Button Four";
    });
  }

  void _button5() {
    setState(() {
      _lastPress = "Button Five";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _button1();
                  },
                  child: const Text('phil sux'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _button2();
                  },
                  child: const Text('phil sux'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _button3();
                  },
                  child: const Text('phil sux'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _button4();
                  },
                  child: const Text('phil sux'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _button5();
                  },
                  child: const Text('phil sux'),
                ),
                ElevatedButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('AlertDialog Title'),
                      content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('phil sux'),
                ),
              ],
            ),
            Text(
              _lastPress,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
