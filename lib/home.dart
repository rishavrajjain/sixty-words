import 'package:flutter/material.dart';
import 'news_bloc.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'news_card.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController ctrl = PageController();
  List<Widget> cardList;
  static GlobalKey previewContainer = new GlobalKey();
  bool boolTrue = true;
  int length = 7;
  final PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    //newsBloc.getData();
    //cardList = _getMatchCard();
  }

  @override
  Widget build(BuildContext context) {
    print("HEYYYY");
    return RepaintBoundary(
      key: previewContainer,
      child: PageView.builder(
        pageSnapping: true,
        scrollDirection: Axis.vertical,
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          print('KKKK');
          print(index);
          print(newsBloc.allMyPosts.length);
          if (index < newsBloc.allMyPosts.length - 1) {
            if (index == newsBloc.allMyPosts.length - 3) {
              newsBloc.skip = newsBloc.skip + 20;
              newsBloc.getData(skip: newsBloc.skip, showLoader: false);
            }
            return Container(
              height: MediaQuery.of(context).size.height - 80,
              child: NewsCard(
                index: index,
              ),
            );
          }
        },
      ),
    );
  }

  // List<Widget> _getMatchCard() {
  //   List<Widget> cards = new List();

  //   cards.add(MatchCard2(i: 4));
  //   cards.add(MatchCard2(i: 7));
  //   cards.add(MatchCard2(i: 8));
  //   cards.add(MatchCard2(i: 0));
  //   cards.add(MatchCard2(i: 3));
  //   cards.add(MatchCard2(i: 1));
  //   cards.add(MatchCard2(i: 2));

  //   return cards;
  // }

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

  void undoDeletion(index, item) {
    setState(() {
      cardList.insert(index, item);
    });
  }
}
