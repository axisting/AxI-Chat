// ignore_for_file: unused_local_variable

import 'package:chatgpt_reload_case/constants/api_consts.dart';
import 'package:chatgpt_reload_case/models/chat_group_model.dart';
import 'package:chatgpt_reload_case/models/chat_model.dart';
import 'package:chatgpt_reload_case/models/models_model.dart';
import 'package:chatgpt_reload_case/providers/models_provider.dart';
import 'package:chatgpt_reload_case/route_generator.dart';
import 'package:chatgpt_reload_case/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'constants/constants.dart';
import 'providers/chats_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Hive.initFlutter();
  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter(ChatGroupModelAdapter());
  Hive.registerAdapter(ModelsModelAdapter());
  Box<ChatModel> boxChat= await Hive.openBox('chatBox');
  // * Chat geçmişi telefonda tutulacağı için 
  Box<ChatGroupModel> boxGroup = await Hive.openBox('chatGroupBox',encryptionCipher: HiveAesCipher(HIVE_KEY));
  Box<ModelsModel> boxModels = await Hive.openBox('modelsBox');
  
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

// * Uygulama main - MyApp ile başlar
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // * Uygulama başlamasıyla birlikte splash ekranı kaldır
    FlutterNativeSplash.remove();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Reload.Case',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.routeGenerator,
        theme: ThemeData(
            fontFamily: 'SFPro',
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            appBarTheme: AppBarTheme(
              color: cardColor,
            )),
        home: const WelcomeScreen(), //const ChatScreen(),
      ),
    );
  }
}
