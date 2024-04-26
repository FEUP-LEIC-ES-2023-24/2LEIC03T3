import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:project_es/screens/mapSample.dart';
import '../firebase_parse.dart';
import '../mapSample.dart';

class WaterReportModel extends ChangeNotifier {
  // Define the properties and methods for your model here
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

class _WaterReportScreenState extends State<WaterReportScreen> {
  late WaterReportModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = Provider.of<WaterReportModel>(context, listen: false);
    // Initialize your model here if needed
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          title: const Align(
            alignment: AlignmentDirectional(-1, 0),
            child: Text(
              'Water Quality Report',
              style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
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
                          color: Colors.black, // replace with your color
                          size: 25,
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
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w400,
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
                            child: const Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                '[General Report]',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 22,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '[Tip]',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              'Report last updated on ${widget.resource.date}',
                              style: const TextStyle(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0,
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
                                  fontSize: 22,
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
                                  fontSize: 22,
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
                                  fontSize: 22,
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
                                            'Phosp',
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
                                  fontSize: 20,
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
  if (turbidity == 'Baixa') {
    return Colors.green;
  } else if (turbidity == 'Moderada') {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

Color getBacteriaColor(String bacteria) {
  if (bacteria == 'Baixos') {
    return Colors.green;
  } else if (bacteria == 'Moderados') {
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
















