import 'package:flutter/material.dart';
import 'package:platy/features/manage_transactions/data/enums/Months.dart';
import 'package:platy/features/manage_transactions/presentation/widgets/MonthListItem.dart';

class MonthCalendar extends StatefulWidget {
  final Function(int) callback;
  MonthCalendar({ this.callback });

  @override
  _MonthCalendarState createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Month> months = Months.LIST;

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
                  MonthListItem listItem = new MonthListItem(
                    month: months[index],
                    callback: makeDate,
                  );
                  return listItem;
                },
                separatorBuilder: (context, index) => Divider(
                  height: 1.0,
                  color: Color(0xFFEEEEEE),
                ),
                itemCount: months.length,
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