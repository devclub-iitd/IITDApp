import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/discussionForum/models/message_model.dart';
import 'package:IITDAPP/modules/discussionForum/models/user_model.dart';

//package:IITDAPP/modules/events/home.dart
class ChatScreen extends StatefulWidget {
  final User user;
  ChatScreen({this.user});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Container _buildMessage(Message message, bool isMe) {
    return Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: 80,
            )
          : EdgeInsets.only(
              top: 8,
              bottom: 8,
              right: 80,
            ),
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),

      //child:
      //Text(message.text),
      decoration: BoxDecoration(
        color: isMe ? Colors.grey[100] : Colors.lightBlue[100],
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(message.time,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                //fontWeight: FontWeight.w600,
              )),
          SizedBox(
            height: 8,
          ),
          Text(message.text,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }

  Container _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration:
                  InputDecoration.collapsed(hintText: 'Send a message...'),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Colors.black, //lightBlue
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
          title: Text(
            widget.user.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.more_horiz),
                iconSize: 30,
                color: Colors.white,
                onPressed: () {}),
          ]),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final message = messages[index];
                      final isMe = message.sender.id == currentUser.id;
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
