import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/data.dart';
import 'package:music_player/fullscreen.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';

class fav_song extends StatelessWidget {
  const fav_song({super.key});

  @override
  Widget build(BuildContext context) {
    data d = Get.put(data());
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: d.get_fav(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<FavoritesEntity> l = snapshot.data as List<FavoritesEntity>;
            return ListView.builder(
              itemCount: l.length, itemBuilder: (context, index) {
              return ListTile(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return full_screen();
                },));
              },
                title: Text("${l[index].title}",maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 20)),
              );
            },);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
