/*

We’ve trained a model called ChatGPT which interacts in a conversational way.

*/

import 'package:chatgpt_reload_case/services/assets_manager.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Image.asset(
              AssetsManager.smallLogo,
              height: 14,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage(AssetsManager.background),
                    alignment: Alignment.bottomCenter)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: Image.asset(
                  AssetsManager.aichatbot,
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "We’ve trained a model called ChatGPT \nwhich interacts in a conversational way.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(
                height: 128,
              ),
            ]),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                    tileColor: Colors.white,
                    title: TextButton(
                      style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black),
                      onPressed: () {
                        Navigator.pushNamed(context, '/chat');
                      },
                      child: const Text('Continue'),
                    )),
              )),
        ],
      ),
    );
  }
}
