import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sixty_words/thankyou.dart';
import 'home.dart';
import 'news_bloc.dart';
import 'shimmer.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class CardEntry extends StatefulWidget {
  @override
  _CardEntryState createState() => _CardEntryState();
}

class _CardEntryState extends State<CardEntry> {
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
            return RepaintBoundary(
              child: MyHomePage(),
              key: previewContainer,
            );
          }
        },
      ),
    );
  }

  takeScreenShot() async {
    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    await Share.file(
        'newsshorts image', 'newsshorts.png', pngBytes, 'image/png',
        text: 'Download the app now.');
  }
}
