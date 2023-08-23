import 'package:flutter/material.dart';
import 'package:iitd_app/models/lostandfoundmodel.dart';
import 'package:intl/intl.dart';

class LostFoundComponents {
  Widget lostCard(LostandFoundModel lostandFoundModel,BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width-50)/2,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(children: [
        Container(
          width: (MediaQuery.of(context).size.width-50)/2,
          height: 100,
          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(lostandFoundModel.img))),
        ),
        Text(lostandFoundModel.title),
        Row(
          children: [
            const Icon(Icons.location_on,color: Colors.red,),
            Text(lostandFoundModel.wherefound),

          ],
        ),
        Row(
          children: [
            const Icon(Icons.timer,color: Colors.blue,),
            Text("${DateFormat('d MMM').format(lostandFoundModel.timestamp)} ${DateFormat('h:mm a').format(lostandFoundModel.timestamp)}"),
            
          ],
        ),
        Row(
          children: [
            const Icon(Icons.history,color: Colors.blue,),
            Text(lostandFoundModel.status.toString().split(".")[1]),
            
          ],
        ),
        
      ],),
    );
  }
}
