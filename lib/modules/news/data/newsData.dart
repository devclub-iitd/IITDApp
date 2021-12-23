// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:math';
import 'package:IITDAPP/modules/news/data/report.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:IITDAPP/utility/apiHelper.dart';
import 'package:IITDAPP/utility/apiResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsHistoryProvider with ChangeNotifier {
  final ls = LocalStorage('newsClickHistory${currentUser.id}');
  List newsHistory = [];

  static void clearHistory(bool clear) {
    print('cleared');
    final ls = LocalStorage('newsClickHistory${currentUser.id}');
    ls.ready.then((value) => ls.clear());
  }

  Future<bool> getViewed(id) async {
    if (currentUser == null) {
      return false;
    }
    await ls.ready
        .then((value) => newsHistory = (ls.getItem('newsID') ?? []) as List);
    return newsHistory.contains(id);
  }

  void setViewed(id) async {
    if (currentUser == null) {
      return;
    }
    await ls.ready;
    if (!(newsHistory.contains(id))) {
      newsHistory.add(id);
      await ls.setItem('newsID', newsHistory);
      notifyListeners();
    }
  }
}

class NewsModel<T extends NewsType> with ChangeNotifier {
  String title;
  String author;
  int clicks;
  String contentLocal;
  String createdBy;
  ApiResponse details;
  List<Report> reports;
  DateTime updatedAt;
  int version;
  DateTime createdAt;
  String id;
  String sourceName;
  String imgUrl;
  File newsImage;
  bool loadingContent = false;
  bool visible = true;
  double trendRate;

  Future<String> add() async {
    String returnMessage;
    try {
      var response = (await apiBaseHelper.post(
          NewsType.baseUrl, toJson(), newsImage)) as Map;
      // returnMessage = response['message'];
    } on FetchDataException catch (e) {
      returnMessage = e.toString();
    }
    return "returnMessage";
  }

  Future<String> update() async {
    String returnMessage;
    try {
      var response = (await apiBaseHelper.put(
          NewsType.baseUrl + '/$id', toJson(), newsImage)) as Map;
      // returnMessage = response['message'];
      notifyListeners();
    } on FetchDataException catch (e) {
      returnMessage = e.toString();
    }
    notifyListeners();
    return "returnMessage";
  }

  Future<String> report(List<String> report) async {
    var response = await http.post(NewsType.baseUrl + '/report/$id',
        headers: {'authorization': 'Bearer $token'},
        body: {'description': report.join('\n')});
    print("start report");
    print(response.statusCode);
    print(json.decode(response.body.toString()));

    response = await http.get(
      NewsType.baseUrl + '/$id',
      headers: {'authorization': 'Bearer $token'},
    );
    var tmp = json.decode(response.body)['reports'];
    print(tmp);
    reports.clear();
    for (var i = 0; i < tmp.length; i++) {
      reports.add(Report.fromJson(tmp[i]));
    }
    print(reports);
    return "returnMessage";
  }

  Future<String> delete() async {
    String returnMessage;
    try {
      var response =
          (await apiBaseHelper.delete(NewsType.baseUrl + '/$id')) as Map;
      returnMessage = response['message'];
    } on FetchDataException catch (e) {
      returnMessage = e.toString();
    }
    return returnMessage;
  }

  Future<String> hide() async {
    String returnMessage;
    try {
      var response = (await apiBaseHelper
          .get(NewsType.baseUrl + '/report/toggle/$id')) as Map;
      returnMessage = response['message'];
    } on FetchDataException catch (e) {
      returnMessage = e.toString();
    }
    return returnMessage;
  }

  void getDetails() async {
    print("called get details");
    if (contentLocal == null &&
        (details == null || details.status == Status.ERROR)) {
      details = ApiResponse.loading('message');
      try {
        Map detailsjson = await ApiBaseHelper().get(NewsType.baseUrl + '/$id');
        createdBy = detailsjson['createdBy'];
        contentLocal = detailsjson['content'];
        reports = <Report>[
          ...detailsjson['reports']
              .map((json) => Report.fromJson(json))
              .toList()
        ];
        version = detailsjson['__v'];
        updatedAt = DateTime.parse(detailsjson['updatedAt']);
        // trendRate = detailsjson['trendRate'];
        details = ApiResponse<String>.completed(contentLocal);
      } on FetchDataException catch (e) {
        details = ApiResponse.error(e.toString());
      }
      notifyListeners();
    }
  }

  factory NewsModel.fromMap(Map map) {
    print("from Map");
    print(T);
    print(map);
    return NewsModel<T>(
        author: map['author'],
        createdAt: DateTime.parse(map['createdAt']).add(Duration(minutes: 330)),
        clicks: map['clicks'],
        id: map['_id'],
        title: map['description'],
        imgUrl: uri + '/' + map['imgUrl'],
        // trendRate: map['trendRate'],
        sourceName: map['sourceName'],
        visible: map['visible'] ?? true,
        reports: <Report>[
          ...(map['reports'] ?? [])
              .map((json) => Report.fromJson(json))
              .toList()
        ]);
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'content': contentLocal,
      'description': title,
      'imgUrl': imgUrl,
      'sourceName': sourceName,
    };
  }

  NewsModel(
      {this.newsImage,
      this.imgUrl,
      this.title,
      this.author,
      this.clicks,
      this.createdAt,
      this.id,
      this.sourceName,
      this.visible,
      this.trendRate,
      this.reports});
}

class NewsType {
  static const baseUrl = '$uri/api/news';
}

class RecentNews extends NewsType {
  static const baseUrl = NewsType.baseUrl + '?sortBy=createdAt:desc';
}

class TrendingNews extends NewsType {
  static const baseUrl = NewsType.baseUrl + '/trend';
}

class OldNews extends NewsType {
  static const baseUrl = NewsType.baseUrl + '?sortBy=createdAt:asc';
}

class NewsProvider<T extends NewsType> with ChangeNotifier {
  int maxNewsItems;

  static int itemsPerPage;

  List<bool> pageLoaded;
  List<bool> pageLoading;
  int pages;
  int pageAfterRefresh;

  ApiResponse<List<NewsModel<T>>> displayedData =
      ApiResponse.loading('message');
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
    } else if (type == typeOf<OldNews>()) {
      baseUrl = OldNews.baseUrl;
    }
    refresh();
  }

  Future<void> refresh([int page = 0]) async {
    NewsProvider.itemsPerPage =
        int.parse(await SettingsHandler.getSettingValue('newsItemPerPage'));
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

  Future<int> getMaxItems() async {
    try {
      print("trying max items " + T.toString() + " " + baseUrl);
      maxNewsItems = (await apiBaseHelper.get(baseUrl)).length;
    } on FetchDataException catch (e) {
      displayedData = ApiResponse.error(e.toString());
      notifyListeners();
    }
    return maxNewsItems ?? 0;
  }

  Future<void> loadPage(int pageNumber) async {
    Type typeOf<K>() => K;
    if (pageNumber > maxNewsItems) {
      return;
    }
    if (!pageLoaded[pageNumber]) {
      pageLoading[pageNumber] = true;
      try {
        await apiBaseHelper
            .get(baseUrl +
                ((typeOf<T>() == typeOf<TrendingNews>()) ? '?' : '&') +
                'limit=$itemsPerPage&skip=${itemsPerPage * pageNumber}')
            .then((value) {
          // print([...value]);
          print("making news list");
          var newsList = (<NewsModel<T>>[
            ...value.map((e) => NewsModel<T>.fromMap(e)).toList()
          ]);
          print("making news list done");
          cacheData.setRange(pageNumber * itemsPerPage,
              min(maxNewsItems, (pageNumber + 1) * itemsPerPage), newsList);
          displayedData = ApiResponse.completed(cacheData);
          pageLoaded[pageNumber] = true;
          pageLoading[pageNumber] = false;
          notifyListeners();
        });
      } catch (e) {
        pageLoading[pageNumber] = false;
        displayedData = ApiResponse.error(e.toString());
        notifyListeners();
        print(e.toString());
      }
    }
    return Future.value(null);
  }

  // Future<List<Map>> _getExampleServerData(int length) async {
  //   print('loading...');
  //   var httpResponse;
  //   httpResponse = await api.get(
  //       'https://baconipsum.com/api/?type=meat-and-filler&sentences=1&format=json');
  //   var words = httpResponse[0].split(' ');
  //   return List<Map>.generate(length, (int index) {
  //     return {
  //       'author': words[(0 + index) % words.length],
  //       'clicks': words[(1 + index) % words.length].length,
  //       '_id': words[(2 + index) % words.length],
  //       'title': httpResponse[0],
  //       'imgUrl':
  //           'https://api.adorable.io/avatars/80/${words[(4 + index) % words.length]}.png',
  //       'sourceName': words[(3 + index) % words.length],
  //     };
  //   });
  // }
}
