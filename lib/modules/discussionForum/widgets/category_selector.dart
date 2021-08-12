import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {

  int selectedIndex= 0;
  final List<String> categories= ['Messages'];//, 'online', 'Groups', 'Requests'
  @override
  Widget build(BuildContext context) {
    return Container(
            height: 90,
            color: Colors.blue[900],//deepPurpleAccent
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    setState((){
                      selectedIndex= index;
                    }

                    );
                  },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20, 
                    vertical: 30
                    ),
                    child: Text(categories[index],
                     style: TextStyle(
                       color: index== selectedIndex? Colors.blue[100]: Colors.white60,
                       fontSize: 24, 
                       //fontWeight: FontWeight.bold,
                       letterSpacing: 1.2,
                        ), 
                        ),
                ),
                );
                return Text(categories[index]);
              },
            )
          );
  }
}