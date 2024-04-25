import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaterReportModel extends ChangeNotifier {
  // Define the properties and methods for your model here
  final unfocusNode = FocusNode();
  void dispose() {
    unfocusNode.dispose();
  }
}

class WaterReportScreen extends StatefulWidget {
  const WaterReportScreen({Key? key}) : super(key: key);

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
                    const Text(
                      '[Location Name]',
                      style: TextStyle(
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
                            decoration: const BoxDecoration(
                              color: Colors.yellow, // replace with your color
                              borderRadius: BorderRadius.only(
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
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              'Report last updated on [date]',
                              style: TextStyle(
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
                                    decoration: const BoxDecoration(
                                      color:
                                          Colors.green,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Align(
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
                                          alignment: AlignmentDirectional(0, 1),
                                          child: Text(
                                            '[value]',
                                            style: TextStyle(
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
                                    decoration: const BoxDecoration(
                                      color:
                                          Colors.green,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Align(
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
                                          alignment: AlignmentDirectional(0, 1),
                                          child: Text(
                                            '[value]',
                                            style: TextStyle(
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
                                      decoration: const BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
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
                                          alignment: AlignmentDirectional(0, 1),
                                          child: Text(
                                            '[value]',
                                            style: TextStyle(
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
                                      decoration: const BoxDecoration(
                                        color:
                                            Colors.red,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
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
                                          alignment: AlignmentDirectional(0, 1),
                                          child: Text(
                                            '[value]',
                                            style: TextStyle(
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
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, -1),
                                            child: Text(
                                            'SST',
                                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 22,
                                  letterSpacing: 0,
                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(0, 1),
                                          child: Text(
                                            '[value]',
                                            style: TextStyle(
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
                                      decoration: const BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, -1),
                                            child: Text(
                                            'SDT',
                                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 22,
                                  letterSpacing: 0,
                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(0, 1),
                                          child: Text(
                                            '[value]',
                                            style: TextStyle(
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
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, -1),
                                            child: Text(
                                            'Nutrients',
                                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 22,
                                  letterSpacing: 0,
                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(0, 1),
                                          child: Text(
                                            '[value]',
                                            style: TextStyle(
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
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF5C4033),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
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
                                          alignment: AlignmentDirectional(0, 1),
                                          child: Text(
                                            '[value]',
                                            style: TextStyle(
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