import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_message/share_message_use_case.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const platform = MethodChannel('com.flamyoad.sharemessage');

  late ShareMessageUseCase shareMessageUseCase;

  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    shareMessageUseCase = ShareMessageUseCaseImpl(platform);
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: textEditingController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Input your message here'
            ),
          ),
          ElevatedButton(
              onPressed: () {
                shareMessageUseCase.shareMessage(textEditingController.text);
              },
              child: const Text("Share"))
        ],
      ),
    );
  }
}
