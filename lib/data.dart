import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
import 'package:on_audio_room/on_audio_room.dart';

class data extends GetxController {

    RxList<SongModel> song_list=RxList();
    RxList<AlbumModel> alubum_list=RxList();
    RxList<ArtistModel> artist_list=RxList();
    RxList<SongModel> all_album=RxList();
    RxList<FavoritesEntity> fav_list=RxList();
    static OnAudioQuery _audioQuery=OnAudioQuery();
    static AudioPlayer player=AudioPlayer();
    RxBool isplay=false.obs;
    RxBool fav=false.obs;
    RxDouble duration=0.0.obs;

    RxInt cur_ind=0.obs;

    get_song()
    async {
        song_list.value= await _audioQuery.querySongs();
        return song_list;
    }
    get_duration(){
        player.onPositionChanged.listen((Duration d){
            duration.value=d.inMilliseconds.toDouble();
        });
    }
    get_alubm()
    async {
        alubum_list.value= await _audioQuery.queryAlbums();
        return alubum_list;
    }
    get_artist()
    async {
        artist_list.value= await _audioQuery.queryArtists();
        return artist_list;
    }
    get_all_song(int alubumid) async {
        all_album.value= await _audioQuery.queryAudiosFrom(AudiosFromType.ALBUM_ID,alubumid );
        return all_album;
    }
    get_fav() async {
        fav_list.value=await OnAudioRoom().queryFavorites();
        return fav_list;
    }
    get_chek() async {
        fav.value=await OnAudioRoom().checkIn(RoomType.FAVORITES, song_list.value[cur_ind.value].id);
    }

}