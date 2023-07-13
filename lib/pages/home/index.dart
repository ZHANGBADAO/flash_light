import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _switchText = '打开';
  final torchController = TorchController();

  @override
  void initState() {
    super.initState();
    print('==============initState');
    print('==========ssssssssss====p==============');

    _checkFlashlight();
  }
  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('==========didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('==========deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('==========dispose');
  }

  //打开或关闭手电筒
  void _switchFlashlight() async {
    bool? active = await torchController.toggle();

    if (active == true) {
      setState(() {
        _switchText = '关闭';
      });
    } else {
      setState(() {
        _switchText = '打开';
      });
    }
  }

  //查看手电筒是否打开
  void _checkFlashlight() async {
    print('==========ssssssssss====$_switchText==============');

    bool? active = await torchController.isTorchActive;
    if (active == true) {
      setState(() {

        _switchText = '关闭';
      });
    } else {
      setState(() {
        _switchText = '打开';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: _switchText == '打开' ? const Icon(Icons.flashlight_on) : const Icon(Icons.flashlight_off),
              iconSize: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: _switchFlashlight,
            ),
            Text(
              '$_switchText手电筒',
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
            /*Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),*/
          ],
        ),
      ),
    );
  }
}
