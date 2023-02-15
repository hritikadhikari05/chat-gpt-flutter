class MessageModel {
  String? sender;
  String? reciever;
  String? message;

  MessageModel({this.sender, this.reciever, this.message});

  MessageModel.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    reciever = json['reciever'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender;
    data['reciever'] = this.reciever;
    data['message'] = this.message;
    return data;
  }
}
