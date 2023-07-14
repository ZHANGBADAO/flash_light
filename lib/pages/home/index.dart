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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String _switchText = '打开';
  final torchController = TorchController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _switchFlashlight();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    debugPrint('=================state = $state');
  }

  //打开或关闭手电筒
  void _switchFlashlight() async {
    bool? active = await torchController.toggle();

    setState(() {
      _switchText = active == true ? '关闭' : '打开';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // 处理回退逻辑
          // 返回false会阻止回退
          //手电筒打开时，点击返回键，关闭手电筒
          if (_switchText == '关闭') _switchFlashlight();
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black54,
          appBar: AppBar(
            // TRY THIS: Try changing the color here to a specific color (to
            // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            // change color while the other colors stay the same.
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Center(
              child: Text(
                widget.title,
              ),
            ),
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
                    color: Colors.amber,
                  ),
                ),
                /*Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),*/
              ],
            ),
          ),
        )
    );
  }
}
