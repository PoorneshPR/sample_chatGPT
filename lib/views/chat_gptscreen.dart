import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:samplechat_gpt/constants/Constants.dart';
import 'package:samplechat_gpt/message/chat_response.dart';
import 'package:samplechat_gpt/provider/chatgpt_provider.dart';

class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({Key? key}) : super(key: key);

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  final TextEditingController _controller = TextEditingController();
  StreamSubscription? subscription;

  Widget _buildTextComposer({required ChatGPTProvider chatGPTProvider}) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) async {
                FocusScope.of(context).unfocus();
              await chatGPTProvider.sendMessage(
                  controllerText: _controller.text);
            if(mounted)  FocusScope.of(context).unfocus();
              _controller.clear();
            },
            decoration: const InputDecoration.collapsed(
                hintText: "Generate your responses"),
          ),
        ),
        ButtonBar(
          children: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () async {
              FocusScope.of(context).unfocus();
                await chatGPTProvider.sendMessage(
                    controllerText: _controller.text);

                _controller.clear();
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageInit();
    });
    super.initState();
  }

  pageInit() async {
    context.read<ChatGPTProvider>().messages = [];
  }

  @override
  void dispose() {
    subscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Chat GPT")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: Consumer<ChatGPTProvider>(builder: (context, model, _) {
          switch (model.loader) {
            case LoaderState.initial:
              {
                return Column(children: [
                  _buildTextComposer(chatGPTProvider: model),
                  const Center(
                      child: Text(
                    "Welcome To ChatGPT",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  ))
                ]);
              }
            case LoaderState.loading:
              {
                return Column(children: [
                  _buildTextComposer(chatGPTProvider: model),
                  const Center(
                      child: SpinKitRotatingCircle(
                    color: Colors.red,
                    size: 50.0,
                  ))
                ]);
              }

            case LoaderState.loaded:
              {
                return Column(children: [
                  _buildTextComposer(chatGPTProvider: model),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: ListView.builder(
                        itemCount: model.messages.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => model.messages[index],
                      ),
                    ),
                  )
                ]);
              }
            case LoaderState.error:
              {
                return Column(children: [
                  _buildTextComposer(chatGPTProvider: model),
                  const Center(child: Text("Error"))
                ]);
              }

            default:
              {
                return Column(children: [
                  _buildTextComposer(chatGPTProvider: model),
                  Expanded(
                    child: model.messages.isEmpty
                        ? const Center(
                            child: Text(
                            "Welcome To ChatGPT",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue),
                          ))
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.40,
                            child: ListView.builder(
                              itemCount: model.messages.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  model.messages[index],
                            ),
                          ),
                  )
                ]);
              }

            // Column(
            //         children: [
            //           _buildTextComposer(chatGPTProvider: model),
            //
            //           model.loader == LoaderState.loading
            //               ?  const Center(
            //           child: SpinKitRotatingCircle(
            //           color: Colors.red,
            //           size: 50.0,
            //           ))
            //               : model.loader == LoaderState.loaded
            //               ?
            //           Expanded(
            //             child: SizedBox(height: MediaQuery.of(context).size.height*0.40,
            //               child: ListView.builder(
            //                 itemCount: model.messages.length,
            //                 shrinkWrap: true,
            //                 itemBuilder: (context, index) => model.messages[index],
            //               ),
            //             ),
            //           )
            //
            //           :model.loader == LoaderState.initial?
            //           Center():const Center(
            //               child:
            //             )
            //         ],
            //       );
          }
        }),
      ),
    );
  }
}
