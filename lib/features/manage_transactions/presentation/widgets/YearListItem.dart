import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:platy/features/manage_transactions/data/enums/Years.dart';

class YearListItem extends StatefulWidget {

  final Function(int) callback;
  final Year year;
  YearListItem({ this.callback, this.year });

  @override
  State<StatefulWidget> createState() => _YearListItemListItemState();
}

class _YearListItemListItemState extends State<YearListItem>{
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => {
        widget.callback(widget.year.value)
      },
      title: Title(
        color: Theme.monthSelectorColor,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 24.0, bottom: 24.0),
            child: Text(
              widget.year.name,
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
