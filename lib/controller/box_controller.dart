import 'package:chatgpt_reload_case/models/chat_group_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<ChatGroupModel> getChatGroup() =>
      Hive.box<ChatGroupModel>("chatGroupBox" ,);
}
