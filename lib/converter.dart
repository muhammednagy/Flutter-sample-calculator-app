

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _formKey = GlobalKey<FormState>();

// Create a Form widget.
class ConverterForm extends StatefulWidget {
  @override
  ConverterFormState createState() {
    return ConverterFormState();
  }
}


class ConverterFormState extends State<ConverterForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'kilometers';
  String converterValue;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
              labelText: 'Amount',
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value.isEmpty)  {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (String value) {
              converterValue = value;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Type'),
              Container(width: 8),
              DropdownButton<String>(
                items: <String>['kilometers', 'Miles'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(
                      SnackBar(
                          content: Text(convertDistance(converterValue, dropdownValue)),
                        duration: Duration(minutes: 1),
                      ));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
      ),
    );
  }
  String convertDistance(String value,String type) {
    var number = double.parse(value);
    if (type == "kilometers") {
      var result = number / 1.609344;
      return result.toStringAsFixed(3) + " Miles";
    } else {
      var result = number * 1.609344;
      return result.toStringAsFixed(3) + " Kilometers";
    }
  }
}


class ConverterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Distance converter"),
      ),
      body: ConverterForm(),
    );
  }
}