import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:chat_gpt/chat-screen-controller.dart';
import 'package:chat_gpt/chat_message.dart';
import 'package:chat_gpt/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends GetView<ChatScreenController> {
  final ChatScreenController _chatScreenController =
      Get.put(ChatScreenController());

  @override
  Widget build(BuildContext context) {
    // final message = controller.messageController.text;

    //Onclick function
    onSumbit(String message) async {
      controller.isLoading.value = true;

      controller.messages.add(
        MessageModel(
          sender: "me",
          reciever: "User",
          message: message,
        ),
      );
      controller.messageController.clear();

      var response = await http.post(
        Uri.https("api.openai.com", "/v1/completions"),
        headers: {
          "Authorization": "Bearer Place your key here",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "prompt": message,
          "max_tokens": 2000,
          "model": "text-davinci-003",
        }),
      );
      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        controller.isLoading.value = false;
        controller.messages.add(
          MessageModel(
            sender: "Bot",
            reciever: "User",
            message: "${jsonResponse["choices"][0]["text"]}",
          ),
        );
      } else {
        controller.isLoading.value = false;
        Get.snackbar("Error", "Somthing went wrong");
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat GPT / Chat Bot'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Flexible(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Obx(
                  () => ListView.builder(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    reverse: false,
                    itemBuilder: (context, index) {
                      log("Log: ${controller.messages[0].sender}");
                      return ChatMessage(
                        sender: "${controller.messages[index].sender}",
                        title: "${controller.messages[index].sender}",
                        message: "${controller.messages[index].message}",
                      );
                    },
                    itemCount: controller.messages.length,
                  ),
                ),
              )),
              Obx(
                () => controller.isLoading.value == true
                    ? Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 60,
                          height: 30,
                          margin: const EdgeInsets.only(bottom: 10, left: 20),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12)),
                          ),
                          child: Center(
                            child: LoadingAnimationWidget.waveDots(
                                color: Colors.black, size: 30),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: TextField(
                          controller: controller.messageController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            hintText: 'Ask me anything',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () => onSumbit(controller.messageController.text),
                      child: Icon(Icons.send_rounded),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

//  onSumbit() {
//       controller.isLoading = true;
//       controller.increment(ChatMessage(
//         title: "user",
//         message: "${_chatScreenController.messageController.text}",
//         sender: "me",
//       ));
//       final request = CompleteText(
//         prompt: _chatScreenController.messageController.text.toString(),
//         model: kTranslateModelV3,
//         maxTokens: 200,
//       );

//       controller.openAI!.onCompleteStream(request: request).listen((response) {
//         return controller.messages.insert(
//             response!.choices[0].index.toInt(),
//             ChatMessage(
//               title: "Bot",
//               message: "${response?.choices[0].text}",
//               sender: "Bot",
//             ));
//       }).onError((err) {
//         print("$err");
//         Get.snackbar("Error", "TimeOut", backgroundColor: Colors.red);
//       });
//       _chatScreenController.messageController.clear();
//     }
