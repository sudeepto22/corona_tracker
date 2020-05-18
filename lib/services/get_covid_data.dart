import 'package:http/http.dart';
import 'dart:convert';
import '../model/covid_case.dart';
import 'package:time_formatter/time_formatter.dart';


class ApiCall {
  List<CovidCase> covidCases = [];

  String cleanString(num) {
    if (num == null){
      return '0';
    }
    return num.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  Future<void> getData() async{
    Response response = await get('https://corona.lmao.ninja/v2/countries?&sort=cases');
    List rawList = jsonDecode(response.body);
    for (int i = 0; i < rawList.length; i++){
      Map obj = rawList[i];
      covidCases.add(CovidCase(
          country: obj["country"].toString(),
          countryAbbreviation: obj["countryInfo"]["iso2"].toString(),
          totalCases: cleanString(obj["cases"]),
          newCases: cleanString(obj["todayCases"]),
          totalDeaths: cleanString(obj["deaths"]),
          newDeaths: cleanString(obj["todayDeaths"]),
          totalRecovered: cleanString(obj["recovered"]),
          activeCases: cleanString(obj["active"]),
          seriousCritical: cleanString(obj["critical"]),
          casesPerMillPop: cleanString(obj["casesPerOneMillion"]),
          flag: obj["countryInfo"]["flag"].toString(),
          lastUpdated: formatTime(obj["updated"])
      ));
    }
  }
}