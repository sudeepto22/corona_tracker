
import 'package:coronatracker/model/covid_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = Map();

  Widget appBarTitle = new Text(
    "Covid-19 Cases",
    style: new TextStyle(color: Colors.white),
  );

  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;

  List<CovidCase> covidCases;
  String _searchText = "";
  List searchResult = new List();

  _HomeState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    data = ModalRoute.of(context).settings.arguments;
    covidCases = data['data'];
    if (searchResult.length == 0 && !(_isSearching)) {
      searchResult = covidCases.map((element) => element).toList();
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: globalKey,
      appBar: buildAppBar(context),
      body: ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Card(
                child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/info', arguments: {
                        'covidCase': searchResult[index]
                      });
                    },
                    title: Text(
                      searchResult[index].country,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]
                      ),
                    ),
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(searchResult[index].flag)
                    ),
                    subtitle: Text(
                        searchResult[index].totalCases.toString(),
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700]
                        )
                    )
                )
            ),
          );
        },
      )
    );
  }
  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          new IconButton(
            icon: icon,
            onPressed: () {
              setState(() {
                if (this.icon.icon == Icons.search) {
                  this.icon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    autofocus: true,
                    cursorColor: Colors.white,
                    controller: _controller,
                    textInputAction: TextInputAction.next,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search Country",
                      hintStyle: new TextStyle(color: Colors.white)),
                    onChanged: searchOperation,
                  );
                  _handleSearchStart();
                } else {
                  searchResult = covidCases.map((element)=>element).toList();
                  _handleSearchEnd();
                }
              });
            },
          ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Covid-19 Cases",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < covidCases.length; i++) {
        String data = covidCases[i].country;
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchResult.add(covidCases[i]);
        }
      }
    }
  }
}
