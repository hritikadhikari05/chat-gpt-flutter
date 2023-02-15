import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {super.key,
      required this.title,
      required this.message,
      required this.sender});
  final String title;
  final String message;
  final String sender;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            sender == "Bot" ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          CircleAvatar(
            child: Text("${sender == "Bot" ? "B" : "M"}"),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              // width: 150,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              // height: 20,
              decoration: BoxDecoration(
                  color: sender == "me"
                      ? Color.fromARGB(255, 236, 231, 231)
                      : Color(0xffe6e6e6),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(18))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$title",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("$message"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
