import 'package:animate_gradient/animate_gradient.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/home_page.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  await OnAudioRoom().initRoom();
  runApp(MaterialApp(
    home: splash(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.black)),
  ));
}

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    permission();

    Future.delayed(Duration(seconds: 4)).then(
      (value) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return home_page();
          },
        ));
      },
    );
  }

  permission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> status = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.pink,
          Colors.pinkAccent,
          Colors.white,
        ],
        secondaryColors: const [
          Colors.white,
          Colors.blueAccent,
          Colors.blue,
        ],
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return const Scaffold();
              }));
            },
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText("MUSIC PLAYER",
                    textStyle: GoogleFonts.acme(fontSize: 40)),
                // WavyAnimatedText('Look at the waves'),
              ],
              isRepeatingAnimation: false,
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
      ),
    );
  }
}
