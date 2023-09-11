import 'package:chatgpt_reload_case/main.dart';
import 'package:chatgpt_reload_case/models/chat_group_model.dart';
import 'package:chatgpt_reload_case/screens/chat_screen.dart';
import 'package:chatgpt_reload_case/screens/error_screen.dart';
import 'package:chatgpt_reload_case/screens/saved_chats_screen.dart';
import 'package:chatgpt_reload_case/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  // * Geçişlerin animasyonları belirlenir
  static Route<dynamic>? createRoute(
      Widget selectedWidget, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => selectedWidget,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => selectedWidget,
      );
    } else {
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => selectedWidget,
      );
    }
  }

  // * Route işlemleri yapılır
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return createRoute(const MyApp(), settings);
      case '/welcome':
        return createRoute(const WelcomeScreen(), settings);
      case '/chat':
        ChatGroupModel? chatGroupModel = settings.arguments as ChatGroupModel?;
        return createRoute( ChatScreen(chatGroup: chatGroupModel), settings);
      case '/savedChats':
        return createRoute(const SavedChatsScreen(), settings);

    //  ! Yanlış yönlendirme olursa error sayfasına yönlendir
    // * Uygulama demo aşamasındayken error'a, yayınlanma aşamasında MyApp()'e yönlendirebiliriz.
      default:
        return createRoute(const ErrorScreen(), settings);
    }
  }
}
