import 'dart:convert';

class Calculation {
  final String id;
  final String equation;
  final String timestamp;

  Calculation({this.id, this.equation, this.timestamp});

  Calculation.fromMap(Map snapshot,String id) :
        id = id ?? '',
        equation = snapshot['equation'] ?? '',
        timestamp = snapshot['timestamp'] ?? '';

  toJson() {
    return {
      // "id": id,
      "equation": equation,
      "timestamp": timestamp,
    };
  }

  Map<String, dynamic> toMap(bool forUpdate) {
    var data = {
//      'id': id,  since id is auto incremented in the database we don't need to send it to the insert query.
      'equation': utf8.encode(equation),
      'timestamp': timestamp,
    };
    if(forUpdate){  data["id"] = this.id;  }
    return data;
  }
}

