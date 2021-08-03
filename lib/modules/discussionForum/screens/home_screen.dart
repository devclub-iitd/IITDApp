import 'package:flutter/material.dart';


import 'package:IITDAPP/modules/discussionForum/widgets/category_selector.dart';
import 'package:IITDAPP/modules/discussionForum/widgets/favourite_contacts.dart';
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30,
            color: Colors.white,
            onPressed: (){}
            ),
          title: Text('Discussion Forum',
           style: TextStyle(
             fontSize: 28,
             fontWeight: FontWeight.bold,
          )),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
            iconSize: 30,
            color: Colors.white,
            onPressed: (){}

            ),
          ]
        ),
        body: Column(children: <Widget>[
          CategorySelector(),
          Expanded(
          child:Container(
            
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
               ),
              ),
              child: Column(children: <Widget>[
                FavouriteContacts(),
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