import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';
import '../Cubit/Cubit.dart';

class Watch extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watch"),
        centerTitle: true,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Watch Screen")
            ],
          ),
        ),
    );
  }
}
