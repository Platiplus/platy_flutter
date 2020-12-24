import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:platy/features/manage_transactions/data/enums/Months.dart';

class MonthListItem extends StatefulWidget {

  final Function(int) callback;
  final Month month;
  MonthListItem({ this.callback, this.month });

  @override
  State<StatefulWidget> createState() => _MonthListItemListItemState();
}

class _MonthListItemListItemState extends State<MonthListItem>{
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => {
        widget.callback(widget.month.value)
      },
      title: Title(
        color: Theme.monthSelectorColor,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 24.0, bottom: 24.0),
            child: Text(
              widget.month.name,
              style: TextStyle(
                  fontSize: Theme.monthSelectorSize,
                  fontFamily: Theme.primaryFontFamily,
                  color: Theme.monthSelectorColor
              ),
            ),
          ),
      ),
    );
  }
}
