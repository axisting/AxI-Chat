import 'package:chatgpt_reload_case/constants/constants.dart';
import 'package:chatgpt_reload_case/controller/box_controller.dart';
import 'package:chatgpt_reload_case/models/chat_group_model.dart';
import 'package:chatgpt_reload_case/providers/chats_provider.dart';
import 'package:chatgpt_reload_case/repositories/chat_repository.dart';
import 'package:chatgpt_reload_case/widgets/subtitle_text_widget.dart';
import 'package:chatgpt_reload_case/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class SavedChatsScreen extends StatefulWidget {
  const SavedChatsScreen({super.key});

  @override
  State<SavedChatsScreen> createState() => _SavedChatsScreenState();
}

class _SavedChatsScreenState extends State<SavedChatsScreen> {
  late ChatGroupRepository chatGroupRepo;
  late List<ChatGroupModel> myChatGroupList;
  @override
  void initState() {
    chatGroupRepo = ChatGroupRepository();
    myChatGroupList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Saved Chats",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: bodySavedChat(context),
    );
  }

  Widget bodySavedChat(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Boxes.getChatGroup().listenable(),
        builder: (context, box, _) {
          final chatGroupList = box.values.toList().cast<ChatGroupModel>();
          myChatGroupList = chatGroupList.reversed.toList();
          return chatGroupListView(myChatGroupList, context);
        });
  }

  Widget chatGroupListView(
      List<ChatGroupModel> chatGroupList, BuildContext context) {
    return ListView.builder(
      itemBuilder: (buildContext, index) {
        return chatGroupListItem(chatGroupList, index, context);
      },
      itemCount: chatGroupList.length,
    );
  }

  Widget chatGroupListItem(
      List<ChatGroupModel> chatGroupList, int index, BuildContext context) {
    //myChatGroupList = chatGroupList;
    ChatGroupModel currentChatGroupModel = myChatGroupList[index];
    return Dismissible(
      key: ValueKey<int>(index),
      direction: DismissDirection.endToStart,
      
      onDismissed: (DismissDirection direction) {
        setState(() {
          chatGroupRepo.deleteChatGroup(id: currentChatGroupModel.id);
          context.read<ChatProvider>().resetChatProvider();
          myChatGroupList.removeAt(index);
        });
      },
      background: Container(
        color: Colors.grey,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: TextWidget(
              label: "Siliniyor",
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        //borderOnForeground: true,
        elevation: 4,
        child: ListTile(
          onTap: () {
            context.read<ChatProvider>().resetChatProvider();
            Navigator.pushNamed(context, "/chat",
                arguments: currentChatGroupModel);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          tileColor: cardColor,
          //leading: const CircleAvatar(child: Icon(Icons.person)),
          title: TextWidget(
            label: currentChatGroupModel.chatList.first.msg,
          ), // chatGroupList[index].chatList.first.msg
          subtitle: SubtitleTextWidget(
            label: currentChatGroupModel.chatList.length > 1
                ? currentChatGroupModel.chatList[1].msg
                : "No message",
          ),
        ),
      ),
    );
  }
}
