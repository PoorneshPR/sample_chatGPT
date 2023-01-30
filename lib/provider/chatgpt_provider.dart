import 'package:flutter/cupertino.dart';
import 'package:samplechat_gpt/constants/Constants.dart';
import 'package:samplechat_gpt/message/chat_response.dart';
import 'package:samplechat_gpt/provider/providerhelperclass.dart';
import 'package:samplechat_gpt/services/serviceconfig.dart';

class ChatGPTProvider with ChangeNotifier, ProviderHelperClass {
  LoaderState? loader;
  ChatResponse? responseMessage;
  List<ChatResponse> messages = [];

   sendMessage({required String controllerText}) async {
    if (controllerText.isEmpty) return;
    ChatResponse message = ChatResponse(
      text: controllerText,
      name: "Poornesh",
      isAI: false,
    );
    messages.insert(0, message);
    updateLoaderState(LoaderState.loading);
    var response = await getChatGPTAPI(enteredString: controllerText);
    controllerText;
    print(response);
    ChatResponse responseMessageChat = ChatResponse(
      text: responseMessage?.text ?? "",
      name: "Result",
      isAI: true,
    );
    messages.insert(0, responseMessageChat);
    updateLoaderState(LoaderState.loaded);
    notifyListeners();
  }

  Future getChatGPTAPI({required String enteredString}) async {
    try {
      final dynamic response =
          await ServiceConfig.complete(prompt: enteredString);
      if (response != null && response.isNotEmpty) {
        responseMessage = ChatResponse(
          text: response ?? "",
          name: "Result",
          isAI: true,
        );
      } else {
        updateLoaderState(LoaderState.error);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  updateLoaderState(LoaderState loaderState) {
    loader = loaderState;
    notifyListeners();
  }
}
