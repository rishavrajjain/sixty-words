import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'news_bloc.dart';
import 'news.model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatefulWidget {
  int index;
  NewsCard({this.index});
  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    News currentNews = newsBloc.allMyPosts[widget.index];
    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
        if (dragEndDetails.primaryVelocity < 0) {
          // Page forwards
          print('Move page forwards');
          _launchURL(currentNews.url);
        } else if (dragEndDetails.primaryVelocity > 0) {
          // Page backwards
          print('Move page backwards');
        }
      },
      child: Card(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              //     child: Stack(

              //  children: <Widget>[
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: currentNews.image != null
                      ? FadeInImage(
                          image: NetworkImage(
                            currentNews.image,
                          ),
                          fit: BoxFit.cover,
                          placeholder: AssetImage('images/img3.jpg'),
                        )
                      : Image.asset('images/img3.jpg',
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode
                              .modulate) //Center(child: CircularProgressIndicator()),
                  ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                    child: currentNews.title != null
                        ? Text(currentNews.title,
                            style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white))
                        : Center(child: CircularProgressIndicator()),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                      child: currentNews.content != null
                          ? Text(
                              currentNews.content,
                              style: GoogleFonts.openSans(
                                  fontSize: 17, color: Colors.white),
                            )
                          : Container(
                              child: Center(child: CircularProgressIndicator()),
                              margin: EdgeInsets.all(50),
                            ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: Colors.grey[800],
                    child: InkWell(
                      highlightColor: Colors.teal[100],
                      onTap: () => _launchURL(currentNews.url),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('  Tap to read the article',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    }
  }
}
