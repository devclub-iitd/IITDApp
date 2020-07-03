import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/explore/data/ClubsData.dart';
import 'package:IITDAPP/utility/UrlHandler.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AboutScreen extends StatelessWidget {
  AboutScreen({Key key, this.name, this.obj, this.hideFabs = false})
      : super(key: key);
  var name;
  var obj;
  bool hideFabs;
  @override
  Widget build(BuildContext context) {
    var data = obj == null ? clubsDetails[name] : obj[name];
    print(data);
    return Scaffold(
        appBar: CustomAppBar(
          title: Text(name),
          withMenu: false,
        ),
        floatingActionButton: !hideFabs ? SpeedDialSection() : null,
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
                        child: Image.asset(data['image']),
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
                          ),
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

class SpeedDialSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpeedDial(
        heroTag: null,
        animatedIcon: AnimatedIcons.menu_close,
        elevation: 5,
        children: [
          SpeedDialChild(
              child: Center(
                child: FaIcon(FontAwesomeIcons.facebook),
              ),
              label: 'Visit FB Page',
              labelStyle: TextStyle(color: Colors.black)),
          SpeedDialChild(
              child: Center(
                child: FaIcon(FontAwesomeIcons.instagram),
              ),
              label: 'View Insta page',
              labelStyle: TextStyle(color: Colors.black)),
          SpeedDialChild(
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
              labelStyle: TextStyle(color: Colors.black)),
        ],
      ),
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
      color: Provider.of<ThemeModel>(context).theme.TITLE_UNDERLINE,
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
              child: Image.asset(data.image),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomSocialMediaButton(
                        icon: FontAwesomeIcons.instagram,
                      ),
                      CustomSocialMediaButton(
                        icon: FontAwesomeIcons.facebook,
                      ),
                      CustomSocialMediaButton(
                        icon: FontAwesomeIcons.linkedinIn,
                      )
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
            'UPCOMING EVENTS',
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
  MembersSection({this.data});
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
          padding: const EdgeInsets.only(top: 24.0),
          child: Text(
            'MEMBERS',
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
  CustomSocialMediaButton({this.icon});
  var icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 35,
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {},
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
      child: ListTile(
        leading: ClipOval(
          child: Image.asset(data.image),
        ),
        title: Text(
          data.title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        subtitle: Text(
          data.note,
          style: TextStyle(
              color: Color.fromARGB(255, 240, 240, 240), fontSize: 15),
        ),
      ),
    );
  }
}
