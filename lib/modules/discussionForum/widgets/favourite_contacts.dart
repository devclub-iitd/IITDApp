import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/discussionForum/models/message_model.dart';
import 'package:IITDAPP/modules/discussionForum/screens/chat_screens.dart';
//package:IITDAPP/modules/discussionForum/
class FavouriteContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      children: <Widget>[
     Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
                  Text('Favourite Threads', style: TextStyle(color: Colors.blueGrey, 
                  fontSize:18.0,
                    fontWeight: FontWeight.bold, 
                    letterSpacing: 1.0, 
                    ),
                    ),
                  IconButton(
                    icon: 
                    Icon(
                      Icons.more_horiz
                      ),
                      iconSize: 30.0,
                      color: Colors.indigo,
                      onPressed: (){},
                    )
                    
                ],
                ),
    ),
    Container(
      height: 120,
       //color: Colors.indigoAccent , 
       child: ListView.builder(
         padding: EdgeInsets.only(left: 10.0),
         scrollDirection: Axis.horizontal,
         itemCount: favorites.length,
         itemBuilder: (BuildContext context, int index){
           return GestureDetector(
             onTap: ()=> Navigator.push(context, MaterialPageRoute(
                      builder: (_) => ChatScreen(
                      user: favorites[index],
                      
                      ),
                    ),
                    ),
           child: Padding(
             padding: const EdgeInsets.all( 10),
           child:  Column(
             children: <Widget>[
               CircleAvatar(radius: 35,
               backgroundImage: AssetImage(favorites[index].imageUrl),
                ),
                SizedBox(height: 6.0,),
           Text(
             favorites[index].name, 
              style: TextStyle(
             color: Colors.blueGrey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
               )
               ),
             ]
           ),
           ),
           );
         },

       ),
       ),
      ],
    ),
    );
    //);
  }
}
