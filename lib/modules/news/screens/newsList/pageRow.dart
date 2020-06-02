import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:IITDAPP/modules/news/data/pageCarouselIndex.dart';

class PageNumberRow extends StatefulWidget {
  const PageNumberRow({
    Key key,
    this.width,
  }) : super(key: key);

  final width;
  @override
  _PageNumberRowState createState() => _PageNumberRowState();
}

class _PageNumberRowState extends State<PageNumberRow> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final isc = Provider.of<PageCarouselIndex>(context, listen: false).isc;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50.0,
        vertical: 5,
      ),
      child: SizedBox(
        width: widget.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            PageRowMoveLeft(),
            SizedBox(
              width: widget.width - 196,
              height: 50,
              child: ScrollablePositionedList.builder(
                  initialScrollIndex: Provider.of<PageCarouselIndex>(context, listen: false).current,
                  itemScrollController: isc,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      Provider.of<PageCarouselIndex>(context, listen: false)
                          .pages,
                  itemBuilder: (bc, index) => PageNumberButton(
                      index: index,
                      onTap: () {
                        Provider.of<PageCarouselIndex>(context, listen: false)
                            .setCurrent(index);
                      })),
            ),
            PageRowMoveRight(),
          ],
        ),
      ),
    );
  }
}

class PageRowMoveRight extends StatelessWidget {
  const PageRowMoveRight({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pci = Provider.of<PageCarouselIndex>(context);
    return IconButton(
        icon: Icon(Icons.chevron_right),
        onPressed: (pci.current == pci.pages - 1)
            ? null
            : () {
                pci.moveRight();
              });
  }
}

class PageRowMoveLeft extends StatelessWidget {
  const PageRowMoveLeft({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pci = Provider.of<PageCarouselIndex>(context);
    return IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: (pci.current == 0)
            ? null
            : () {
                pci.moveLeft();
              });
  }
}

class PageNumberButton extends StatelessWidget {
  const PageNumberButton({
    Key key,
    @required this.index,
    @required this.onTap,
  }) : super(key: key);

  final int index;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            decoration: BoxDecoration(
                color: Provider.of<PageCarouselIndex>(context).current == index
                    ? Colors.grey
                    : null,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                '${index + 1}',
                style: TextStyle(fontSize: 20),
              ),
            ))));
  }
}
