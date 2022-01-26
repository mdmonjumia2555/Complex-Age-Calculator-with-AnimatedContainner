import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  return runApp(app());
}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _value = false;
  int d = 0, m = 0, y = 0;
  String days1 = '', months1 = '', years1 = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: AnimatedContainer(
                  child: Center(
                    child: Text(
                      days1 + "  " + months1 + "  " + years1,
                      style: TextStyle(
                        fontSize: _value == false ? 10 : 30,
                        fontWeight: FontWeight.bold,
                        color: _value == false ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  width: _value == false ? 300 : 500,
                  height: _value == false ? 200 : 450,
                  color: _value == false ? Colors.blueGrey : Colors.green,
                  duration: Duration(seconds: 10),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    getDate();
                    _value = true;
                  },
                  child: Text('Chose Your Birth Date')),
            ),
          ],
        ),
      ),
    );
  }

  Future getDate() async {
    DateTime? date1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    setState(() {
      d = int.parse(DateFormat("dd").format(date1!));
      m = int.parse(DateFormat("MM").format(date1));
      y = int.parse(DateFormat("yy").format(date1));
      //for current date
      int d1 = int.parse(DateFormat("dd").format(DateTime.now()));
      int m1 = int.parse(DateFormat("MM").format(DateTime.now()));
      int y1 = int.parse(DateFormat("yy").format(DateTime.now()));
      int day = findDays(m1, y1);

      if (d1 - d >= 0) {
        days1 = (d1 - d).toString() + " days";
      } else {
        days1 = (d1 + day - d).toString() + " days";
        m1 = m1 - 1;
      }
      if (m1 - m >= 0) {
        months1 = (m1 - m).toString() + " months";
      } else {
        months1 = (m1 + 12 - m).toString() + " months";
        y1 = y1 - 1;
      }
      years1 = (y1 - y).toString() + " years";
    });
  }

  int findDays(int m2, int y2) {
    int day2;
    if (m2 == 1 ||
        m2 == 3 ||
        m2 == 5 ||
        m2 == 7 ||
        m2 == 8 ||
        m2 == 10 ||
        m2 == 12)
      day2 = 31;
    else if (m2 == 4 || m2 == 6 || m2 == 9 || m2 == 11)
      day2 = 30;
    else {
      if (y2 % 400 == 0)
        day2 = 29;
      else if (y2 % 4 == 0 || y2 != 0)
        day2 = 29;
      else
        day2 = 28;
    }
    return day2;
  }
}
