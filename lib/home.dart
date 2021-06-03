import 'package:flutter/material.dart';
import 'news_bloc.dart';
import 'news_card.dart';
import 'package:flutter/rendering.dart';

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
    return PageView.builder(
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
        return Container();
      },
    );
  }


  void undoDeletion(index, item) {
    setState(() {
      cardList.insert(index, item);
    });
  }
}
