// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chatgpt_reload_case/constants/constants.dart';
import 'package:chatgpt_reload_case/models/chat_group_model.dart';
import 'package:chatgpt_reload_case/providers/chats_provider.dart';

import 'package:chatgpt_reload_case/widgets/chat_widget.dart';
import 'package:chatgpt_reload_case/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../providers/models_provider.dart';
import '../widgets/text_widget.dart';

class ChatScreen extends StatefulWidget {
  final ChatGroupModel? chatGroup;
  const ChatScreen({super.key, this.chatGroup});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  ChatGroupModel? currentChatGroup;
  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();

    currentChatGroup = widget.chatGroup;

    focusNode.addListener(() {
      setState(() {});
    });
    setup();
    super.initState();
  }

  Future<void> setup() async {
    if (currentChatGroup == null) {
      context.read<ChatProvider>().resetChatProvider();
    } else {
      context.read<ChatProvider>().setChatProvider(currentChatGroup!);
    }
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        elevation: 2,
        title: const Text("ChatBot",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  controller: _listScrollController,
                  itemCount: chatProvider.getChatList.length, //chatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatProvider
                          .getChatList[index].msg, // chatList[index].msg,
                      chatIndex: chatProvider.getChatList[index]
                          .chatIndex, //chatList[index].chatIndex,
                      shouldAnimate:
                          chatProvider.getChatList.length - 1 == index,
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                tileColor: cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(
                        color: focusNode.hasFocus ? Colors.cyan : cardColor)),
                title: TextField(
                  focusNode: focusNode,
                  style: const TextStyle(color: Colors.white),
                  controller: textEditingController,
                  onSubmitted: (value) async {
                    await sendMessageFCT(
                        modelsProvider: modelsProvider,
                        chatProvider: chatProvider);
                  },
                  decoration: const InputDecoration.collapsed(
                      hintText: "Message",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
                trailing: IconButton(
                  //color: Colors.white,
                  onPressed: () async {
                    await sendMessageFCT(
                        modelsProvider: modelsProvider,
                        chatProvider: chatProvider);
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: focusNode.hasFocus ? Colors.cyan : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You cant send multiple messages at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;

        chatProvider.addUserMessage(msg: msg);
        //chatProvider.addMessageList(role: "user", msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
          msg: msg, chosenModelId: modelsProvider.getCurrentModel);

      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
