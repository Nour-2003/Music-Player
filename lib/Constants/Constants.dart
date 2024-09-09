import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  CustomListTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      onTap: onTap,
    );
  }
}
class SongTile extends StatelessWidget {
  final String songName;
  final String artistName;
  final String imageUrl;
  final VoidCallback onPlayPressed;
final bool isPlaying;
  SongTile({
    required this.songName,
    required this.artistName,
    required this.imageUrl,
    required this.onPlayPressed,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
              children: [
                Text(
                  songName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  artistName,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: SizedBox(width: 20)),
          ElevatedButton(
            onPressed: onPlayPressed,
            child: isPlaying?Icon(CupertinoIcons.pause):Icon(Icons.play_arrow),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
class SongFooter extends StatelessWidget {
  final String imageUrl;
  final String songName;
  final VoidCallback onPlayPausePressed;
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  final bool isPlaying;
  final double progress; // Add progress parameter

  const SongFooter({
    required this.imageUrl,
    required this.songName,
    required this.onPlayPausePressed,
    required this.onNextPressed,
    required this.onBackPressed,
    required this.isPlaying,
    required this.progress, // Initialize progress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              songName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(Icons.skip_previous, color: Colors.white),
            onPressed: onBackPressed,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: progress, // Progress value from 0.0 to 1.0
                strokeWidth: 2.0,
                backgroundColor: Colors.white.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: onPlayPausePressed,
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.skip_next, color: Colors.white),
            onPressed: onNextPressed,
          ),
        ],
      ),
    );
  }
}
class SongProgressBar extends StatelessWidget {
  final Duration currentDuration;
  final Duration totalDuration;
  final Function(double) onChanged;
  final double progress;

  SongProgressBar({
    required this.currentDuration,
    required this.totalDuration,
    required this.onChanged,
    required this.progress,
  });

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Current time at the top
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 25.0),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
           Text(
                 formatDuration(currentDuration),
                 style: TextStyle(color: Colors.grey, fontSize: 14.0),
               ),

            Text(
                 formatDuration(totalDuration),
                 style: TextStyle(color: Colors.grey, fontSize: 14.0),
               ),

           ],
         ),
       ),
        // Progress bar in the middle
    Slider(
    value: progress,
    min: 0.0,
    max: 1.0,
    onChanged: onChanged,
    // Optionally customize the appearance of the slider here
    ),
        // Total duration at the bottom

      ],
    );
  }
}
