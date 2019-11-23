import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String _date = "Not set";
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Log'),
      ),
      body: Container(
        height: 500,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showDatePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                  print('confirm $date');
                  _date = '${date.year} - ${date.month} - ${date.day}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                size: 18.0,
                                color: Colors.teal,
                              ),
                              Text(
                                " $_date",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            Container(
              child: TabBar(
                labelColor: Colors.blue,
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.call_made),
                    child: Text(
                      'Dialed',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.call_received),
                    child: Text(
                      'Received',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.call),
                    child: Text(
                      'Talked',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.call_missed),
                    child: Text(
                      'Missed',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              child: TabBarView(
                children: <Widget>[
                  Text("Dialed"),
                  Text("Recieved"),
                  Text("Talked"),
                  Text("Missed")
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
