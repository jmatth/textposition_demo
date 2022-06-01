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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
  late final TextEditingController _controller;
  late final FocusNode _textFocusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'abcdefghijklmnopqrstuvwxyz');
    _controller.selection = const TextSelection.collapsed(
      offset: 3,
      affinity: TextAffinity.upstream,
    );
    _controller.addListener(_onControllerChange);
    _textFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textFocusNode.requestFocus();
    });
  }

  void _onControllerChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120,
                child: TextField(
                  minLines: 2,
                  maxLines: 2,
                  controller: _controller,
                  focusNode: _textFocusNode,
                  textAlign: TextAlign.center,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
              ),
              Row(
                children: [
                  DropdownButton<int>(
                    value: _controller.selection.extent.offset,
                    items: List.generate(
                      _controller.text.length + 1,
                      (index) => DropdownMenuItem(
                        value: index,
                        child: Text('$index'),
                      ),
                    ),
                    onChanged: (offset) {
                      setState(() {
                        _controller.selection = _controller.selection.copyWith(
                          baseOffset: offset,
                          extentOffset: offset,
                        );
                      });
                      _textFocusNode.requestFocus();
                    },
                  ),
                  const Spacer(),
                  DropdownButton<TextAffinity>(
                    value: _controller.selection.extent.affinity,
                    items: TextAffinity.values
                        .map(
                          (affinity) => DropdownMenuItem<TextAffinity>(
                            value: affinity,
                            child: Text('$affinity'),
                          ),
                        )
                        .toList(),
                    onChanged: (affinity) {
                      setState(() {
                        _controller.selection =
                            _controller.selection.copyWith(affinity: affinity);
                        _textFocusNode.requestFocus();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
