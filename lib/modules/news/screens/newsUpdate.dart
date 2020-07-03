import 'package:IITDAPP/modules/news/utility/showSnackBarResult.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/widgets/shimmers/sizedShimmer.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';

class NewsUpdate extends StatefulWidget {
  final String title;
  final NewsModel nm;

  const NewsUpdate({Key key, this.title, this.nm}) : super(key: key);
  @override
  _NewsUpdateState createState() => _NewsUpdateState();
}

class _NewsUpdateState extends State<NewsUpdate> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  void initState() {
    _imageUrlController.text = widget.nm.imgUrl;
    _imageUrlController.addListener(_changeImageUrl);
    super.initState();
  }

  void _changeImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.dispose();
    _authorFocusNode.dispose();
    _titleFocusNode.dispose();
    _sourceFocusNode.dispose();
    _contentFocusNode.dispose();
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                                labelText: 'Image URL',
                                labelStyle: TextStyle(
                                    color: _imageUrlFocusNode.hasFocus
                                        ? Colors.blue
                                        : Provider.of<ThemeModel>(context,
                                                listen: false)
                                            .theme
                                            .PRIMARY_TEXT_COLOR
                                            .withOpacity(0.5))),
                            onTap: () {
                              print('call');
                              setState(() {});
                            },
                            focusNode: _imageUrlFocusNode,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Please enter an image url';
                              }
                              return null;
                            },
                            //TODO: on field submitted
                            controller: _imageUrlController,
                            onSaved: (val) {
                              setState(() {
                                widget.nm.imgUrl = val;
                              });
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.grey)),
                          margin: EdgeInsets.only(top: 5, left: 5),
                          height: 100,
                          width: 100,
                          child: CachedNetworkImage(
                              placeholder: (_, s) =>
                                  SizedShimmer(width: null, height: null),
                              imageUrl: _imageUrlController.value.text ??
                                  defaultImage,
                              fit: BoxFit.cover),
                        )
                      ],
                    ),
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
            });
          }
        });
  }
}
