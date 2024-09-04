import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/Cubit/Cubit%20States.dart';

import 'Constants/Constants.dart';
import 'Cubit/Cubit.dart';

void main() {
  runApp( MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state)
        {},
        builder: (context,state){
          return  MaterialApp(
            theme: AppCubit.get(context).theme,
            debugShowCheckedModeBanner: false,
            home:  MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('My Music Player'),
            actions: [
              Icon(Icons.search),
              SizedBox(width: 20,)
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 120,
                  width: double.infinity,
                  color:  Color(0xFF091227),
                  padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.close, size: 35,color: Colors.white,),
                        onPressed: () {
                          Navigator.pop(context); // Close the drawer
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          color: Colors.white,
                          AppCubit.get(context).themebool ? Icons.wb_sunny : Icons.nights_stay,
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
                    leading: Icon(Icons.person,),
                    title: Text('Profile',style: TextStyle(

                    ),),
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
            child: ListView.builder(itemBuilder:
                (context,index){
              return SongTile(
                songName: 'Song Name',
                artistName: 'Artist Name',
                imageUrl: 'https://play-lh.googleusercontent.com/QovZ-E3Uxm4EvjacN-Cv1LnjEv-x5SqFFB5BbhGIwXI_KorjFhEHahRZcXFC6P40Xg',
                onPlayPressed: () {
                  // Handle the play button tap here
                },
              );
            },
              physics: BouncingScrollPhysics(),
              itemCount: 10,
            )
          ),
        );
      },
    );
  }
}
