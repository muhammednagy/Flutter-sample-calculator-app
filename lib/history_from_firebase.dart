
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nagy_calc/services/api/CRUDModel.dart';

import 'model/model.dart';

class HistoryFromFirebasePage extends StatefulWidget {
  @override
  _HistoryFromFirebasePageState createState() => _HistoryFromFirebasePageState();
}


class _HistoryFromFirebasePageState extends State<HistoryFromFirebasePage> {
  Future<List<Calculation>> calculationsList = CRUDModel().fetchCalculations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculations History"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
                future: calculationsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Flexible(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                        text: TextSpan(
                                            style: new TextStyle(
                                              fontSize: 35.0,
                                              color: Colors.black,
                                            ),
                                            text: '${snapshot.data[index].equation}'
                                        )
                                    )
                                ),
                              );
                            }
                        )
                    );
                  } else if (snapshot.hasError) {
                    RichText(
                        text: TextSpan(
                            style: new TextStyle(
                              fontSize: 45.0,
                              color: Colors.black,
                            ),
                            text: snapshot.error
                        )
                    );
                  }
                  return CircularProgressIndicator();
                })
          ],
        ),
      ),
    );
  }
}

