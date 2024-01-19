import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/artist.dart';
import 'package:music_player/data.dart';
import 'package:music_player/song_list.dart';
import 'package:on_audio_query/on_audio_query.dart';

class artist_list extends StatefulWidget {
  const artist_list({super.key});

  @override
  State<artist_list> createState() => _artist_listState();
}

class _artist_listState extends State<artist_list> {
  @override
  Widget build(BuildContext context) {
    data d = Get.put(data());
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: d.get_artist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<ArtistModel> l = snapshot.data as List<ArtistModel>;
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                return ListTile(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return song_list();
                  },));
                },
                  title: Text(
                    "${l[index].artist}",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  subtitle: Text(
                    "${l[index].numberOfAlbums}",
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
