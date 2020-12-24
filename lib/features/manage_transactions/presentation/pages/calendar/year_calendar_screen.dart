import 'package:flutter/material.dart';
import 'package:platy/features/manage_transactions/data/enums/Years.dart';
import 'package:platy/features/manage_transactions/presentation/widgets/YearListItem.dart';

class YearCalendar extends StatefulWidget {
  final Function(int) callback;
  YearCalendar({ this.callback });

  @override
  _YearCalendarState createState() => _YearCalendarState();
}

class _YearCalendarState extends State<YearCalendar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Year> years = Years.LIST;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  YearListItem listItem = new YearListItem(
                    year: years[index],
                    callback: makeDate,
                  );
                  return listItem;
                },
                separatorBuilder: (context, index) => Divider(
                  height: 1.0,
                  color: Color(0xFFEEEEEE),
                ),
                itemCount: years.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  makeDate(int month) {
    widget.callback(month);
  }
}