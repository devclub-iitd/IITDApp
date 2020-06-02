import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final _imageUrlFocusNode = FocusNode();

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
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Author'),
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
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'title'),
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
                      decoration: InputDecoration(labelText: 'Content'),
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
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Source'),
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
                            ),
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
                              imageUrl: _imageUrlController.value.text,
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
  }) : _formKey = formKey, super(key: key);

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
            if (widget.title == 'Create') {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Uploading, Please Wait'),duration: Duration(seconds:2),));
              widget.nm.add().then((value) {
                    Provider.of<NewsProvider<TrendingNews>>(context,
                            listen: false)
                        .refresh();
                    Provider.of<NewsProvider<RecentNews>>(context,
                            listen: false)
                        .refresh();
                    }).then((value) => 
            Navigator.pop(context));
            } else if (widget.title == 'Update') {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Uploading, Please Wait'),duration: Duration(seconds:2),));
              widget.nm.update().then((value) {
                    Provider.of<NewsProvider<TrendingNews>>(context,
                            listen: false)
                        .refresh();
                    Provider.of<NewsProvider<RecentNews>>(context,
                            listen: false)
                        .refresh();
                    }).then((value) => 
            Navigator.pop(context));
            }
          }
        });
  }
}
