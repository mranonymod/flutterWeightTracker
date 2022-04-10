import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weight_tracker/config/size_config.dart';
import 'package:weight_tracker/view/home_screen_view_model.dart';
import 'line_graph.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/src/models/weights_model.dart';

class Body extends StatelessWidget {
  final HomeScreenViewModel model;
  const Body({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15),
        vertical: getProportionateScreenHeight(10),
      ),

      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Goal progress',
                  style: Theme.of(context).textTheme.headline6,
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('Edit'),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15),
                vertical: getProportionateScreenHeight(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenWidth(120),
                    //width: 2 * getProportionateScreenWidth(200),
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: CircularPercentIndicator(
                        radius: getProportionateScreenWidth(200),
                        lineWidth: 13,
                        animation: true,
                        animationDuration: 2000,
                        arcType: ArcType.HALF,
                        percent: 0.6,
                        arcBackgroundColor: Colors.grey.withOpacity(0.3),
                        startAngle: 270,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Theme.of(context).primaryColor,
                        center: Column(
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(40),
                            ),
                            Text(
                              'now',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '74.5 Kg',
                              style: TextStyle(
                                  color: ThemeData().primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenWidth(25)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '78',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Dropped ~ 4 kg',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '72',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Statistics',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_drop_down),
                        label: Text('Week'),
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  LineChartSample2(),
                ],
              )),
          // StreamBuilder(
          //
          //     stream: FirebaseFirestore.instance
          //         .collection('weights')
          //         .doc(model.auth.currentUser!.uid)
          //         .collection('userWeights')
          //         .orderBy('time', descending: true)
          //         .snapshots(),
          //     builder: (context, AsyncSnapshot<QuerySnapshot> orderSnapshot) {
          //       List<WeightsModel> weights = [];
          //       if (orderSnapshot.connectionState == ConnectionState.waiting) {
          //         return Center(child: CircularProgressIndicator());
          //       } else {
          //         final size = orderSnapshot.data!.docs.length;
          //         if (size != 0) {
          //           return LineChartSample2() ;
          //         }
          //         else
          //           return Text(
          //             'No Weights added , add some now ',
          //             style: TextStyle(
          //               color: Colors.grey,
          //               fontWeight: FontWeight.bold,
          //               fontSize: getProportionateScreenWidth(15),
          //             ),
          //           );
          //       }
          //     })
        ],
      ),
    );
  }
}
