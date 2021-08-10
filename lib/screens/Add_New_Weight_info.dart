import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewWeightInfo extends StatefulWidget {
  static const routeName = '/AddnewProd';

  @override
  _NewWeightInfoState createState() => _NewWeightInfoState();
}

class _NewWeightInfoState extends State<NewWeightInfo> {
  double _currentSliderValue = 20;
  final _fomrKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String _name = "";
  DateTime _timenow = DateTime.now();

  Future _submitForm() async {
    FocusScope.of(context).unfocus();
    final _valid = _fomrKey.currentState!.validate();
    if (_valid) {
      _fomrKey.currentState!.save();

      FirebaseFirestore.instance
          .collection('shop/JcDJeppHlmmUNYCO9fAI/item')
          .add({
        'name': _name,
        'weight': '$_currentSliderValue KG',
        'dateOfBirth': DateFormat.yMMMMd().format(_date),
        'currentTime': _timenow,
      });
      Navigator.of(context).pop();
    }
  }

  Future<Null> selecDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1986, 1),
        lastDate: DateTime(2021, 12));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        print(_date.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Wight Information '),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(40),
            child: Form(
              key: _fomrKey,
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 8,
                  shadowColor: Colors.indigo,
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Add Your Weight Information',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dancingScript(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Your Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      'Select your Weight in Kg:',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Slider(
                      value: _currentSliderValue,
                      min: 0,
                      max: 200,
                      divisions: 200,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Select your DateOfBirth:',
                      style: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () => selecDate(context),
                        icon: Icon(
                          Icons.date_range,
                          color: Colors.indigo,
                        )),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                // ignore: deprecated_member_use
                RaisedButton.icon(
                  color: Colors.indigo,
                  shape: StadiumBorder(),
                  onPressed: _submitForm,
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                    size: 40,
                  ),
                  label: Text(
                    'Add',
                    style:
                        GoogleFonts.lobster(color: Colors.white, fontSize: 30),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
