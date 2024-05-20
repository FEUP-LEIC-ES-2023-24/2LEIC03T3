import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class WaterReportForm extends StatefulWidget {
  @override
  _WaterReportFormState createState() => _WaterReportFormState();
}

class _WaterReportFormState extends State<WaterReportForm> {
  final _dateController = TextEditingController();
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
  void dispose() {
    _dateController.dispose();
    super.dispose();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildLocationField(),
                _buildCoordinatesField(),
                _buildPhAndTempFields(),
                _buildOxygenAndTurbidityFields(),
                _buildBacteriaAndNitrogenFields(),
                _buildPhosphorusAndConductivityFields(),
                _buildGeneralReportField(),
                _buildPotableCheckbox(),
                _buildSwimmingCheckbox(),
                _buildDatePickerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 1),
            child: Icon(
              Icons.location_pin,
              size: 27,
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Location Name', border: InputBorder.none,),
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
    );
  }

  Widget _buildCoordinatesField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 1),
            child: Icon(
              Icons.map,
              size: 27,
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Coordinates', border: InputBorder.none,),
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
    );
  }

  Widget _buildPhAndTempFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _buildStatField('pH', 'pH', (value) {
              setState(() {
                pH = double.tryParse(value)!;
              });
            }, (value) {
              if (value!.isEmpty) {
                return 'Please enter pH value';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            }),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _buildStatField('Temp', 'Temperature', (value) {
              setState(() {
                temperature = double.tryParse(value)!;
              });
            }, (value) {
              if (value!.isEmpty) {
                return 'Please enter temperature';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOxygenAndTurbidityFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _buildStatField('Dissolved OX', 'Oxygen Levels', (value) {
              setState(() {
                oxygenLevels = value;
              });
            }, (value) {
              if (value!.isEmpty) {
                return 'Please enter oxygen levels';
              }
              return null;
            }),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _buildDropdownField('Turbidity', ['Low', 'Moderate', 'High'], (value) {
              setState(() {
                turbidity = value!;
              });
            }, (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a level';
              }
              return null;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBacteriaAndNitrogenFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _buildDropdownField('Microorgs', ['Low', 'Moderate', 'High'], (value) {
              setState(() {
                bacteriaLevels = value!;
              });
            }, (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a bacteria level';
              }
              return null;
            }),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _buildStatField('Nitrogen', 'Total Nitrogen', (value) {
              setState(() {
                totalNitrogen = value;
              });
            }, (value) {
              if (value!.isEmpty) {
                return 'Please enter total nitrogen';
              }
              return null;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPhosphorusAndConductivityFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _buildStatField('Phosph', 'Total Phosphorus', (value) {
              setState(() {
                totalPhosphorus = value;
              });
            }, (value) {
              if (value!.isEmpty) {
                return 'Please enter total phosphorus';
              }
              return null;
            }),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _buildDropdownField('Conductiv', ['Low', 'Moderate', 'High'], (value) {
              setState(() {
                conductivity = value!;
              });
            }, (value) {
              if (value == null || value.isEmpty) {
                return 'Please select conductivity';
              }
              return null;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralReportField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<String>(
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
    );
  }

  Widget _buildPotableCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CheckboxListTile(
        title: Text('Potable'),
        secondary: const Icon(Icons.water_drop_rounded),
        value: potable,
        onChanged: (bool? value) {
          setState(() {
            potable = value ?? false;
          });
        },
      ),
    );
  }

  Widget _buildSwimmingCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CheckboxListTile(
        title: Text('Swimming Suitable'),
        secondary: const Icon(FontAwesomeIcons.swimmer),
        value: swimmingSuitable,
        onChanged: (bool? value) {
          setState(() {
            swimmingSuitable = value ?? false;
          });
        },
      ),
    );
  }

  Widget _buildDatePickerButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextFormField(
        controller: _dateController,
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: 'Select creation date',
          labelStyle: const TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please select a date';
          }
          return null;
        },
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (picked != null && picked != lastChange) {
            setState(() {
              lastChange = picked;
              _dateController.text = DateFormat.yMd().format(picked);
            });
          }
        },
      ),
    ),
  );
}

  Widget _buildStatField(String title, String label, Function(String) onChanged, String? Function(String?)? validator) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Readex Pro',
                fontSize: 21,
                letterSpacing: 0,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: label, border: InputBorder.none),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: onChanged,
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, Function(String?) onChanged, String? Function(String?)? validator) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(labelText: label, border: InputBorder.none),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}
