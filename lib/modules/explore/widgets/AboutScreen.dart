import 'package:IITDAPP/modules/explore/data/ClubsData.dart';
import 'package:IITDAPP/utility/UrlHandler.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class AboutScreen extends StatelessWidget {
  AboutScreen(
      {Key key,
      this.name,
      this.obj,
      this.hideFabs = false,
      this.isHostel = false})
      : super(key: key);
  var name;
  var obj;
  bool hideFabs;
  bool isHostel;
  @override
  Widget build(BuildContext context) {
    var data = obj == null ? clubsDetails[name] : obj[name];
    print(data);
    return Scaffold(
        appBar: CustomAppBar(
          title: Text(name),
          withMenu: false,
        ),
        floatingActionButton: !hideFabs
            ? isHostel
                ? FloatingActionButton(
                    onPressed: () {
                      UrlHandler.launchInBrowser(data['loc']);
                    },
                    child: Transform.rotate(
                      angle: 45 * math.pi / 180,
                      child: Icon(
                        Icons.navigation,
                      ),
                    ),
                    // child: Transform.rotate(
                    //   angle: 45 * math.pi / 180,
                    //   child: IconButton(
                    //     icon: Icon(
                    //       Icons.details,
                    //       color: Colors.white,
                    //     ),
                    //     onPressed: null,
                    //   ),
                    // ),
                  )
                : SpeedDialSection(links: data)
            : null,
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width:
                          double.infinity, //MediaQuery.of(context).size.width,
//                    height: Image.asset(data['image']).height/2,
                      color: Colors.red,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: (data['image'] as String).startsWith('http')
                            ? CachedNetworkImage(
                                imageUrl: data['image'],
                              )
                            : Image.asset(data['image']),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, left: 20, right: 15, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ABOUT',
                            style: GoogleFonts.arvo(
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                          ),
                          CustomTextDec(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              data['about'],
                              style: GoogleFonts.openSans(fontSize: 18),
                            ),
                          ),
                          EventsSection(
                            data: data['events'],
                          ),
                          MembersSection(
                              data: data['members'],
                              title: isHostel ? 'Alumni' : 'Members'),
                          data['loc'] != null
                              ? LinksSection(urls: data)
                              : Container(),
                        ],
                      ),
                    )
                  ]),
            ),
          );
        }));
  }
}

// ignore: must_be_immutable
class SpeedDialSection extends StatelessWidget {
  SpeedDialSection({this.links});
  var links;

  @override
  Widget build(BuildContext context) {
    getChildren() {
      var list = <SpeedDialChild>[];
      if (links == []) {
        return [];
      }
      if (links == null) {
        return [];
      }
      if (links['facebook'] != '') {
        list.add(SpeedDialChild(
            onTap: () {
              UrlHandler.launchInBrowser(links['facebook']);
            },
            child: Center(
              child: FaIcon(FontAwesomeIcons.facebook),
            ),
            label: 'Visit FB Page',
            labelStyle: TextStyle(color: Colors.black)));
      }
      if (links['insta'] != '') {
        list.add(SpeedDialChild(
            onTap: () {
              UrlHandler.launchInBrowser(links['insta']);
            },
            child: Center(
              child: FaIcon(FontAwesomeIcons.instagram),
            ),
            label: 'Visit Insta Page',
            labelStyle: TextStyle(color: Colors.black)));
      }
      if (links['linkedin'] != '') {
        list.add(SpeedDialChild(
            onTap: () {
              UrlHandler.launchInBrowser(links['linkedin']);
            },
            child: Center(
              child: FaIcon(FontAwesomeIcons.linkedinIn),
            ),
            label: 'Visit LinkedIn Profile',
            labelStyle: TextStyle(color: Colors.black)));
      }
      if (links['web'] != '') {
        list.add(SpeedDialChild(
            onTap: () {
              UrlHandler.launchInBrowser(links['web']);
            },
            child: Center(
              child: Transform.scale(
                scale: 0.5,
                child: SvgPicture.asset(
                  'assets/images/visit_web.svg',
                  color: Colors.black,
                ),
              ),
            ),
            label: 'Visit Website',
            labelStyle: TextStyle(color: Colors.black)));
      }

      return list;
    }

    return Container(
      child: SpeedDial(
          heroTag: null,
          animatedIcon: AnimatedIcons.menu_close,
          elevation: 5,
          children: getChildren()),
    );
  }
}

// ignore: must_be_immutable
class LinksSection extends StatelessWidget {
  LinksSection({this.urls});
  var urls;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 64.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                UrlHandler.launchInBrowser(urls['loc']);
              },
              child: Icon(Icons.location_on),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                UrlHandler.makePhoneCall(urls['phone']);
              },
              child: Icon(Icons.phone),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                UrlHandler.launchInBrowser(urls['website']);
              },
              child: Center(
                child: Transform.scale(
                  scale: 0.5,
                  child: SvgPicture.asset(
                    'assets/images/visit_web.svg',
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextDec extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: 80,
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.blue,
    );
  }
}

// ignore: must_be_immutable
class MemberCard extends StatelessWidget {
  MemberCard({this.data});
  var data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 120,
      color: Colors.blueAccent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            child: ClipOval(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: data.image.toString().startsWith('http')
                            ? CachedNetworkImageProvider(data.image)
                            : AssetImage(data
                                .image) //Image.network(data.image):Image.asset(data.image)
                        )),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 4),
                      child: Text(
                        data.name,
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        data.post,
                        style: GoogleFonts.literata(
                            color: Colors.redAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // data.insta!=null && data.insta!=''?
                      // CustomSocialMediaButton(
                      //   icon: FontAwesomeIcons.instagram,
                      //   url: data.insta,
                      // ):Container(),
                      // data.fb!=null && data.fb!=''?
                      // CustomSocialMediaButton(
                      //   icon: FontAwesomeIcons.facebook,
                      //   url: data.fb,
                      // ):Container(),
                      FloatingActionButton.extended(
                        // tag: data.name,
                        heroTag: null,
                        onPressed: () {
                          UrlHandler.launchInBrowser(data.info);
                        },
                        label: Text('See More'),
                        // icon: FaIcon(FontAwesomeIcons.solidArrowAltCircleRight),
                      ),
                      // InkWell(
                      //
                      //   child: Text(
                      //     'See More',style: TextStyle(color: Colors.black,decorationColor: Colors.black,decorationStyle: TextDecorationStyle.solid),
                      //   ),

                      // data.linkedin!=null && data.linkedin!=''?
                      // CustomSocialMediaButton(
                      //   icon: FontAwesomeIcons.linkedinIn,
                      //   url: data.linkedin,
                      // ):Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class EventsSection extends StatelessWidget {
  EventsSection({this.data});
  var data;

  @override
  Widget build(BuildContext context) {
    if (data == null || data.length == 0) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 48.0),
          child: Text(
            'SHOWCASE',
            style: GoogleFonts.arvo(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        CustomTextDec(),
        ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24.0, horizontal: 2),
                child: EventCard(
                  data: data[index],
                ),
              );
            }),
      ],
    );
  }
}

// ignore: must_be_immutable
class MembersSection extends StatelessWidget {
  MembersSection({this.data, this.title});
  var data;
  String title;
  @override
  Widget build(BuildContext context) {
    if (data == null || data.length == 0) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text(
            title.toUpperCase(),
            style: GoogleFonts.arvo(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        CustomTextDec(),
        ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24.0, horizontal: 2),
                child: MemberCard(
                  data: data[index],
                ),
              );
            }),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomSocialMediaButton extends StatelessWidget {
  CustomSocialMediaButton({this.icon, this.url = ''});
  var icon;
  var url;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 35,
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          url != '' ? UrlHandler.launchInBrowser(url) : null;
        },
        child: FaIcon(
          icon,
          size: 20,
          color: Colors.black87,
        ),
        backgroundColor: Color.fromARGB(255, 200, 189, 176),
      ),
    );
  }
}

// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  EventCard({this.data});
  var data;

  @override
  Widget build(BuildContext context) {
    print(data);
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        boxShadow: [
          BoxShadow(
              color: Colors.blueAccent,
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset.fromDirection(90, 1))
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: ListTile(
          leading: ClipOval(
            child: Image.asset(data.image),
          ),
          title: Text(
            data.title,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          // subtitle: Text(
          //   data.note,
          //   style:
          //       TextStyle(color: Color.fromARGB(255, 240 , 240, 240), fontSize: 15),
          // ),
        ),
      ),
    );
  }
}
