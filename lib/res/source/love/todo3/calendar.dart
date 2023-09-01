library calendar;

import 'dart:collection';

import 'package:conditioning/res/source/source.dart';
import 'package:conditioning/res/usecase/device.dart';
import 'package:conditioning/res/usecase/preference.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_daily_note.dart';
part 'calendar_me.dart';
part 'demos/demo_multi.dart';
part 'demos/demo_multi_complex.dart';
part 'demos/demo_range.dart';
part 'demos/utils.dart';


enum TableCalendarCellType {
  defaultDay,
  outsideDay,
  today,
  selectedDay,
}