import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/data.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'all_album_song.dart';

class album_list extends StatefulWidget {
  const album_list({super.key});

  @override
  State<album_list> createState() => _album_listState();
}

class _album_listState extends State<album_list> {
  @override
  Widget build(BuildContext context) {
    data d = Get.put(data());
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: d.get_alubm(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<AlbumModel> l = snapshot.data as List<AlbumModel>;
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                return ListTile(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return all_album_song(l[index]);
                  },));
                },
                  title: Text(
                    "${l[index].album}",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
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
