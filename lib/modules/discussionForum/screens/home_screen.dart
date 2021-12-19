import 'package:flutter/material.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';

import 'package:IITDAPP/modules/discussionForum/widgets/category_selector.dart';
//import 'package:IITDAPP/modules/discussionForum/widgets/favourite_contacts.dart';
import 'package:IITDAPP/modules/discussionForum/widgets/recent_chats.dart';
//package:IITDAPP/modules/discussionForum/
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(
        title: Text('Chats'),
        height: 1,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {}),
        ],
      ),
      drawer: AppDrawer(
        tag: 'Chats',
      ),
        body: Column(children: <Widget>[
          CategorySelector(),
          Expanded(
          child:Container(
            
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
               ),
              ),
              child: Column(children: <Widget>[
                //FavouriteContacts(),
                RecentChats(),
              ],
              ),
            ),
          
          ),
          

        ],
        ),
    );
  }
}
/*Expanded(
                child:Container(
                
                decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
               ),
              ), 
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int index){
                  return Text(
                    chats[index].sender.name,
                  );
                },
              ),
                ),
                ),*/
