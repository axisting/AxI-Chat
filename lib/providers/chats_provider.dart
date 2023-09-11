import 'package:chatgpt_reload_case/models/chat_group_model.dart';
import 'package:chatgpt_reload_case/repositories/chat_repository.dart';
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

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  setChatProvider(ChatGroupModel newChatGroup) {
    chatList = newChatGroup.chatList;
    chatGroup = newChatGroup;
    id = newChatGroup.id;
  }

  resetChatProvider() {
    chatList = [];
    chatGroup = null;
    id = "";
  }

  Future<void> createNewChatGroup() async {
    var uuid = const Uuid();
    id = uuid.v4();
    chatGroup = ChatGroupModel(id: id, chatList: chatList);
    chatGroupRepo.addChatGroup(
        chatGroup: ChatGroupModel(id: id, chatList: chatList));
  }

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
