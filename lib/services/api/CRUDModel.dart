import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nagy_calc/model/model.dart';

import '../../locator.dart';
import 'api.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Calculation> calculations;


  Future<List<Calculation>> fetchCalculations() async {
    var result = await _api.getDataCollection();
    calculations = result.docs
        .map((doc) => Calculation.fromMap(doc.data(), doc.id))
        .toList();
    return calculations;
  }

  Stream<QuerySnapshot> fetchCalculationAsStream() {
    return _api.streamDataCollection();
  }

  Future<Calculation> getCalculationById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Calculation.fromMap(doc.data(), doc.id) ;
  }


  Future removeCalculation(int id) async{
    await _api.removeDocument(id.toString()) ;
    return ;
  }
  Future updateCalculation(Calculation data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addCalculation(Calculation data) async{
    await _api.addDocument(data.toJson()) ;
    return ;
  }
}