import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  DateTime _actualDate;
  String _date = 'Select Date';
  Iterable<CallLogEntry> _callLogdialedEntries = [];

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
                    minTime: DateTime(2018, 1, 1),
                    maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                  _actualDate = date;
                  print('confirm $date');
                  _date = '${date.year} - ${date.month} - ${date.day}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);

                getDialedCalls();
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
              height: MediaQuery.of(context).size.height - 300,
              child: TabBarView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: dialedList(),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: recievedList(),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: talkedList(),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: missedList(),
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getDialedCalls() async {
    CallLog.query(
      dateFrom: _actualDate.millisecondsSinceEpoch,
      dateTo: _actualDate.millisecondsSinceEpoch + 86400,
      type: CallType.outgoing,
    ).then((result) {
      print(result);
      // _callLogdialedEntries = result;
    }).whenComplete(() {
      isLoading = false;
    });
    setState(() {
      isLoading = true;
    });
  }

  bool isLoading = false;

  Widget dialedList() {
    if (_callLogdialedEntries.isEmpty) {
      if (_actualDate != null) {
        getDialedCalls();
      }

      return isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container();
    } else {
      _callLogdialedEntries.forEach((f) => print(f.toString()));
    }

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          child: ListTile(
            leading: Text('Ahmed Hussam'),
            trailing: Text('113:44'),
          ),
        );
      },
    );
  }

  Widget recievedList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          child: ListTile(
            leading: Text('Ahmed Hussam'),
            trailing: Text('113:44'),
          ),
        );
      },
    );
  }

  Widget talkedList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          child: ListTile(
            leading: Text('Ahmed Hussam'),
            trailing: Text('113:44'),
          ),
        );
      },
    );
  }

  Widget missedList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          child: ListTile(
            leading: Text('Ahmed Hussam'),
            trailing: Text('113:44'),
          ),
        );
      },
    );
  }
}
