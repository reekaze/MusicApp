import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_1/SongArguments.dart';
import 'package:test_1/data/SingerList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  pushSongScreen(var i) {
    Navigator.pushNamed(context, '/SongScreen',
        arguments: SongArguments(
            name: i['name'], title: i['title'], image: i['image']));
  }

  @override
  Widget build(BuildContext context) {
    var singerList = SingerList().getData;
    var songList = SingerList().getSong;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
      width: MediaQuery.of(context).size.width,
      child: ListView(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 26,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 26,
                  height: 26,
                  child: SvgPicture.asset("assets/images/Group 1770.svg")),
              Container(
                  width: 26,
                  height: 26,
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          "Discover",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "What do you want to hear?",
          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
            style: TextStyle(color: Colors.white.withOpacity(0.6)),
            decoration: InputDecoration(
                fillColor: Color(0xFF191626),
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: "Search Music",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.6),
                ))),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Popular Releases",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: singerList.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(
                        right: index == singerList.length - 1 ? 0 : 15),
                    width: 260,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/${singerList[index]['image']}"))),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                  width: 240,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black.withOpacity(0.25)),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${singerList[index]['name']}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            Icon(
                                              Icons.check_circle,
                                              color:
                                                  Colors.blue.withOpacity(0.8),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${singerList[index]['album']}",
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 16),
                                            ),
                                            Row(
                                              children: [
                                                for (var i = 0; i < 5; i++)
                                                  Icon(
                                                    Icons.star,
                                                    size: 15,
                                                    color: Colors.yellow
                                                        .withOpacity(0.8),
                                                  ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ));
              },
            )),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recently Playlist",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "View all",
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: songList.map((i) {
            return Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(left: 8, right: 8),
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF191626)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/${i['image']}"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${i['title']}",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            "${i['name']}",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14),
                          )
                        ],
                      )
                    ],
                  ),
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Color(0XFF940CFF),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    onTap: () => pushSongScreen(i),
                  ),
                ],
              ),
            );
          }).toList(),
        )
      ]),
    );
  }
}
