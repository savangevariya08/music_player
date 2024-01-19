import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/data.dart';
import 'package:music_player/song_list.dart';
import 'package:on_audio_room/on_audio_room.dart';

class full_screen extends StatefulWidget {
  const full_screen({super.key});

  @override
  State<full_screen> createState() => _full_screenState();
}

class _full_screenState extends State<full_screen> {
  @override
  Widget build(BuildContext context) {
    double Screen_height = MediaQuery.of(context).size.height;
    data d = Get.put(data());
    return Scaffold(
      body: Container(
        height: Screen_height,
        color: Colors.grey.shade900,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Expanded(
                flex: 8,
                child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(60, 30, 60, 20),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.music_note,
                      size: 200,
                      color: Colors.grey.shade700,
                    )),
              ),
              SizedBox(height: 20),
              Obx(
                () => Text(
                  "${d.song_list.value[d.cur_ind.value].title}",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // SizedBox(height: 10,),
              Obx(
                () => Text(
                  "${d.song_list.value[d.cur_ind.value].artist}",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.blue,
                      trackHeight: 2,
                    ),
                    child: Obx(() => Slider(
                          thumbColor: Colors.blue,
                          min: 0,
                          max: d.song_list.value.length > 0
                              ? d.song_list.value[d.cur_ind.value].duration!
                                  .toDouble()
                              : 0,
                          value: d.duration.value,
                          onChanged: (value) {},
                        ))),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (d.cur_ind > 0) {
                            d.cur_ind--;
                            d.isplay.value = true;
                            data.player.play(DeviceFileSource(
                                d.song_list.value[d.cur_ind.value].data));
                          }
                        },
                        icon: Icon(
                          Icons.skip_previous,
                          size: 70,
                          color: Colors.white,
                        )),
                    Obx(
                      () => d.isplay.value
                          ? IconButton(
                              onPressed: () {
                                data.player.pause();
                                d.isplay.value = !d.isplay.value;
                              },
                              icon: Icon(Icons.pause_circle_outline,
                                  color: Colors.white, size: 70))
                          : IconButton(
                              onPressed: () {
                                d.isplay.value = !d.isplay.value;
                                data.player.play(DeviceFileSource(
                                    d.song_list.value[d.cur_ind.value].data));
                              },
                              icon: Icon(Icons.play_circle_outlined,
                                  color: Colors.white, size: 70),
                            ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (d.cur_ind < d.song_list.length - 1) {
                            d.cur_ind++;
                            d.isplay.value = true;
                            data.player.play(DeviceFileSource(
                                d.song_list.value[d.cur_ind.value].data));
                          }
                        },
                        icon: Icon(
                          Icons.skip_next,
                          size: 70,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.list,
                      size: 25,
                      color: Colors.white,
                    ),
                    Obx(() => d.fav.value
                        ? IconButton(
                            onPressed: () async {
                              bool deleteFromResult = await OnAudioRoom().deleteFrom(
                                RoomType.FAVORITES,
                                d.song_list.value[d.cur_ind.value].id,
                                //playlistKey,
                              );
                              d.get_chek();
                            }, icon: Icon(Icons.favorite), color: Colors.white,)
                        : IconButton(
                            onPressed: () async {
                              int? addToResult = await OnAudioRoom().addTo(
                                RoomType.FAVORITES,
                                d.song_list.value[d.cur_ind.value].getMap
                                    .toFavoritesEntity(),
                              );
                              d.get_chek();
                            },
                            icon: Icon(Icons.favorite_border), color: Colors.white,)),
                    Icon(
                      Icons.repeat,
                      size: 25,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.more_horiz,
                      size: 25,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
