import 'package:flutter/material.dart';

class ChatResponse extends StatelessWidget {
  const ChatResponse(
      {super.key, required this.text, required this.name, required this.isAI});

  final String text;
  final String name;
  final bool isAI;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isAI
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        name,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        text,
                        style: TextStyle(
                            fontStyle:
                                isAI ? FontStyle.italic : FontStyle.normal,
                            fontSize: isAI ? 16 : 18,
                            fontWeight:
                                isAI ? FontWeight.w500 : FontWeight.w700),
                      ),
                    ],
                  ),
                )
              : CircleAvatar(
                  child: Text(name[0]),
                  backgroundColor: isAI ? Colors.green : Colors.blue),
          const SizedBox(
            width: 10,
          ),
          isAI
              ? CircleAvatar(
                  child: Text(name[0]),
                  backgroundColor: isAI ? Colors.green : Colors.blue)
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        name,
                        style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        text,
                        style: TextStyle(
                            fontStyle:
                                isAI ? FontStyle.italic : FontStyle.normal,
                            fontSize: isAI ? 16 : 18,
                            fontWeight:
                                isAI ? FontWeight.w500 : FontWeight.w700),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
