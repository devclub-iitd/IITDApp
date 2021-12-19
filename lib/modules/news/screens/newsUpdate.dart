import 'package:IITDAPP/modules/news/utility/showSnackBarResult.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/newsImage.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/widgets/shimmers/sizedShimmer.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/cancel_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class NewsUpdate extends StatefulWidget {
  final String title;
  final NewsModel nm;

  const NewsUpdate({Key key, this.title, this.nm}) : super(key: key);
  @override
  _NewsUpdateState createState() => _NewsUpdateState();
}

class _NewsUpdateState extends State<NewsUpdate> {
  final _formKey = GlobalKey<FormState>();
  var img;
  final _imageUrlController = TextEditingController();
  final _authorFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();
  final _sourceFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _changeImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageUrlController.text = widget.nm.imgUrl;
    _imageUrlController.addListener(_changeImageUrl);
    support();
    super.initState();
  }

  void support() async {
    var ok = Random();
    var bytes = await http.get(widget.nm.imgUrl);
    String temp = (await getTemporaryDirectory()).path;
    File file = File('$temp/newsimg' +
        ok.nextInt(1000).toString() +
        ok.nextInt(1000).toString() +
        ok.nextInt(1000).toString() +
        '.png');

    await file.writeAsBytes(bytes.bodyBytes);
    widget.nm.newsImage = file;
    setState(() {});
  }

  Future pickImage(int crr) async {
    try {
      print("picking image");
      var image = await ImagePicker.pickImage(
          source: (crr == 0 ? ImageSource.camera : ImageSource.gallery));
      if (image == null) {
        return null;
      }
      final perm = File(image.path);
      // final perm = await Perm(image.path);
      setState(() => {img = perm, widget.nm.newsImage = perm});
    } on PlatformException catch (e) {
      print('failed to pick img $e');
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.dispose();
    _authorFocusNode.dispose();
    _titleFocusNode.dispose();
    _sourceFocusNode.dispose();
    _contentFocusNode.dispose();
    // img.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Provider.of<ThemeModel>(context,listen:false).theme.SCAFFOLD_BACKGROUND,
      appBar: CustomAppBar(
        withMenu: false,
        title: Text(widget.title),
        actions: <Widget>[
          TickButton(formKey: _formKey, widget: widget),
          IconButton(
              icon: Icon(Icons.close), onPressed: () => Navigator.pop(context))
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: TextFormField(
                      focusNode: _authorFocusNode,
                      onFieldSubmitted: (s) => _fieldFocusChange(
                          context, _authorFocusNode, _titleFocusNode),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Author',
                          labelStyle: TextStyle(
                              color: _authorFocusNode.hasFocus
                                  ? Colors.blue
                                  : Provider.of<ThemeModel>(context,
                                          listen: false)
                                      .theme
                                      .PRIMARY_TEXT_COLOR
                                      .withOpacity(0.5))),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the author\'s name';
                        }
                        return null;
                      },
                      initialValue: widget.nm.author,
                      onSaved: (val) {
                        setState(() {
                          widget.nm.author = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: TextFormField(
                      focusNode: _titleFocusNode,
                      onFieldSubmitted: (s) => _fieldFocusChange(
                          context, _titleFocusNode, _contentFocusNode),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'title',
                          labelStyle: TextStyle(
                              color: _titleFocusNode.hasFocus
                                  ? Colors.blue
                                  : Provider.of<ThemeModel>(context,
                                          listen: false)
                                      .theme
                                      .PRIMARY_TEXT_COLOR
                                      .withOpacity(0.5))),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the title';
                        }
                        return null;
                      },
                      initialValue: widget.nm.title,
                      onSaved: (val) {
                        setState(() {
                          widget.nm.title = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: TextFormField(
                      focusNode: _contentFocusNode,
                      onFieldSubmitted: (s) => _fieldFocusChange(
                          context, _contentFocusNode, _sourceFocusNode),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Content',
                          labelStyle: TextStyle(
                              color: _contentFocusNode.hasFocus
                                  ? Colors.blue
                                  : Provider.of<ThemeModel>(context,
                                          listen: false)
                                      .theme
                                      .PRIMARY_TEXT_COLOR
                                      .withOpacity(0.5))),
                      minLines: 1,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the content';
                        }
                        return null;
                      },
                      initialValue: widget.nm.contentLocal,
                      onSaved: (val) {
                        setState(() {
                          widget.nm.contentLocal = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: TextFormField(
                      focusNode: _sourceFocusNode,
                      onFieldSubmitted: (s) => _fieldFocusChange(
                          context, _sourceFocusNode, _imageUrlFocusNode),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Source',
                          labelStyle: TextStyle(
                              color: _sourceFocusNode.hasFocus
                                  ? Colors.blue
                                  : Provider.of<ThemeModel>(context,
                                          listen: false)
                                      .theme
                                      .PRIMARY_TEXT_COLOR
                                      .withOpacity(0.5))),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the source name';
                        }
                        return null;
                      },
                      initialValue: widget.nm.sourceName,
                      onSaved: (val) {
                        setState(() {
                          widget.nm.sourceName = val;
                        });
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.end,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: TextFormField(
                  //           keyboardType: TextInputType.url,
                  //           decoration: InputDecoration(
                  //               labelText: 'Image URL',
                  //               labelStyle: TextStyle(
                  //                   color: _imageUrlFocusNode.hasFocus
                  //                       ? Colors.blue
                  //                       : Provider.of<ThemeModel>(context,
                  //                               listen: false)
                  //                           .theme
                  //                           .PRIMARY_TEXT_COLOR
                  //                           .withOpacity(0.5))),
                  //           onTap: () {
                  //             print('call');
                  //             setState(() {});
                  //           },
                  //           focusNode: _imageUrlFocusNode,
                  //           validator: (val) {
                  //             if (val.isEmpty) {
                  //               return 'Please enter an image url';
                  //             }
                  //             return null;
                  //           },
                  //           //TODO: on field submitted
                  //           controller: _imageUrlController,
                  //           onSaved: (val) {
                  //             setState(() {
                  //               widget.nm.imgUrl = val;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //             border: Border.all(width: 2, color: Colors.grey)),
                  //         margin: EdgeInsets.only(top: 5, left: 5),
                  //         height: 100,
                  //         width: 100,
                  //         child: CachedNetworkImage(
                  //             placeholder: (_, s) =>
                  //                 SizedShimmer(width: null, height: null),
                  //             imageUrl: _imageUrlController.value.text ??
                  //                 defaultImage,
                  //             fit: BoxFit.cover),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Row(
                    children: [
                      Container(
                        // color: Colors.red,
                        margin: EdgeInsets.fromLTRB(10, 20, 0, 50),
                        child: Column(
                          children: [
                            Card(
                              // color: Colors.grey.shade900,
                              color: Provider.of<ThemeModel>(context)
                                  .theme
                                  .RAISED_BUTTON_BACKGROUND,
                              elevation: 10,
                              shadowColor: Colors.grey.shade900.withBlue(10),
                              child: Container(
                                // color: Colors.red,
                                width: 140,
                                padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                                child: TextButton(
                                  onPressed: () => pickImage(0),
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.camera,
                                        size: 24,
                                        // color: Colors.grey.shade600,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Open Camera",
                                        style: TextStyle(
                                          //color: Colors.grey.shade600
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(height: 10),
                            Card(
                              elevation: 10,
                              color: Provider.of<ThemeModel>(context)
                                  .theme
                                  .RAISED_BUTTON_BACKGROUND,
                              // color: Colors.cyan.shade300,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                width: 140,
                                child: TextButton(
                                  onPressed: () => pickImage(1),
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.square_on_square,
                                        size: 24,
                                        // color: Colors.grey.shade600,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Open Gallery",
                                        style: TextStyle(
                                          //color: Colors.grey.shade600
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        // color: Colors.blue,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        height: 150,
                        width: 200,
                        child: widget.nm.newsImage != null
                            ? Image.file(
                                widget.nm.newsImage,
                              )
                            : Image.asset(
                                'assets/images/null.png',
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TickButton extends StatelessWidget {
  const TickButton({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.widget,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final NewsUpdate widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.check),
        onPressed: () {
          final form = _formKey.currentState;
          if (form.validate()) {
            form.save();
            var updateFunc =
                widget.title == 'Create' ? widget.nm.add : widget.nm.update;
            showSnackbarResult('Uploading, please wait', Scaffold.of(context));
            updateFunc().then((value) {
              Provider.of<NewsProvider<TrendingNews>>(context, listen: false)
                  .refresh();
              Provider.of<NewsProvider<RecentNews>>(context, listen: false)
                  .refresh();
              Navigator.pop(context, value);
              if (widget.title != 'Create') {
                Navigator.pop(context);
              }
            });
          }
        });
  }
}
