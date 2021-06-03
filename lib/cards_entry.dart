import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'home.dart';
import 'news_bloc.dart';
import 'shimmer.dart';
import 'package:flutter/rendering.dart';

class CardEntry extends StatefulWidget {
  @override
  _CardEntryState createState() => _CardEntryState();
}

class _CardEntryState extends State<CardEntry> {
  final screenshotController = ScreenshotController();
  static GlobalKey previewContainer = new GlobalKey();
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onBackgroundMessage((message) {
      print('onBackgroundMessage');
      newsBloc.getSingleData(newsId: message.data['newsId'].toString());
      Navigator.push(context, MaterialPageRoute(builder: (_) => CardEntry()));
      print(message);
      return;
    });
    FirebaseMessaging.onMessage.listen((message) {
      print('onMessage');
      newsBloc.getSingleData(newsId: message.data['newsId'].toString());
      print(message);
      Navigator.push(context, MaterialPageRoute(builder: (_) => CardEntry()));
      return;
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('onMessageOpenedApp');
      newsBloc.getSingleData(newsId: message.data['newsId'].toString());
      Navigator.push(context, MaterialPageRoute(builder: (_) => CardEntry()));
      return;
    });
    getToken();
    print("I AM BEING CALEED");
    newsBloc.getData();
    //cardList = _getMatchCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("True Shorts"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(Icons.share), onPressed: () => takeScreenShot()),
          )
        ],
      ),
      body: StreamBuilder(
        stream: newsBloc.loadingController.stream,
        builder: (BuildContext context, snapshot) {
          // print('Here');
          // print(snapshot.data);
          if (snapshot.hasError) {
            return Text('Error');
          } else if (!snapshot.hasData || snapshot.data) {
            return buildExploreShimmerEffect(context);
          } else if (snapshot.hasData && !snapshot.data) {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (_) => ClassListScreen()));
            // return Container();
            return Screenshot(
              controller: screenshotController,
              child: MyHomePage(),
              key: previewContainer,
            );
          }
          return Container();
        },
      ),
    );
  }

  takeScreenShot() async {
    final uint8List = await screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/image.png');
    await file.writeAsBytes(uint8List);
    await Share.shareFiles([file.path],
        text: 'Download FinTicks App today for faster news');
  }

  getToken() async {
    String token = await FirebaseMessaging.instance.getToken();
    print('the token');
    print(token);
  }
}
