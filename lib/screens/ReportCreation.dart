import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WaterReportForm extends StatefulWidget {
  @override
  _WaterReportFormState createState() => _WaterReportFormState();
}

class _WaterReportFormState extends State<WaterReportForm> {
  final _formKey = GlobalKey<FormState>();
  late String bacteriaLevels, conductivity, coordinates, generalReport, location, oxygenLevels, totalNitrogen, totalPhosphorus, turbidity;
  late DateTime lastChange;
  late double pH, temperature;
  late bool potable, swimmingSuitable;

  @override
  void initState() {
    super.initState();
    bacteriaLevels = '';
    conductivity = '';
    coordinates = '';
    generalReport = '';
    location = '';
    oxygenLevels = '';
    totalNitrogen = '';
    totalPhosphorus = '';
    turbidity = '';
    lastChange = DateTime.now();
    pH = 0.0;
    temperature = 0.0;
    potable = false;
    swimmingSuitable = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5BB5DA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Create Water Quality Report',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            letterSpacing: 0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                FirebaseFirestore.instance.collection('water_resources').add({
                  'bacteria_levels': bacteriaLevels,
                  'conductivity': conductivity,
                  'coordinates': coordinates,
                  'general_report': generalReport,
                  'last_change': lastChange,
                  'location': location,
                  'oxygen_levels': oxygenLevels,
                  'ph': pH,
                  'potable': potable,
                  'swimming_suitable': swimmingSuitable,
                  'temperature': temperature,
                  'total_nitrogen': totalNitrogen,
                  'total_phosphorus': totalPhosphorus,
                  'turbidity' : turbidity
                });

                _formKey.currentState?.reset();
                bacteriaLevels = '';
                conductivity = '';
                coordinates = '';
                generalReport = '';
                location = '';
                oxygenLevels = '';
                totalNitrogen = '';
                totalPhosphorus = '';
                turbidity = '';
                lastChange = DateTime.now();
                pH = 0.0;
                temperature = 0.0;
                potable = false;
                swimmingSuitable = false;
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 1),
                        child: Icon(
                          Icons.location_pin,
                          size: 27,
                        )
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Location Name', border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              location = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter location name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 1),
                        child: Icon(
                          Icons.map,
                          size: 27,
                        )
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Coordinates', border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              coordinates = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter coordinates';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100,
                                height: 105,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Align(
                                      alignment: AlignmentDirectional(0, -1),
                                      child: Text(
                                        'pH',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 27,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(labelText: 'pH', border: InputBorder.none),
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      onChanged: (value) {
                                        setState(() {
                                          pH = double.tryParse(value)!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter pH value';
                                        }
                                        if (double.tryParse(value) == null) {
                                          return 'Please enter a valid number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 105,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Align(
                                      alignment: AlignmentDirectional(0, -1),
                                      child: Text(
                                        'Temp',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 27,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(labelText: 'Temperature', border: InputBorder.none),
                                      keyboardType: TextInputType.numberWithOptions(decimal: true), // allows decimal numbers
                                      onChanged: (value) {
                                        setState(() {
                                          temperature = double.tryParse(value)!; // convert to double
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter temperature';
                                        }
                                        if (double.tryParse(value) == null) {
                                          return 'Please enter a valid number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Repeat the same structure for other rows
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 100,
                                  height: 126,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Align(
                                        alignment:
                                        AlignmentDirectional(0, -1),
                                        child: Text(
                                          'Dissolved\nOX',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 21,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(labelText: 'Oxygen Levels', border: InputBorder.none),
                                        onChanged: (value) {
                                          setState(() {
                                            oxygenLevels = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter oxygen levels';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color:
                                    Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Align(
                                        alignment:
                                        AlignmentDirectional(0, -1),
                                        child: Text(
                                          'Turbidity',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 23,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(labelText: 'Turbidity', border: InputBorder.none),
                                        items: <String>['Low', 'Moderate', 'High'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            turbidity = newValue!;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a level';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Align(
                                        alignment:
                                        AlignmentDirectional(0, -1),
                                        child: Text(
                                          'Microorgs',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 22,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(labelText: 'Bacteria Levels', border: InputBorder.none),
                                        items: <String>['Low', 'Moderate', 'High'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            bacteriaLevels = newValue!;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a bacteria level';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color:
                                    Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Align(
                                        alignment:
                                        AlignmentDirectional(0, -1),
                                        child: Text(
                                          'Nitrogen',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 22,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(labelText: 'Total Nitrogen', border: InputBorder.none),
                                        onChanged: (value) {
                                          setState(() {
                                            totalNitrogen = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter total nitrogen';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 100,
                                  height: 102,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Align(
                                        alignment:
                                        AlignmentDirectional(0, -1),
                                        child: Text(
                                          'Phosph',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 26,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(labelText: 'Total Phosphorus', border: InputBorder.none),
                                        onChanged: (value) {
                                          setState(() {
                                            totalPhosphorus = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter total phosphorus';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 132,
                                  decoration: const BoxDecoration(
                                    color:
                                    Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Align(
                                        alignment:
                                        AlignmentDirectional(0, -1),
                                        child: Text(
                                          'Conductiv',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 22,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(labelText: 'Conductivity', border: InputBorder.none),
                                        items: <String>['Low', 'Moderate', 'High'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            conductivity = newValue!;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select conductivity';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 209,
                                      height: 70,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topLeft: Radius.circular(14),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: 
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(labelText: 'General Report', labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), border: InputBorder.none),
                                        items: <String>['SAFE', 'CAUTION', 'HAZARDOUS'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            generalReport = newValue!;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a general report';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CheckboxListTile(
                    title: Text('Potable'),
                    secondary: const Icon(Icons.water_drop_rounded),
                    value: potable,
                    onChanged: (bool? value) {
                      setState(() {
                        potable = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CheckboxListTile(
                    title: Text('Swimming Suitable'),
                    secondary: const Icon(FontAwesomeIcons.swimmer),
                    value: swimmingSuitable,
                    onChanged: (bool? value) {
                      setState(() {
                        swimmingSuitable = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                ),
                child: const Text('Select creation date'),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != lastChange) {
                    setState(() {
                      lastChange = picked;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}