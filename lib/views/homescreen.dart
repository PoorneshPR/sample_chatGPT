import 'package:flutter/material.dart';
import 'package:samplechat_gpt/views/chat_gptscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("ChatGPT")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatGptScreen(),
                    )),
                child: const Text("Chat GPT Screen")),
          )
        ],
      ),
    );
  }
}
