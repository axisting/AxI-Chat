import 'package:chatgpt_reload_case/models/chat_group_model.dart';
import 'package:hive/hive.dart';

// * Hive Box'ların getirme işlemi. 
class Boxes {
  // * Hive üzerinde şuanlık sadece chatGroupBox üzerinde işlem yapıyoruz
  static Box<ChatGroupModel> getChatGroup() =>
      Hive.box<ChatGroupModel>("chatGroupBox" ,);
}
