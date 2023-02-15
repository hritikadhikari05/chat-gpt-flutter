import 'dart:async';

import 'package:chat_gpt/chat_message.dart';
import 'package:chat_gpt/message_model.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  OpenAI? openAI;

  int count = 0;
  //Message input field controller
  final messageController = TextEditingController();

  late StreamSubscription subscription;

  //Array for storing messages
  RxList messages = [].obs;

  //Loading Chat Screen
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    // openAI = OpenAI.instance.build(
    //   token: "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",
    //   // baseOption: HttpSetup(receiveTimeout: 8000),
    //   isLogger: true,
    // );

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    messageController.dispose();
    // openAI?.close();
    super.onClose();
  }

  void increment(item) => messages.insert(0, item);
}
