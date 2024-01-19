import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/data.dart';
import 'package:on_audio_query/on_audio_query.dart';

class song_list extends StatefulWidget {
  const song_list({super.key});

  @override
  State<song_list> createState() => _song_listState();
}

class _song_listState extends State<song_list> {
  @override
  Widget build(BuildContext context) {
    data d = Get.put(data());
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: d.get_song(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<SongModel> l = snapshot.data as List<SongModel>;
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                return ListTile(

                  onTap: () {
                    print("Good");
                    d.get_duration();
                    d.isplay.value = true;
                    if (d.cur_ind.value == index) {
                      // data.player.play(DeviceFileSource(d.song_list.value[d.cur_ind.value].data));
                    } else {
                      print("hello");
                      d.cur_ind.value = index;
                      data.player.play(DeviceFileSource(d.song_list.value[d
                          .cur_ind.value].data));
                    }
                  },
                  title: Text("${l[index].title}",maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 20)),
                  subtitle: Text("${l[index].artist}",style: TextStyle(color: Colors.white,fontSize: 10)),
                  trailing: Wrap(children: [
                    Obx(() =>
                    d.cur_ind == index && d.isplay.value ? Image.network(
                      "https://i.pinimg.com/originals/cb/17/b8/cb17b80a942d7c317a35ff1324fae12f.gif",
                      height: 40, width:40,) : Text(""))
                  ]),
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
