import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
    Navigator.pop(context);
  }

  double currentSliderValue = 10;
  changeSliderValue(double value) {
    setState(() {
      currentSliderValue = value;
    });
  }

  String formatTime(int seconds) {
    int m = (seconds / 60).toInt();
    int s = seconds % 60;
    String min, sec;
    m < 10 ? min = "0" + m.toString() : min = m.toString();
    s < 10 ? sec = "0" + s.toString() : sec = s.toString();

    return min + " : " + sec;
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as SongArguments;

    return Scaffold(
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
                          onTap: popPage,
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                              image: AssetImage("assets/images/${data.image}"),
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
                          max: 100,
                          divisions: 100,
                          label: formatTime(currentSliderValue.toInt()),
                          value: currentSliderValue,
                          onChanged: changeSliderValue),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatTime(currentSliderValue.toInt()),
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
                          ),
                          Text(
                            "01 : 40",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
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
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFF940CFF)),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
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
                ))));
  }
}
