import 'package:coronatracker/custom_widgets/custom_container.dart';
import 'package:coronatracker/model/case_information.dart';
import 'package:coronatracker/model/covid_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {

  Map data = Map();
  CovidCase covidCase;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    data = ModalRoute.of(context).settings.arguments;
    covidCase = data['covidCase'];

    List<CaseInformation> cases = [
      CaseInformation(
        fieldName: 'Total Cases',
        fieldValue: covidCase.totalCases,
        color: Colors.redAccent,
      ),
      CaseInformation(
        fieldName: 'New Cases',
        fieldValue: covidCase.newCases,
        color: Colors.deepPurpleAccent,
      ),
      CaseInformation(
        fieldName: 'Total Deaths',
        fieldValue: covidCase.totalDeaths,
        color: Colors.blueGrey,
      ),
      CaseInformation(
        fieldName: 'New Deaths',
        fieldValue: covidCase.newDeaths,
        color: Colors.amber,
      ),
      CaseInformation(
        fieldName: 'Total Recovered',
        fieldValue: covidCase.totalRecovered,
        color: Colors.green,
      ),
      CaseInformation(
        fieldName: 'Active Cases',
        fieldValue: covidCase.activeCases,
        color: Colors.brown,
      ),
      CaseInformation(
        fieldName: 'Serious Critical',
        fieldValue: covidCase.seriousCritical,
        color: Colors.grey,
      ),
      CaseInformation(
        fieldName: 'Per mill pop',
        fieldValue: covidCase.casesPerMillPop,
        color: Colors.cyan,
      )
    ];

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                ClipOval(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context, '/home');
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                      covidCase.country,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    child: CircleAvatar(
                      radius: 24.3,
                      backgroundColor: Colors.grey[800],
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(covidCase.flag),
                        radius: 24
                      ),
                    ),
                  ),
                )
              ],
            ),
            height: 200.0,
            decoration: new BoxDecoration(
              color: Colors.orange,
              boxShadow: [
                new BoxShadow(blurRadius: 40.0)
              ],
              borderRadius: new BorderRadius.vertical(
                  bottom: new Radius.elliptical(
                      MediaQuery.of(context).size.width, 100.0)),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height-220,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.3,
                  crossAxisCount: 2
                ),
                itemCount: cases.length,
                itemBuilder: (context, index) {
                  return CustomContainer(caseInformation: cases[index]);
                }
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                    'Last updated: ${covidCase.lastUpdated}',
                  style: TextStyle(
                    color: Colors.grey[600]
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
