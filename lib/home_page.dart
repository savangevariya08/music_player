import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:music_player/data.dart';
import 'package:music_player/fullscreen.dart';
import 'song_list.dart';
import 'play_list.dart';
import 'artist_list.dart';
import 'album_list.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  data d = Get.put(data());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(tabs: [
            Tab(
              child: Text(
                "Songs",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Tab(
              child: Text("Playlist",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
            Tab(
              child: Text("Aritis",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
            Tab(
              child: Text("Album",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            )
          ])),
          bottomNavigationBar:
              Column(mainAxisSize: MainAxisSize.min, children: [
            BottomAppBar(
              color: Colors.black,
              child: Column(children: [
                SliderTheme(
                    data: SliderTheme.of(context)
                        .copyWith(activeTrackColor: Colors.blue, trackHeight: 2,thumbColor: Colors.blue),
                    child: Obx(() => Slider(
                          min: 0,
                          max: d.song_list.length > 0
                              ? d.song_list[d.cur_ind.value].duration!
                                  .toDouble()
                              : 0,
                          value: d.duration.value,
                          onChanged: (value) {
                            d.isplay.value=true;
                          },
                        ))),
                ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return full_screen();
                        },
                      ));
                    },
                    title: Obx(() => d.song_list.value.isNotEmpty
                        ? Text(
                            "${d.song_list[d.cur_ind.value].title}",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            maxLines: 1,
                          )
                        : Text("data")),
                    trailing: Wrap(
                      children: [
                        Obx(
                          () => d.isplay.value
                              ? IconButton(
                                  onPressed: () {
                                    data.player.pause();
                                    d.isplay.value = !d.isplay.value;
                                  },
                                  icon: Icon(Icons.pause,color: Colors.blue,))
                              : IconButton(
                                  onPressed: () {
                                    d.isplay.value = !d.isplay.value;
                                    data.player.play(DeviceFileSource(
                                        d.song_list[d.cur_ind.value].data));
                                  },
                                  icon: Icon(Icons.play_arrow,color: Colors.blue,),
                                ),
                        ),
                      ],
                    )),
              ]),
            ),
          ]),
          body: TabBarView(children: [
            song_list(),
            play_list(),
            artist_list(),
            album_list(),
          ]),
        ));
  }
}
