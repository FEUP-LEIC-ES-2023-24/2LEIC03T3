import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
//import 'package:project_es/screens/mapSample.dart';
import '../DatabaseHelper.dart';
import '../firebase_parse.dart';
import '../mapSample.dart';

class WaterReportModel extends ChangeNotifier {
  final unfocusNode = FocusNode();
  void dispose() {
    unfocusNode.dispose();
  }
}

class WaterReportScreen extends StatefulWidget {
  final WaterResource resource;

  WaterReportScreen({required this.resource, Key? key}) : super(key: key);

  @override
  _WaterReportScreenState createState() => _WaterReportScreenState();
}


class WaterReport extends StatefulWidget {
  @override
  _WaterReportState createState() => _WaterReportState();
}

class _WaterReportState extends State<WaterReport> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isBookmarked ? Icons.star : Icons.star_border),
      onPressed: () {
        setState(() {
          isBookmarked = !isBookmarked;
        });
      },
    );
  }

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }
}

class _WaterReportScreenState extends State<WaterReportScreen> {
  bool isBookmarked = false;
  late WaterReportModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = Provider.of<WaterReportModel>(context, listen: false);
    _checkIfBookmarked();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _checkIfBookmarked() async {
    List<Map<String, dynamic>> rows = await DatabaseHelper.instance.queryAllRows();
    for (var row in rows) {
      if (row[DatabaseHelper.columnCoordinates] == widget.resource.coordinates) {
        setState(() {
          isBookmarked = true;
        });
        break;
      }
    }
  }


  Future<void> _toggleBookmark() async {
    if (isBookmarked) {
      List<Map<String, dynamic>> rows = await DatabaseHelper.instance.queryAllRows();
      for (var row in rows) {
        if (row[DatabaseHelper.columnCoordinates] == widget.resource.coordinates) {
          await DatabaseHelper.instance.delete(row[DatabaseHelper.columnId]);
          break;
        }
      }
    } else {
      Map<String, dynamic> row = {
        DatabaseHelper.columnLocation: widget.resource.location,
        DatabaseHelper.columnCoordinates: widget.resource.coordinates,
      };
      await DatabaseHelper.instance.insert(row);
    }
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF5BB5DA),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {

              Navigator.pop(context, 'update');
            },
          ),
          actions: <Widget>[
            Padding(
              //alinhar para a esquerda bastante
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 30, 0),
              child: IconButton(
                icon: Icon(
                  isBookmarked ? Icons.star : Icons.star_border,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  await _toggleBookmark();
                },
              ),
            ),
          ],
          title: const Align(
            alignment: AlignmentDirectional(1, 0),
            child: Text(
              'Water Quality Report',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),
            ),
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                      child: IconButton(
                        icon: const Icon(
                          Icons.location_pin,
                          color: Colors.black,
                          size: 27,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ),
                    Text(
                      widget.resource.location,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
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
                            decoration: BoxDecoration(
                              color: getGeneralReportColor(widget.resource),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Text(
                                widget.resource.generalreport,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 27,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              'Tip: ${getTip(widget.resource)}',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              'Report last updated on ${widget.resource.date}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 15,
                              ),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration:  BoxDecoration(
                                      color: getPhColor(widget.resource.ph ?? 0),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
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
                                        Align(
                                          alignment: const AlignmentDirectional(0, 1),
                                          child: Text(
                                            (widget.resource.ph ?? 0).toString(),
                                            style: const TextStyle(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 18,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color:
                                      getTempColor(widget.resource.temperature ?? 0),
                                      borderRadius: const BorderRadius.only(
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
                                            'Temp',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 27,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: const AlignmentDirectional(0, 1),
                                          child: Text(
                                            (widget.resource.temperature ?? 0).toString(),
                                            style: const TextStyle(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 18,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                                      decoration: BoxDecoration(
                                        color: getOxygenColor(widget.resource.oxygenLevels),
                                        borderRadius: const BorderRadius.only(
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
                                          Align(
                                            alignment: const AlignmentDirectional(0, 1),
                                            child: Text(
                                              widget.resource.oxygenLevels,
                                              style: const TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 18,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color:
                                        getTurbidityColor(widget.resource.turbidity),
                                        borderRadius: const BorderRadius.only(
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
                                          Align(
                                            alignment: const AlignmentDirectional(0, 1),
                                            child: Text(
                                              widget.resource.turbidity,
                                              style: const TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 18,
                                                letterSpacing: 0,
                                              ),
                                            ),
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
                                      decoration: BoxDecoration(
                                        color: getBacteriaColor(widget.resource.bacteriaLevels),
                                        borderRadius: const BorderRadius.only(
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
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 22,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: const AlignmentDirectional(0, 1),
                                            child: Text(
                                              widget.resource.bacteriaLevels,
                                              style: const TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 18,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: getNitrogenColor(widget.resource.totalNitrogen),
                                        borderRadius: const BorderRadius.only(
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
                                              'Nitrogen',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 22,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: const AlignmentDirectional(0, 1),
                                            child: Text(
                                              widget.resource.totalNitrogen,
                                              style: const TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 18,
                                                letterSpacing: 0,
                                              ),
                                            ),
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
                                      decoration: BoxDecoration(
                                        color: getPhosphorusColor(widget.resource.totalPhosphorus),
                                        borderRadius: const BorderRadius.only(
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
                                              'Phosph',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 26,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: const AlignmentDirectional(0, 1),
                                            child: Text(
                                              widget.resource.totalPhosphorus,
                                              style: const TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 18,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: getConductivityColor(widget.resource.conductivity),
                                        borderRadius: const BorderRadius.only(
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
                                              'Conductiv',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 22,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: const AlignmentDirectional(0, 1),
                                            child: Text(
                                              widget.resource.conductivity,
                                              style: const TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 18,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}

Color getPhColor(double ph) {
  if (ph < 6.9 || ph > 7.2) {
    return Colors.yellow;
  } else if (ph >= 6.9 && ph <= 7.2) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

Color getTempColor(double temp) {
  if (temp < 20 || temp > 25) {
    return Colors.yellow;
  } else if (temp >= 20 && temp <= 25) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

Color getOxygenColor(String oxygen) {
  if (oxygen == '>6') {
    return Colors.green;
  } else if (oxygen == '4-6') {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

Color getTurbidityColor(String turbidity) {
  if (turbidity == 'Low') {
    return Colors.green;
  } else if (turbidity == 'Moderate') {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

Color getBacteriaColor(String bacteria) {
  if (bacteria == 'Low') {
    return Colors.green;
  } else if (bacteria == 'Moderate') {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

Color getNitrogenColor(String nitrogen) {
  if (nitrogen == '<0.5') {
    return Colors.green;
  } else if (nitrogen == '0.5-1') {
    return Colors.yellow;
  } else {
    return Colors.red;
  }

}

Color getPhosphorusColor(String phosphorus) {
  if (phosphorus == '<0.1') {
    return Colors.green;
  } else if (phosphorus == '0.1-0.3') {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

Color getConductivityColor(String conductivity) {
  if (conductivity == 'Low') {
    return Colors.green;
  } else if (conductivity == 'Moderate') {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

Color getGeneralReportColor(WaterResource resource) {
  if (getPhColor(resource.ph ?? 0) == Colors.red ||
      getTempColor(resource.temperature ?? 0) == Colors.red ||
      getOxygenColor(resource.oxygenLevels) == Colors.red ||
      getTurbidityColor(resource.turbidity) == Colors.red ||
      getBacteriaColor(resource.bacteriaLevels) == Colors.red ||
      getNitrogenColor(resource.totalNitrogen) == Colors.red ||
      getPhosphorusColor(resource.totalPhosphorus) == Colors.red) {
    return Colors.red;
  } else if (getPhColor(resource.ph ?? 0) == Colors.yellow ||
      getOxygenColor(resource.oxygenLevels) == Colors.yellow ||
      getTurbidityColor(resource.turbidity) == Colors.yellow ||
      getBacteriaColor(resource.bacteriaLevels) == Colors.yellow ||
      getNitrogenColor(resource.totalNitrogen) == Colors.yellow ||
      getPhosphorusColor(resource.totalPhosphorus) == Colors.yellow) {
    return Colors.yellow;
  } else {
    return Colors.green;
  }
}

String getTip(WaterResource resource) {
  if (resource.potable && resource.swimmingSuitable) {
    return 'Safe to drink and swim.';
  } else if (resource.potable && !resource.swimmingSuitable) {
    return 'Safe to drink but unsafe to swim.';
  } else if (!resource.potable && resource.swimmingSuitable) {
    return 'Unsafe to drink but safe to swim.';
  } else {
    return 'Unsafe to drink and swim.';
  }
}

BitmapDescriptor getMarkerIcon(WaterResource resource) {
  if (getGeneralReportColor(resource) == Colors.red) {
    return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  } else if (getGeneralReportColor(resource) == Colors.yellow) {
    return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
  } else {
    return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  }
}
















