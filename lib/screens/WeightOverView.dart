import 'package:char_yaar_trade/screens/Add_New_Weight_info.dart';
import 'package:char_yaar_trade/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WeightOverView extends StatefulWidget {
  static const routeName = '/shopOverview';

  @override
  _WeightOverViewState createState() => _WeightOverViewState();
}

class _WeightOverViewState extends State<WeightOverView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  final _fomrKey = GlobalKey<FormState>();
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

  String name = '';
  String weight = '';
  DateTime _date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight App'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'Logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('shop/JcDJeppHlmmUNYCO9fAI/item')
            .orderBy('currentTime', descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final doc = snapshot.data!.docs.length;
          return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: doc,
              itemBuilder: (ctx, index) => GridTile(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Name:',
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.amberAccent)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    snapshot.data!.docs[index]['name']
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 23, color: Colors.white)),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Weight:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.amberAccent)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(snapshot.data!.docs[index]['weight'],
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Date Of Birth:',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.amberAccent)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(snapshot.data!.docs[index]['dateOfBirth'],
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      // final docId = FirebaseFirestore.instance
                                      //     .collection(
                                      //         'shop/JcDJeppHlmmUNYCO9fAI/item')
                                      //     .doc(snapshot.data!.docs[index].id);

                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return UpdateWeight(docId);
                                      // }));
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              margin: EdgeInsets.all(30),
                                              child: Column(
                                                children: [
                                                  Card(
                                                    elevation: 8,
                                                    shadowColor: Colors.indigo,
                                                    color: Colors.indigo,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        'Update Information',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .dancingScript(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Form(
                                                          key: _fomrKey,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            20),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      nameController,
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Please Enter Your Name';
                                                                    }
                                                                    return null;
                                                                  },
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Enter Your Name',
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                  ),
                                                                  onSaved:
                                                                      (value) {
                                                                    name =
                                                                        value!;
                                                                  },
                                                                ),
                                                              ),
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            20),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      weightController,
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Please Enter Your Weight';
                                                                    }
                                                                    return null;
                                                                  },
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Enter Your Weight',
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                  ),
                                                                  onSaved:
                                                                      (value) {
                                                                    weight =
                                                                        value!;
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            'Select your DateOfBirth:',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .indigo,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          IconButton(
                                                              onPressed: () =>
                                                                  selecDate(
                                                                      context),
                                                              icon: Icon(
                                                                Icons
                                                                    .date_range,
                                                                color: Colors
                                                                    .indigo,
                                                              )),
                                                        ],
                                                      ),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      // ignore: deprecated_member_use
                                                      RaisedButton.icon(
                                                        color: Colors.indigo,
                                                        onPressed: () async {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          final _valid =
                                                              _fomrKey
                                                                  .currentState!
                                                                  .validate();
                                                          if (_valid) {
                                                            _fomrKey
                                                                .currentState!
                                                                .save();

                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'shop/JcDJeppHlmmUNYCO9fAI/item')
                                                                .doc(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id)
                                                                .update({
                                                              'name': name,
                                                              'weight':
                                                                  '$weight KG',
                                                              'dateOfBirth':
                                                                  DateFormat
                                                                          .yMMMMd()
                                                                      .format(
                                                                          _date),
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                        icon: Icon(
                                                          Icons.update,
                                                          color: Colors.white,
                                                        ),
                                                        label: Text(
                                                          'Update',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection(
                                              'shop/JcDJeppHlmmUNYCO9fAI/item')
                                          .doc(snapshot.data!.docs[index].id)
                                          .delete()
                                          .then((value) => print('Deleted'))
                                          .catchError((error) =>
                                              print('Delete failed: $error'));
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.of(context).pushNamed(NewWeightInfo.routeName);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
