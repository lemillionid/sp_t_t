import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:sp_t_t/constant/const.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();
  var holdAndPush = "Hold and Speak";
  var isListening = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.sort_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "STT App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            color: Colors.white,
          )
        ],
        backgroundColor: bgColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Area Parsing Speech to Text

                //Text Hold and Speak
                const SizedBox(height: 10),
                Text(holdAndPush),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.amber,
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        holdAndPush = result.recognizedWords;
                      });
                    },
                  );
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 35,
            child: Icon(
              isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
              color: Colors.white,
              size: 35.0,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
