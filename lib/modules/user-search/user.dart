import 'package:flutter/material.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:IITDAPP/modules/user-search/data/data.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/searchbar';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();
  var _suggestion = data;
  var _overflow = 170;
  var strlen = 0;
  Widget appBar;
  String what = 'name';
  double _width = 0;
  Color _cancel = Colors.transparent;
  bool ch = false;
  Color _cnclbtn = Colors.transparent;
  @override
  void initState() {
    appBar = CustomAppBar(
      title: Text('Search User'),
      height: 1,
    );
    _focus.addListener(() {
      setState(() {
        ch = _focus.hasFocus ? true : false;
      });
    });
    super.initState();
  }

  // void buildSuggestion(String str) {
  //   var _suggestion = str.isEmpty
  //       ? data
  //       : data
  //           .where((element) => element[(what == 'kerberos' ? 1 : 0)]
  //               .startsWith(str.toLowerCase()))
  //           .toList();
  //   build = ListView.builder(
  //       itemBuilder: (context, index) => ListTile(
  //             onTap: () {},
  //             minLeadingWidth: 50,
  //             leading: Icon(CupertinoIcons.person),
  //             title: RichText(
  //               text: TextSpan(
  //                   text: _suggestion[index][0].substring(0, str.length),
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.normal,
  //                       fontSize: 18,
  //                       color: Colors.black),
  //                   children: [
  //                     TextSpan(
  //                         text: _suggestion[index][0].substring(str.length),
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 18))
  //                   ]),
  //             ),
  //             //itemCount: _suggestion.length,
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    if (ch == false) {
      _width = MediaQuery.of(context).size.width;
      _cnclbtn = Colors.transparent;
      _overflow = 170;
    } else {
      _width = MediaQuery.of(context).size.width - 110;
      _cnclbtn = Provider.of<ThemeModel>(context).theme.Cancel_Button;
      _overflow = 504;
    }
    return OrientationBuilder(
      builder: (context, orientation) {
        return GestureDetector(
          onTap: () => {
            FocusManager.instance.primaryFocus?.unfocus(),
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor:
                Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
            appBar: appBar,
            drawer: AppDrawer(
              tag: 'Search User',
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {},
            // ),
            floatingActionButton: SpeedDial(
              overlayColor:
                  Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
              overlayOpacity: 0.2,
              backgroundColor: Colors.red,
              elevation: 10,
              curve: Curves.decelerate,
              children: <SpeedDialChild>[
                SpeedDialChild(
                  child: Icon(CupertinoIcons.person_3),
                  label: 'Search By Name',
                  labelStyle: TextStyle(color: Colors.black),
                  elevation: 5,
                  onTap: () {
                    if (what != 'name') {
                      setState(() {
                        what = 'name';
                        _controller.clear();
                        _cancel = Colors.transparent;
                        _suggestion = data;
                        strlen = 0;
                      });
                    }
                  },
                  labelBackgroundColor: Color(0xaaaaaaaa),
                ),
                SpeedDialChild(
                  child: Icon(CupertinoIcons.number),
                  label: 'Search By Kerberos',
                  labelStyle: TextStyle(color: Colors.black),
                  elevation: 5,
                  onTap: () {
                    if (what != 'kerberos') {
                      setState(() {
                        what = 'kerberos';
                        _controller.clear();
                        _cancel = Colors.transparent;
                        _suggestion = data;
                        strlen = 0;
                      });
                    }
                  },
                  labelBackgroundColor: Color(0xaaaaaaaa),
                ),
                // SpeedDialChild(
                //   child: Icon(CupertinoIcons.person_3),
                //   label: 'Serach By Entry Number',
                // )
              ],
              child: Icon(
                Icons.filter_alt,
                color:
                    Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          left: MediaQuery.of(context).size.width - 120,
                          top: 17,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                            //color: Colors.red,
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () => {
                                FocusManager.instance.primaryFocus?.unfocus(),
                                _controller.clear(),
                                setState(() {
                                  _cancel = Colors.transparent;
                                  _suggestion = data;
                                  strlen = 0;
                                }),
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: _cnclbtn,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            height: 45,
                            width: _width,
                            //color: Colors.red,
                            decoration: BoxDecoration(
                                //border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(11),
                                color: Provider.of<ThemeModel>(context)
                                    .theme
                                    .SEARCH_BG
                                //color: Color(0xffdddede),
                                ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Icon(
                                        CupertinoIcons.search,
                                        size: 20,
                                        color: Color(0xff88888d),
                                      )),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (String str) => {
                                        setState(() => {
                                              _cancel = str.isNotEmpty
                                                  ? Color(0xff88888d)
                                                  : Colors.transparent,
                                              _suggestion = str.isEmpty
                                                  ? data
                                                  : data
                                                      .where((element) => element[
                                                              (what ==
                                                                      'kerberos'
                                                                  ? 1
                                                                  : 0)]
                                                          .startsWith(str
                                                              .toLowerCase()))
                                                      .toList(),
                                              strlen = str.length,
                                            }),
                                      },
                                      controller: _controller,
                                      cursorWidth: 1,
                                      focusNode: _focus,
                                      cursorColor: Color(0xff88888d),
                                      enableInteractiveSelection: true,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              CupertinoIcons
                                                  .clear_circled_solid,
                                              color: _cancel,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              _controller.clear();
                                              setState(() {
                                                _cancel = Colors.transparent;
                                                _suggestion = data;
                                                strlen = 0;
                                              });
                                            },
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: 'Search by $what',
                                          hintStyle: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff88888d),
                                          )),
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 20,
                                          color:
                                              Provider.of<ThemeModel>(context)
                                                  .theme
                                                  .PRIMARY_TEXT_COLOR),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Divider(
                        color: Color(0xaa212121),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - _overflow,
                    child: ListView.builder(
                        itemCount: _suggestion.length,
                        itemBuilder: (context, index) => ListTile(
                              onTap: () {},
                              minLeadingWidth: 50,
                              leading: Icon(CupertinoIcons.person),
                              trailing: Text(
                                _suggestion[index][1],
                                style: TextStyle(color: Colors.grey),
                              ),
                              title: RichText(
                                text: TextSpan(
                                    text: _suggestion[index][0]
                                        .substring(0, strlen)
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      color: Provider.of<ThemeModel>(context)
                                          .theme
                                          .PRIMARY_TEXT_COLOR,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: _suggestion[index][0]
                                              .substring(strlen)
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ))
                                    ]),
                              ),
                              //itemCount: _suggestion.length,
                            )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
