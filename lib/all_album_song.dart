import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/data.dart';
import 'package:music_player/fullscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_query_platform_interface/src/models/album_model.dart';

class all_album_song extends StatelessWidget {
  AlbumModel l;

  all_album_song(this.l);

  // const all_album_song({super.key});

  @override
  Widget build(BuildContext context) {
    data d = Get.put(data());
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: d.get_all_song(l.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<SongModel> l = snapshot.data as List<SongModel>;
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    d.isplay.value = true;
                    for (int i = 0; i < d.song_list.value.length; i++) {
                      if (d.song_list.value[i].id == l[index].id) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return full_screen();
                          },
                        ));
                        if (i == d.cur_ind.value) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return full_screen();
                            },
                          ));
                        } else {
                          d.cur_ind.value = i;
                          data.player.play(DeviceFileSource(
                              d.song_list.value[d.cur_ind.value].data));
                        }
                      }
                    }
                  },
                  title: Text("${l[index].title}",maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
