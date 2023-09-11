import 'package:chatgpt_reload_case/models/chat_model.dart';
import 'package:hive/hive.dart';
part 'chat_group_model.g.dart';
@HiveType(typeId: 1)
class ChatGroupModel {
  @HiveField(0) 
  final String id;
  @HiveField(1) 
  final List<ChatModel> chatList;

  ChatGroupModel({required this.id, required this.chatList});


}
