import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            icon: Icon(Icons.send),
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
            TextFormField(
              decoration: InputDecoration(labelText: 'Location'),
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
            TextFormField(
              decoration: InputDecoration(labelText: 'Coordinates'),
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
            TextFormField(
              decoration: InputDecoration(labelText: 'pH'),
              keyboardType: TextInputType.numberWithOptions(decimal: true), // allows decimal numbers
              onChanged: (value) {
                setState(() {
                  pH = double.tryParse(value)!; // convert to double
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
            TextFormField(
              decoration: InputDecoration(labelText: 'Temperature'),
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
            TextFormField(
              decoration: InputDecoration(labelText: 'Oxygen Levels'),
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
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Turbidity'),
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
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Bacteria Levels'),
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
            TextFormField(
              decoration: InputDecoration(labelText: 'Total Nitrogen'),
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
            TextFormField(
              decoration: InputDecoration(labelText: 'Total Phosphorus'),
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
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Conductivity'),
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
            CheckboxListTile(
              title: Text('Potable'),
              value: potable,
              onChanged: (bool? value) { // Update the parameter type to 'bool?'
                setState(() {
                  potable = value ?? false; // Use null-aware operator to handle null value
                });
              },
            ),
            CheckboxListTile(
              title: Text('Swimming Suitable'),
              value: swimmingSuitable,
              onChanged: (bool? value) {
                setState(() {
                  swimmingSuitable = value ?? false; // Use null-aware operator to handle null value
                });
              },
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'General Report'),
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
            ElevatedButton(
              child: Text('Select creation date'),
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
          ],
        ),
      ),
    );
  }
}