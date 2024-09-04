import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/Constants/Constants.dart';

import '../Cubit/Cubit States.dart';
import '../Cubit/Cubit.dart';

class Mymusic extends StatefulWidget {
  @override
  State<Mymusic> createState() => _MymusicState();
}

class _MymusicState extends State<Mymusic> {
  List<String> songs = [
    'audio/مصطفي النسر - الندابة _ Mostafa Elnesr - Elnadaba (Official Audio).mp3',
    "audio/Ringtone.mp3",
    "audio/01.Ya_Tara.mp3",
    "audio/01 Starboy (feat. Daft Punk).mp3",
    "audio/08.Albak_Ya_Hawl_Allah.mp3",
    "audio/Albumaty.Com_ahmd_sad_akhtyaraty_-_mn_fylm_mstr_aks.mp3",
    "audio/Albumaty.Com_hmzh_nmrh_ana_altyb.mp3",
    "audio/Albumaty.Com_hmzh_nmrh_rayk.mp3",
    "audio/Albumaty.Com_hmzh_nmrh_ryah_alhyat.mp3",
    "audio/Hamza Namira - Mesh Saleem _ حمزة نمرة - مش سليم.mp3"
  ];
  AudioPlayer audioPlayer = AudioPlayer();
  List<bool> isPlayingList = List<bool>.generate(10, (index) => false);
  int? currentlyPlayingIndex;
  Duration? lastPosition;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        setState(() {
          isPlayingList[currentlyPlayingIndex!] = true;
        });
      } else if (state == PlayerState.stopped) {
        setState(() {
          isPlayingList[currentlyPlayingIndex!] = false;
          lastPosition = Duration.zero; // Reset the last position
        });
      }
    });
  }

  void playLocalAsset(int index) async {
    if (currentlyPlayingIndex == index) {
      if (isPlayingList[index]) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.resume();
      }
      setState(() {
        isPlayingList[index] = !isPlayingList[index];
      });
      return;
    }

    // Stop any currently playing song
    if (currentlyPlayingIndex != null) {
      await audioPlayer.stop();
      setState(() {
        isPlayingList[currentlyPlayingIndex!] = false;
      });
    }

    // Play the new song
    String audioPath = songs[index];
    if (lastPosition != null && currentlyPlayingIndex == index) {
      await audioPlayer.seek(lastPosition!);
    } else {
      await audioPlayer.setSourceAsset(audioPath);
    }
    await audioPlayer.resume();

    setState(() {
      currentlyPlayingIndex = index;
      isPlayingList[index] = true;
    });

    // Save the position when the audio is paused or stopped
    audioPlayer.onPositionChanged.listen((position) {
      lastPosition = position;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('My Music Player'),
            actions: [
              Icon(Icons.search),
              SizedBox(
                width: 20,
              )
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
                          AppCubit.get(context).themebool
                              ? Icons.wb_sunny
                              : Icons.nights_stay,
                          size: 30,
                        ),
                        onPressed: () {
                          AppCubit.get(context).themeChange();
                        },
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(),
                    ),
                    onTap: () {
                      // Handle the home tap here
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
              itemCount: isPlayingList.length,
              itemBuilder: (context, index) {
                return SongTile(
                  songName: '${songs[index].replaceAll("audio/", "").replaceAll(".mp3", "")}',
                  artistName: 'Artist Name',
                  imageUrl:
                      'https://play-lh.googleusercontent.com/QovZ-E3Uxm4EvjacN-Cv1LnjEv-x5SqFFB5BbhGIwXI_KorjFhEHahRZcXFC6P40Xg',
                  onPlayPressed: () {
                    playLocalAsset(index); // Play or stop the selected song
                  },
                  isPlaying: isPlayingList[
                      index], // Pass the isPlaying state for this song
                );
              },
              physics: BouncingScrollPhysics(),
            ),
          ),
        );
      },
    );
  }
}
