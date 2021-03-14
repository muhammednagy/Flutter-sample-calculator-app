
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helpers/database_helper.dart';
import 'model/model.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}


class _HistoryPageState extends State<HistoryPage> {
  Future<List<Calculation>> calculationsList = DatabaseHelper.instance.queryAllRows();

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

