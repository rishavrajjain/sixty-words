import 'dart:async';
import 'dart:convert';

import 'base_bloc.dart';
import 'news.model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class NewsBloc implements BaseBloc {
  BehaviorSubject<bool> loadingController = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<bool> likeLoadingController =
      BehaviorSubject<bool>.seeded(false);
  List<News> allMyPosts = [];
  //List<News> news = [];
  StreamController<bool> reloadController = StreamController<bool>.broadcast();
  StreamController<bool> myPostsReloadController =
      StreamController<bool>.broadcast();
  // StreamController<GetMyPostsResponse> getMyPostsController =
  //     StreamController<GetMyPostsResponse>.broadcast();
  int feedLength;
  int pageCount = 0;
  bool showYouAreAllCaughtUp = false;
  bool apiCalled = false;
  News news;
  int skip = 0;
  int currentPage = 0;

  List<String> tags;
  String id;
  String title;
  String content;
  String author;
  String image;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  // Function to get feed posts

  //Function to get feed posts
  getMyPosts({int skip = 0, int limit = 20, bool showLoader = true}) async {
    // SocialEvents.getMoreData('MY POSTS', skip, null);
    // if (showLoader) {
    //   loadingController.add(true);
    // }
    // apiCalled = true;
    // ApiState<dynamic> state = await communityRepository.getMyPosts(
    //   myPostsInput: MyPostsInput(
    //     skip: skip,
    //     limit: limit,
    //   ),
    // );
    // if (state is SuccessState) {
    //   if (skip + limit > allMyPosts.length) {
    //     allMyPosts.insertAll(
    //         allMyPosts.length, state.value.getMyPosts as List<Post>);
    //   } else {
    //     allMyPosts.insertAll(skip, state.value.getMyPosts as List<Post>);
    //   }

    loadingController.add(false);
    // allPostsController.add(state.value.getMyPosts);
    //getMyPostsController.sink.add(state.value);
    // } else if (state is ErrorState) {
    //   print(state.error);
    //   loadingController.sink.addError(state.error);
    // }
    // apiCalled = false;
  }

  Future<void> getData(
      {int skip = 0, int limit = 20, bool showLoader = true}) async {
    if (showLoader) {
      loadingController.add(true);
    }
    try {
      print('H0');
      // Response response =
      //     await get('https://news-app-finance.herokuapp.com/api/news');
      // Map<String, dynamic> map = json.decode(response.body);
      // List<dynamic> data = map["news"];
      // //allMyPosts.addAll(data[0]);
      // print(data.length);
      // print('H2');
      // print(data[1]["title"]);

      var response = await http.get(Uri.https('news-app-us.herokuapp.com',
          '/api/news', {"skip": "$skip", "limit": "$limit"}));

      var jsonData = jsonDecode(response.body);
      print('H1');
      if (jsonData.isEmpty || jsonData.length<20) {
        print('Thankyouuu');
        
      }
      for (var u in jsonData) {
        news = News(
          tags: u["tags"],
          id: u["id"],
          title: u["title"],
          content: u["content"],
          author: u["author"],
          image: u["image"],
          url: u["url"],
          createdAt: u["createdAt"],
          updatedAt: u["updatedAt"],
        );
        print('BROOO');
        newsBloc.allMyPosts.add(news);
        print(newsBloc.allMyPosts.length);
      }
    } catch (e) {
      print(e);
    }
    if (showLoader) {
      loadingController.add(false);
    }
  }

  @override
  void dispose() {
    likeLoadingController?.close();
    loadingController?.close();
    reloadController?.close();
    myPostsReloadController?.close();
  }
}

final NewsBloc newsBloc = NewsBloc();
