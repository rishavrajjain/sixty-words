import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

Widget buildNewsShimmerEffect(BuildContext context) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 121,
              height: 121,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Container()),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                        child: Container()),
                  ),
                ],
              ),
            ),
          )
        ],
      ));
}

Widget buildExploreShimmerEffect(BuildContext context) {
  return SingleChildScrollView(
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5),
              Container(
                height: MediaQuery.of(context).size.height/2.5,
                width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 121,
                    height: 11,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 11,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
             
            ],
          ),
        ),
      ),
    ),
  );
}
