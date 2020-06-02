import 'dart:async';
import 'dart:math';
import 'package:IITDAPP/utility/apiHelper.dart';
import 'package:IITDAPP/utility/apiResponse.dart';
import 'package:flutter/cupertino.dart';

class NewsModel<T extends NewsType> {
  String title;
  String author;
  int clicks;
  String contentLocal;
  DateTime createdAt;
  int id;
  String sourceName;
  String imgUrl;
  bool loadingContent = false;

  Future<void> add() {
    print('added ${title}');
    return Future.delayed(Duration(seconds: 1));
  }

  Future<void> update() {
    print('updated ${title}');
    return Future.delayed(Duration(seconds: 1));
  }

  Future<void> delete() {
    print('deleted ${title}');
    return Future.delayed(Duration(seconds: 1));
  }

  Future<String> get content async {
    if (!loadingContent) {
      if (contentLocal != null) {
        return Future<String>(() => contentLocal);
      } else {
        loadingContent = true;
        try {
          contentLocal = await ApiBaseHelper()
              .get(
                  'https://baconipsum.com/api/?type=meat-and-filler&paras=3&format=json')
              .then((value) {
            contentLocal = value.join('\n\n');
            loadingContent = false;
            return contentLocal;
          });
          return contentLocal;
        } catch (e) {
          loadingContent = false;
          return e.toString();
        }
      }
    } else {
      return null;
    }
  }

  factory NewsModel.fromMap(Map map) {
    return NewsModel<T>(
      author: map['author'],
      createdAt: DateTime.now(),
      clicks: map['clicks'],
      id: map['_id'],
      title: map['title'],
      imgUrl: map['imgUrl'],
      sourceName: map['sourceName'],
    );
  }

  NewsModel(
      {this.imgUrl,
      this.title,
      this.author,
      this.clicks,
      this.createdAt,
      this.id,
      this.sourceName});
}

class NewsType {
  static const baseUrl = '';
}

class RecentNews extends NewsType {
  static const baseUrl = '';
}

class TrendingNews extends NewsType {
  static const baseUrl = '';
}

class OldNews extends NewsType {
  static const baseUrl = '';
}

class NewsProvider<T extends NewsType> with ChangeNotifier {
  int maxNewsItems;
  final itemsPerPage = 4;
  List<bool> pageLoaded;
  List<bool> pageLoading;
  int pages;
  int pageAfterRefresh;

  ApiResponse<List<NewsModel<T>>> displayedData;
  List<NewsModel<T>> cacheData;

  ApiBaseHelper api = ApiBaseHelper();

  String baseUrl = '';

  NewsProvider() {
    Type typeOf<K>() => K;
    var type = typeOf<T>();
    if (type == typeOf<RecentNews>()) {
      baseUrl = RecentNews.baseUrl;
    } else if (type == typeOf<TrendingNews>()) {
      baseUrl = TrendingNews.baseUrl;
    }
    refresh();
  }

  Future<void> refresh([int page = 0]) {
    pageAfterRefresh = page;
    displayedData = ApiResponse.loading('');
    notifyListeners();
    return getMaxItems().then((value) {
      pages = (value - 1) ~/ itemsPerPage + 1;
      pageLoaded = List.generate(pages, (index) => false);
      pageLoading = List.generate(pages, (index) => false);
      cacheData = List.generate(value, (index) => null);
      loadPage(page);
      if (page != 0) {
        loadPage(0);
      }
    });
  }

  Future<int> getMaxItems() {
    return Future.delayed(Duration(seconds: 1), () => maxNewsItems = 30);
  }

  Future<void> loadPage(int pageNumber) async {
    if (!pageLoaded[pageNumber]) {
      pageLoading[pageNumber] = true;
      try {
        await _getExampleServerData(itemsPerPage).then((value) {
          cacheData.setRange(
              pageNumber * itemsPerPage,
              min(maxNewsItems, (pageNumber + 1) * itemsPerPage),
              value.map((e) => NewsModel<T>.fromMap(e)));
          displayedData = ApiResponse.completed(cacheData);
          pageLoaded[pageNumber] = true;
          pageLoading[pageNumber] = false;
          notifyListeners();
        });
      } catch (e) {
        print('here');
        pageLoading[pageNumber] = false;
        displayedData = ApiResponse.error(e.toString());
        notifyListeners();
        print('here${e.toString()}');
      }
    }
    return Future.value(null);
  }

  Future<List<Map>> _getExampleServerData(int length) async {
    print('loading...');
    var httpResponse;
    httpResponse = await api.get(
        'https://baconipsum.com/api/?type=meat-and-filler&sentences=1&format=json');
    var words = httpResponse[0].split(' ');
    return List<Map>.generate(length, (int index) {
      return {
        'author': words[(0 + index) % words.length],
        'clicks': words[(1 + index) % words.length].length,
        'id': words[(2 + index) % words.length].length,
        'title': httpResponse[0],
        'imgUrl':
            'https://api.adorable.io/avatars/80/${words[(4 + index) % words.length]}.png',
        'sourceName': words[(3 + index) % words.length],
      };
    });
  }
}
