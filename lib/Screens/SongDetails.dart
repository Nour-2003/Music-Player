import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/Cubit/Cubit%20States.dart';
import 'package:music_player/Cubit/Cubit.dart';

import '../Constants/Constants.dart';

class Songdetails extends StatefulWidget {
  String artistName;
String imageUrl;
  Songdetails({required this.artistName, required this.imageUrl});
  @override
  State<Songdetails> createState() => _SongdetailsState();
}

class _SongdetailsState extends State<Songdetails> {
  bool muted = false;
  bool isfavourite = false;
  void changeMute() {
    setState(() {
      muted = !muted;
    });
  }
  void changeFavourite() {
    setState(() {
      isfavourite = !isfavourite;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        final musicPlayerState = state as MusicPlayerState;
        return  Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Playing Now", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.imageUrl,
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        changeMute();
                      },
                      icon: this.muted ? Icon(Icons.volume_up) : Icon(Icons.volume_off),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        AppCubit.get(context).songName?.replaceAll(
                            "audio/", "") ?? 'Unknown Song',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        changeFavourite();
                      },
                      icon:this.isfavourite ? Icon(Icons.favorite_border):Icon(Icons.favorite),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "${widget.artistName}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20,),
                SongProgressBar(
                  currentDuration:musicPlayerState.currentPosition,
                  totalDuration:musicPlayerState.totalDuration,
                  onChanged: (newValue) {
                    AppCubit.get(context).seekTo(newValue);
                  },
                  progress: AppCubit.get(context).getProgress(),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).playPreviousSong();
                      },
                      icon: Icon(Icons.skip_previous),
                      iconSize: 50,
                    ),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).playLocalAsset(AppCubit.get(context).currentlyPlayingIndex!);
                      },
                      icon: AppCubit.get(context).isPlaying ?Icon(Icons.pause) :Icon(Icons.play_arrow),
                      iconSize: 50,
                    ),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).playNextSong();
                      },
                      icon: Icon(Icons.skip_next),
                      iconSize: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
