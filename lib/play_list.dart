import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/data.dart';
import 'package:music_player/fav_song.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';

class play_list extends StatefulWidget {
  const play_list({super.key});

  @override
  State<play_list> createState() => _play_listState();
}

class _play_listState extends State<play_list> {
  @override
  Widget build(BuildContext context) {
    data d = Get.put(data());
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: d.get_fav(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<FavoritesEntity> l = snapshot.data as List<FavoritesEntity>;
            return ListTile(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return fav_song();
              },));
            },
              title: Text("Song",maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 20)),
              subtitle: Text("${l.length}",maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 15)),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
