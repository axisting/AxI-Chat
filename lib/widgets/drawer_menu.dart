import 'package:axi_chat/constants/constants.dart';
import 'package:axi_chat/providers/chats_provider.dart';
import 'package:axi_chat/services/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            accountName: const Text("Volkan Demir"),
            accountEmail: const Text("test@axisting.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              child: Image(image: AssetImage(AssetsManager.userImage)),
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              InkWell(
                onTap: () {
                  context.read<ChatProvider>().resetChatProvider();
                  //Navigator.pushNamed(context, "/");
                  // * Eğer bir sayfaya dönmek ve belirtilen sayfaya kadar tüm sayfaları kapatmak için istiyorsan aşağıdaki gibi yapabilirsin.
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                splashColor: Colors.blue.shade200,
                child: const ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  trailing: arrowForward,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.popUntil(context, (route) => false);
                },
                splashColor: Colors.blue.shade200,
                child: const ListTile(
                  leading: Icon(Icons.chat),
                  title: Text('Back to chat'),
                  trailing: arrowForward,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/savedChats");
                },
                splashColor: Colors.blue.shade200,
                child: const ListTile(
                  leading: Icon(Icons.save),
                  title: Text('Saved chats'),
                  trailing: arrowForward,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
