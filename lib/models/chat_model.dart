import 'package:hive/hive.dart';
part 'chat_model.g.dart';
@HiveType(typeId: 0)
class ChatModel {
  @HiveField(0)
  final String msg;
  @HiveField(1)
  final int chatIndex;

  ChatModel({required this.msg, required this.chatIndex});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json["msg"],
        chatIndex: json["chatIndex"],
      );


}
