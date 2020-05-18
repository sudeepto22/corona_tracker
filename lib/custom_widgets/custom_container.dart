import 'package:coronatracker/model/case_information.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {

  final CaseInformation caseInformation;

  CustomContainer({ this.caseInformation });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: caseInformation.color,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            caseInformation.fieldName,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            caseInformation.fieldValue,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}
