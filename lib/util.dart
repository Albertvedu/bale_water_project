import 'package:flutter/material.dart';

void pushPage(context, page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}

int daysInMonth(int month){
  var now = DateTime.now();
  var lastDayDateTime = (month < 12) ?
      DateTime(now.year, month + 1, 0) : DateTime( now.year + 1, 1,0);
  return lastDayDateTime.day;
}