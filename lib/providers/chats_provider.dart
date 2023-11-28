import 'package:axi_chat/models/chat_group_model.dart';
import 'package:axi_chat/repositories/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_model.dart';
import '../services/api_service.dart';

class ChatProvider with ChangeNotifier {
  ChatGroupRepository chatGroupRepo = ChatGroupRepository();
  ChatGroupModel? chatGroup;
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  String id = "";
  // * User'dan gelen mesajı alır ve ona index Atar. API için sınıf formatına getirir
  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  // * Providerdaki tüm değişkenleri setler
  setChatProvider(ChatGroupModel newChatGroup) {
    chatList = newChatGroup.chatList;
    chatGroup = newChatGroup;
    id = newChatGroup.id;
  }

  // * Providerdaki tüm değişkenleri resetler
  resetChatProvider() {
    chatList = [];
    chatGroup = null;
    id = "";
  }
  // * Hive veritabanı için chatGroupu oluşturur.
  Future<void> createNewChatGroup() async {
    var uuid = const Uuid();
    id = uuid.v4();
    chatGroup = ChatGroupModel(id: id, chatList: chatList);
    chatGroupRepo.addChatGroup(
        chatGroup: ChatGroupModel(id: id, chatList: chatList));
  }
  // * Hive veritabanı için chatGroupu günceller
  updateNewChatGroup() {
    chatGroup = ChatGroupModel(id: id, chatList: chatList);
    chatGroupRepo.updateChatGroup(
        chatGroup: ChatGroupModel(id: id, chatList: chatList));
  }
/*
  void addMessageList({
    required String role,
    required String msg,
  }) {
    messageList.add(MessageModel(role: role, content: msg));
    notifyListeners();
  }
  */
  // * ChatGPT api için msj gönderimini ve getirimini kontrol eder.
  Future<void> sendMessageAndGetAnswers({
    required String msg,
    required String chosenModelId,
  }) async {
    if (chosenModelId.toLowerCase().startsWith("gpt")) {
      chatList.addAll(await ApiService.sendMessageGPT(
        message: msg,
        modelId: chosenModelId,
      ));
    } else {
      chatList.addAll(await ApiService.sendMessage(
        message: msg,
        modelId: chosenModelId,
      ));
    }
    // * ChatList'in durumuna göre yeni bir chatGroup açılıp açılmayacağına karar verir ve işlem yapar.
    if (chatList.isNotEmpty) {
      if (chatList.length == 2) {
        if (id == "") {
          await createNewChatGroup();
        }
      } else if (chatList.length > 2) {
        await updateNewChatGroup();
      }
    }

    notifyListeners();
  }
}
