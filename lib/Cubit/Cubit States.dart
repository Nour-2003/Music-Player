import 'package:flutter/src/material/theme_data.dart';
import 'package:flutter/src/widgets/icon.dart';

abstract class AppStates {

}
class InitialState extends AppStates{

}
class BlackTheme extends AppStates{
  BlackTheme(bool themebool, Icon icon, ThemeData theme);

}
class WhiteTheme extends AppStates{
  WhiteTheme(bool themebool, Icon icon, ThemeData theme);

}
class BottomNavChangeState extends AppStates{

}
class MusicPlayerState extends AppStates {
  final int? currentlyPlayingIndex;
  final List<bool> isPlayingList;
  final bool isPlaying;
  final String? imageUrl;
  final String? songName;
  final Duration currentPosition;
  final Duration totalDuration;

  MusicPlayerState({
    this.currentlyPlayingIndex,
    required this.isPlayingList,
    required this.isPlaying,
    this.imageUrl,
    this.songName,
    required this.currentPosition,
    required this.totalDuration,
  });

  // To copy state with new values
  MusicPlayerState copyWith({
    int? currentlyPlayingIndex,
    List<bool>? isPlayingList,
    bool? isPlaying,
    String? imageUrl,
    String? songName,
    Duration? currentPosition,
    Duration? totalDuration,
  }) {
    return MusicPlayerState(
      currentlyPlayingIndex: currentlyPlayingIndex ?? this.currentlyPlayingIndex,
      isPlayingList: isPlayingList ?? this.isPlayingList,
      isPlaying: isPlaying ?? this.isPlaying,
      imageUrl: imageUrl ?? this.imageUrl,
      songName: songName ?? this.songName,
      currentPosition: currentPosition ?? this.currentPosition,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }
}
