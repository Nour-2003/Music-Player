import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/Screens/Mymusic.dart';
import 'package:music_player/Screens/Watch.dart';

import 'Cubit States.dart';

class AppCubit extends Cubit<AppStates>
{
  final AudioPlayer audioPlayer = AudioPlayer();
  int? currentlyPlayingIndex;
  List<bool> isPlayingList = List<bool>.generate(18, (index) => false);
  bool isPlaying = false;
  String? imageUrl;
  String? songName;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  static AppCubit get(context) => BlocProvider.of(context);
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
    "audio/Hamza Namira - Mesh Saleem _ حمزة نمرة - مش سليم.mp3",
    "audio/Mawsltsh.Lehaga-Mostafa.Elnesr-MaTb3aa.Com.mp3",
    "audio/The Weeknd - Blinding Lights (Official Video) (256 kbps) (shabakngy.com).mp3",
    "audio/The-Weeknd-Die-For-You-Remix-ft-Ariana-Grande-(UmLandi.com).mp3",
    "audio/The_Weeknd_-_Save_Your_Tears_(Naijay.com).mp3",
    "audio/مصطفي النسر - انا زعلتك _ Mostafa Elnesr - ANA Z3LTK (Official Audio).mp3",
    "audio/مصطفي النسر - انا ليا طلب _ Mostafa Elnesr - ANA LYA TALAB.mp3",
    "audio/مصطفي النسر - لو معايا منه _ MOSTAFA ELNESR - LW M3AYA MNO.mp3"
  ];

  int currentIndex = 0;
  List<Widget> screens = [Mymusic(), Watch()];

  List<Widget> titles = [
    const Text(
      'My Music',
      style: TextStyle(fontSize: 25),
    ),
    const Text(
      'Watch',
      style: TextStyle(fontSize: 25),
    ),
  ];

  AppCubit() : super(InitialState()) {
    _initListeners();
  }

  void _initListeners() {
    audioPlayer.onPositionChanged.listen((position) {
      currentPosition = position;
      emit(MusicPlayerState(
        currentlyPlayingIndex: currentlyPlayingIndex,
        isPlayingList: isPlayingList,
        isPlaying: isPlaying,
        imageUrl: imageUrl,
        songName: songName,
        currentPosition: currentPosition,
        totalDuration: totalDuration,
      ));
    });

    audioPlayer.onDurationChanged.listen((duration) {
      totalDuration = duration ?? Duration.zero;
      emit(MusicPlayerState(
        currentlyPlayingIndex: currentlyPlayingIndex,
        isPlayingList: isPlayingList,
        isPlaying: isPlaying,
        imageUrl: imageUrl,
        songName: songName,
        currentPosition: currentPosition,
        totalDuration: totalDuration,
      ));
    });

    audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(BottomNavChangeState());
  }

  double getProgress() {
    if (totalDuration.inMilliseconds > 0) {
      return currentPosition.inMilliseconds / totalDuration.inMilliseconds;
    } else {
      return 0.0;
    }
  }
  void seekTo(double value) {
    final seekPosition = Duration(seconds: (value * totalDuration.inSeconds).toInt());
    audioPlayer.seek(seekPosition);
  }
  void playLocalAsset(int index)  {
    if (currentlyPlayingIndex == index) {
      if (isPlayingList[index]) {
         audioPlayer.pause();
      } else {
         audioPlayer.resume();
      }
      isPlayingList[index] = !isPlayingList[index];
      isPlaying = isPlayingList[index];
      emit(MusicPlayerState(
        currentlyPlayingIndex: currentlyPlayingIndex,
        isPlayingList: isPlayingList,
        isPlaying: isPlaying,
        imageUrl: imageUrl,
        songName: songName,
        currentPosition: currentPosition,
        totalDuration: totalDuration,
      ));
      return;
    }

    if (currentlyPlayingIndex != null) {
       audioPlayer.stop();
      isPlayingList[currentlyPlayingIndex!] = false;
    }

    audioPlayer.play(AssetSource(songs[index]));


    currentlyPlayingIndex = index;
    isPlayingList[index] = true;
    isPlaying = true;
    imageUrl = 'https://play-lh.googleusercontent.com/QovZ-E3Uxm4EvjacN-Cv1LnjEv-x5SqFFB5BbhGIwXI_KorjFhEHahRZcXFC6P40Xg'; // Replace with your image URL logic
    songName = songs[index].replaceAll("assets/audio/", "").replaceAll(".mp3", "");

    emit(MusicPlayerState(
      currentlyPlayingIndex: currentlyPlayingIndex,
      isPlayingList: isPlayingList,
      isPlaying: isPlaying,
      imageUrl: imageUrl,
      songName: songName,
      currentPosition: currentPosition,
      totalDuration: totalDuration,
    ));
  }

  void playNextSong() {
    if (currentlyPlayingIndex != null) {
      playLocalAsset((currentlyPlayingIndex! + 1) % songs.length);
    }
  }

  void playPreviousSong() {
    if (currentlyPlayingIndex != null) {
      playLocalAsset((currentlyPlayingIndex! - 1) % songs.length);
    }
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
  bool themebool = false;
  Icon icon = Icon(Icons.wb_sunny);
  ThemeData theme = ThemeData.light();
  void themeChange() {
    if (!themebool) {
      themebool = !themebool;
      icon = Icon(Icons.nights_stay);
      theme = ThemeData.dark().copyWith(
        drawerTheme: DrawerThemeData(
          backgroundColor: Color(0xFF091227),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF091227),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleSpacing: 30,
          backgroundColor: Color(0xFF091227),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          titleTextStyle: TextStyle(
            fontFamily: 'Pacifico',
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Color(0xFF091227),
      );
      emit(BlackTheme(themebool, icon, theme));
    }
    else {
      themebool = !themebool;
      icon = Icon(Icons.wb_sunny);
      theme = ThemeData.light().copyWith(
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.white, // Light background for the drawer
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // Light background for the bottom nav bar
          selectedItemColor: Color(0xFF091227), // Dark selected item color for contrast in light mode
          unselectedItemColor: Colors.grey, // Grey unselected item color for contrast in light mode
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Color(0xFF091227), // Dark icon color for contrast in light mode
          ),
          titleSpacing: 30,
          backgroundColor: Colors.white, // Light background for the app bar
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white, // Status bar matches the app bar
            statusBarIconBrightness: Brightness.dark, // Dark icons for light status bar
          ),
          titleTextStyle: TextStyle(
            color: Color(0xFF091227), // Dark text color for app bar title
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.white, // Light background for the scaffold
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF091227)), // Dark text for general content
          bodyMedium: TextStyle(color: Color(0xFF091227)), // Dark text for general content
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF091227), // Dark icons for consistency
        ),
        primaryColor: Color(0xFF091227), // Primary color for consistency with the dark theme
      );
      emit(WhiteTheme(themebool, icon, theme));
    }
  }
}
