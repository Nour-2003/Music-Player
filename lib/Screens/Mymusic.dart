import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/Constants/Constants.dart';
import 'package:music_player/Screens/SongDetails.dart';

import '../Cubit/Cubit States.dart';
import '../Cubit/Cubit.dart';

class Mymusic extends StatefulWidget {
  @override
  State<Mymusic> createState() => _MymusicState();
}

class _MymusicState extends State<Mymusic> {
  // List<String> songs = [
  //   'audio/مصطفي النسر - الندابة _ Mostafa Elnesr - Elnadaba (Official Audio).mp3',
  //   "audio/Ringtone.mp3",
  //   "audio/01.Ya_Tara.mp3",
  //   "audio/01 Starboy (feat. Daft Punk).mp3",
  //   "audio/08.Albak_Ya_Hawl_Allah.mp3",
  //   "audio/Albumaty.Com_ahmd_sad_akhtyaraty_-_mn_fylm_mstr_aks.mp3",
  //   "audio/Albumaty.Com_hmzh_nmrh_ana_altyb.mp3",
  //   "audio/Albumaty.Com_hmzh_nmrh_rayk.mp3",
  //   "audio/Albumaty.Com_hmzh_nmrh_ryah_alhyat.mp3",
  //   "audio/Hamza Namira - Mesh Saleem _ حمزة نمرة - مش سليم.mp3",
  //   "audio/Mawsltsh.Lehaga-Mostafa.Elnesr-MaTb3aa.Com.mp3",
  //   "audio/The Weeknd - Blinding Lights (Official Video) (256  kbps) (shabakngy.com).mp3",
  //   "audio/The-Weeknd-Die-For-You-Remix-ft-Ariana-Grande-(UmLandi.com).mp3",
  //   "audio/The_Weeknd_-_Save_Your_Tears_(Naijay.com).mp3",
  //   "audio/مصطفي النسر - انا زعلتك _ Mostafa Elnesr - ANA Z3LTK (Official Audio).mp3",
  //   "audio/مصطفي النسر - انا ليا طلب _ Mostafa Elnesr - ANA LYA TALAB.mp3",
  //   "audio/مصطفي النسر - لو معايا منه _ MOSTAFA ELNESR - LW M3AYA MNO.mp3"
  // ];
  // AudioPlayer audioPlayer = AudioPlayer();
  // int? currentlyPlayingIndex;
  // List<bool> isPlayingList = List<bool>.generate(18, (index) => false);
  // bool isPlaying = false;
  // String? imageUrl;
  // String? songName;
  // Duration currentPosition = Duration.zero;
  // Duration totalDuration = Duration.zero;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   audioPlayer.onPositionChanged.listen((Duration position) {
  //     setState(() {
  //       currentPosition = position;
  //     });
  //   });
  //
  //   audioPlayer.onDurationChanged.listen((Duration duration) {
  //     setState(() {
  //       totalDuration = duration;
  //     });
  //   });
  // }
  //
  // double getProgress() {
  //   if (totalDuration.inMilliseconds > 0) {
  //     return currentPosition.inMilliseconds / totalDuration.inMilliseconds;
  //   } else {
  //     return 0.0;
  //   }
  // }
  //
  // void playLocalAsset(int index) async {
  //   if (currentlyPlayingIndex == index) {
  //     if (isPlayingList[index]) {
  //       await audioPlayer.pause();
  //     } else {
  //       await audioPlayer.resume();
  //     }
  //     setState(() {
  //       isPlayingList[index] = !isPlayingList[index];
  //       isPlaying = isPlayingList[index];
  //     });
  //     return;
  //   }
  //
  //   if (currentlyPlayingIndex != null) {
  //     await audioPlayer.stop();
  //     setState(() {
  //       isPlayingList[currentlyPlayingIndex!] = false;
  //     });
  //   }
  //
  //   await audioPlayer.setSourceAsset(songs[index]);
  //   await audioPlayer.resume();
  //
  //   setState(() {
  //     currentlyPlayingIndex = index;
  //     isPlayingList[index] = true;
  //     isPlaying = true;
  //     imageUrl =
  //     'https://play-lh.googleusercontent.com/QovZ-E3Uxm4EvjacN-Cv1LnjEv-x5SqFFB5BbhGIwXI_KorjFhEHahRZcXFC6P40Xg'; // Replace with your image URL logic
  //     songName = '${songs[index].replaceAll("audio/", "").replaceAll(
  //         ".mp3", "")}'; // Replace with your song name logic
  //   });
  //
  //   audioPlayer.onPlayerComplete.listen((_) {
  //     playNextSong();
  //   });
  // }
  //
  // void playNextSong() {
  //   if (currentlyPlayingIndex != null) {
  //     playLocalAsset((currentlyPlayingIndex! + 1) % songs.length);
  //   }
  // }
  //
  // void playPreviousSong() {
  //   if (currentlyPlayingIndex != null) {
  //     playLocalAsset((currentlyPlayingIndex! - 1) % songs.length);
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   audioPlayer.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('My Music Player',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            actions: [
              Icon(Icons.search),
              SizedBox(width: 20),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 120,
                  width: double.infinity,
                  color: Color(0xFF091227),
                  padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 35,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Close the drawer
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          color: Colors.white,
                          cubit.themebool ? Icons.wb_sunny : Icons.nights_stay,
                          size: 30,
                        ),
                        onPressed: () {
                          cubit.themeChange();
                        },
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile', style: TextStyle()),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                ),
                CustomListTile(
                  icon: Icons.favorite,
                  title: 'Liked Songs',
                  onTap: () {
                    Navigator.pop(context); // Handle the "Liked Songs" tap here
                  },
                ),
                CustomListTile(
                  icon: Icons.language,
                  title: 'Language',
                  onTap: () {
                    Navigator.pop(context); // Handle the "Language" tap here
                  },
                ),
                CustomListTile(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context); // Handle the "Settings" tap here
                  },
                ),
                CustomListTile(
                  icon: Icons.contact_mail,
                  title: 'Contact Us',
                  onTap: () {
                    Navigator.pop(context); // Handle the "Contact Us" tap here
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: ListView.builder(
              itemCount: cubit.songs.length,
              itemBuilder: (context, index) {
                return SongTile(
                  songName: '${cubit.songs[index]
                      .replaceAll("audio/", "")
                      .replaceAll(".mp3", "")}',
                  artistName: 'Artist Name',
                  imageUrl: 'https://play-lh.googleusercontent.com/QovZ-E3Uxm4EvjacN-Cv1LnjEv-x5SqFFB5BbhGIwXI_KorjFhEHahRZcXFC6P40Xg',
                  onPlayPressed: () {
                    cubit.playLocalAsset(
                        index);
                    Navigator.of(context).push(MaterialPageRoute(builder: (
                        context) =>
                        Songdetails(
                          artistName: 'Artist Name',
                          imageUrl: 'https://play-lh.googleusercontent.com/QovZ-E3Uxm4EvjacN-Cv1LnjEv-x5SqFFB5BbhGIwXI_KorjFhEHahRZcXFC6P40Xg',
                        )));
                  },
                  isPlaying: cubit
                      .isPlayingList[index], // Pass the isPlaying state for this song
                );
              },
              physics: BouncingScrollPhysics(),
            ),
          ),
          bottomNavigationBar: cubit.currentlyPlayingIndex != null
              ? SongFooter(
            imageUrl: cubit.imageUrl ?? '',
            // Handle null case
            songName: cubit.songName?.replaceAll(
                "audio/", "") ?? 'Unknown Song',
            // Handle null case
            onPlayPausePressed: () {
              cubit.playLocalAsset(cubit.currentlyPlayingIndex!);
            },
            onNextPressed: cubit.playNextSong,
            onBackPressed: cubit.playPreviousSong,
            isPlaying: cubit.isPlaying,
            progress: cubit.getProgress(), // Pass the calculated progress here
          )
              : SizedBox.shrink(), // Hide the footer if there's no song playing
        );
      },
    );
  }
}
