import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_1/HomeScreen.dart';
import 'package:test_1/SongArguments.dart';
import 'package:test_1/main.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({Key? key}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  popPage() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {});
    timer.cancel();
    player.stop();
    Navigator.pop(context);
  }

  changeSliderValue(double value) {
    setState(() {
      currentPosition = value.floor().toDouble();
    });
    if (isPlay == true) {
      timer.cancel();

      player.pause();
      player.seek(Duration(seconds: currentPosition.toInt()));
      playMusic(x.name, x.title);
    } else if (isPlay == false) {
      player.seek(Duration(seconds: currentPosition.toInt()));
    }
  }

  bool isPlay = false;
  AudioPlayer player = AudioPlayer();
  String duration = "";
  String d = "";
  late Timer timer;

  double currentPosition = 0;

  playMusic(String name, String title) {
    setState(() {
      isPlay = true;
    });
    player.play();
    print("play/resume");

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (d == currentPosition.floor().toString()) {
          setState(() {
            print(currentPosition);
            isPlay = false;
            timer.cancel();
            player.stop();
          });
        } else {
          if (mounted) {
            setState(() {
              currentPosition++;
              print(currentPosition);
            });
          }
        }
      },
    );
  }

  pauseMusic() {
    setState(() {
      isPlay = false;
    });
    timer.cancel();
    print("pause");
    player.pause();
  }

  double dd = 0;

  initDuration(String name, String title) async {
    await player.setAsset("assets/musics/${name}-${title}.mp3");

    Duration dur = await player.duration as Duration;
    setState(() {
      d = dur.inSeconds.toString();
      dd = dur.inSeconds.toDouble();
      duration = dur.inMinutes.toString().padLeft(2, "0") +
          " : " +
          ((dur.inSeconds.toInt()) % 60).toString().padLeft(2, "0");
    });
  }

  var x;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 0),
      () {
        setState(() {
          x = ModalRoute.of(context)?.settings.arguments as SongArguments;
        });
        initDuration(x.name, x.title);
      },
    );
  }

  String formattedCurrentPosition() {
    return (currentPosition / 60).floor().toString().padLeft(2, "0") +
        " : " +
        (currentPosition.toInt() % 60).toString().padLeft(2, "0");
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as SongArguments;
    return WillPopScope(
      onWillPop: () async {
        popPage();
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => popPage(),
                            child: Container(
                                width: 24,
                                height: 24,
                                child: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Colors.white,
                                )),
                          ),
                          Expanded(
                              child: Center(
                            child: Text(
                              "Playing Now",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                          Container(
                            width: 24,
                            height: 24,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 220,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/${data.image}"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        data.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Album",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6), fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Slider(
                          activeColor: Color(0xFF940CFF),
                          min: 0,
                          max: dd,
                          divisions: 100,
                          label: formattedCurrentPosition(),
                          value: currentPosition.toDouble(),
                          onChanged: changeSliderValue,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formattedCurrentPosition(),
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                            Text(
                              duration,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 40, 37, 49)),
                            child: Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 40, 37, 49)),
                            child: Icon(
                              Icons.keyboard_double_arrow_left,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              isPlay == true
                                  ? pauseMusic()
                                  : playMusic(data.name, data.title);
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF940CFF)),
                              child: Icon(
                                isPlay == true ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 40, 37, 49)),
                            child: Icon(
                              Icons.keyboard_double_arrow_right,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 40, 37, 49)),
                            child: Icon(
                              Icons.share_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          )
                        ],
                      )
                    ],
                  )))),
    );
  }
}
