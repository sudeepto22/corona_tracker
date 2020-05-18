import 'package:coronatracker/model/covid_case.dart';
import 'package:coronatracker/services/get_covid_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  List<CovidCase> covidCases;

  void setupApiCall () async{
    ApiCall apiCall = ApiCall();
    await apiCall.getData();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'data': apiCall.covidCases
    });
  }

  @override
  void initState() {
    super.initState();
    setupApiCall();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
        backgroundColor: Colors.orange,
        body: Container(
          child: Center(
            child: SpinKitCubeGrid(
              color: Colors.white,
              size: 100.0,
            ),
          ),
        )
    );
  }
}
