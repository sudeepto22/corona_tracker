class CovidCase {

  String country;
  String countryAbbreviation;
  String totalCases;
  String newCases;
  String totalDeaths;
  String totalRecovered;
  String newDeaths;
  String activeCases;
  String seriousCritical;
  String casesPerMillPop;
  String flag;
  String lastUpdated;

  CovidCase({
    this.country,
    this.countryAbbreviation,
    this.totalCases,
    this.newCases,
    this.totalDeaths,
    this.newDeaths,
    this.totalRecovered,
    this.activeCases,
    this.seriousCritical,
    this.casesPerMillPop,
    this.flag,
    this.lastUpdated
  });
}