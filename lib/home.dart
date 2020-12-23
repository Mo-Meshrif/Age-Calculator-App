import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _myController = new TextEditingController();
  GlobalKey<FormState> _myKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  _ageCal(DateTime birthday) {
    var now = new DateTime.now();
    var age, year, month, day;
    year = now.year - birthday.year;
    month = now.month - birthday.month;
    day = now.day - birthday.day;
    age = "$year year(s) / $month month(s) / $day day(s)";
    return age;
  }

  _showDialog(String val) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Your age is :"),
            content: Text(
              " $val",
              textAlign: TextAlign.center,
            ),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Exit'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Calculator'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Form(
              key: _myKey,
              child: DateTimeField(
                // ignore: missing_return
                validator: (DateTime time) {
                  if (time==null) {
                    return'Forget your birthday';
                  }
                },
                controller: _myController,
                decoration: InputDecoration(
                    labelText: "Enter your Brithday here !",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                format: format,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime.now());
                },
              ),
            ),
            RaisedButton(
                onPressed: () {
                  if (_myKey.currentState.validate()) {
                    _myKey.currentState.save();
                    var age = _ageCal(DateTime.parse(_myController.text));
                    _showDialog(age);
                  }
                },
                child: Text("Calculate Age")),
          ],
        ),
      ),
    );
  }
}
