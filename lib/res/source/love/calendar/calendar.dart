library calendar;

import 'dart:collection';

import 'package:conditioning/res/source/source.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:conditioning/res/usecase/usecase.dart';

part 'calendar_note.dart';
part 'calendar_event.dart';
part 'calendar_together.dart';
part 'demos/demo_multi.dart';
part 'demos/demo_multi_complex.dart';
part 'demos/demo_range.dart';
part 'demos/utils.dart';

///
///
/// [TableCalendarDayCell]
/// [TableCalendarRangeSwitchScope]
///
/// [CalendarEvent]
///

enum TableCalendarDayCell {
  normal,
  outside, // outside month
  today,
  selected;

  ///
  /// style 1
  ///

  static Widget configuration1({
    EdgeInsetsGeometry margin = KEdgeInsets.all_6,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    AlignmentGeometry alignment = Alignment.center,
    Duration duration = KDuration.milli300,
    Decoration decoration = FDecorationShape.roundRect_8,
    required TextStyle textStyle,
    required DateTime day,
  }) =>
      AnimatedContainerDefaultTextStyleText(
        duration: duration,
        margin: margin,
        padding: padding,
        alignment: alignment,
        decoration: decoration,
        textStyle: textStyle,
        child: day.day.toString(),
      );

  FocusedDayBuilder get builderStyle1 => switch (this) {
        TableCalendarDayCell.normal => (context, day, focusedDay) =>
            configuration1(
              textStyle: KTextStyle.black45,
              day: day,
            ),
        TableCalendarDayCell.outside => (context, day, focusedDay) =>
            configuration1(
              textStyle: KTextStyle.black26,
              day: day,
            ),
        TableCalendarDayCell.today => (context, day, focusedDay) =>
            configuration1(
              textStyle: KTextStyle.boldBlack,
              day: day,
              decoration: ShapeDecoration(
                color: context.preference.appColor.colorB1,
                shape: KOutlinedBorderRounded.allCircular_8,
              ),
            ),
        TableCalendarDayCell.selected => (context, day, focusedDay) =>
            configuration1(
              textStyle: KTextStyle.white,
              day: day,
              decoration: BoxDecoration(
                color: context.preference.appColor.colorB3,
                shape: BoxShape.circle,
              ),
            ),
      };

  ///
  /// style 2
  ///

  static Widget configuration2({
    EdgeInsetsGeometry margin = KEdgeInsets.ltrb_2_16_2_0,
    EdgeInsetsGeometry padding = KEdgeInsets.onlyTop_16,
    AlignmentGeometry alignment = Alignment.topCenter,
    Duration duration = KDuration.milli400,
    VoidCallback managementButtonOnTap = kVoidCallback,
    TextStyle textStyle = KTextStyle.black87,
    required ShapeDecoration decoration,
    required DateTime day,
  }) =>
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedContainerDefaultTextStyleText(
            textStyle: textStyle,
            duration: duration,
            margin: margin,
            padding: padding,
            alignment: alignment,
            decoration: decoration,
            child: day.day.toString(),
          ),
          AnimatedOpacityIgnorePointer(
            duration: duration,
            ignoring: managementButtonOnTap == kVoidCallback,
            child: Padding(
              padding: KEdgeInsets.ltrb_8_0_8_8,
              child: SizedBox(
                height: textStyle.fontSize,
                width: double.infinity,
                child: MaterialInkWell(
                  elevation: 1.0,
                  colorBackground: decoration.color!.minusARGB(0, 30, 30, 30),
                  shape: KOutlinedBorderRounded.vertical_0_8,
                  borderRadius: KBorderRadius.vertical_0_8,
                  onTap: managementButtonOnTap,
                  child: Icon(
                    Icons.add,
                    size: textStyle.fontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  FocusedDayBuilder builderStyle2({
    Conductor<DateTime>? beforeBuild,
    VoidCallback onTapIcon = kVoidCallback,
    int? focusMonth,
  }) {
    Widget defaultBuilder(
      BuildContext context,
      DateTime day,
      DateTime focusedDay,
    ) =>
        TableCalendarDayCell.configuration2(
          textStyle: KTextStyle.black45,
          duration: KDuration.milli200,
          decoration: ShapeDecoration(
            color: context.preference.appColor.colorB2,
            shape: KOutlinedBorderContinuousRadius.vertical_0_56,
          ),
          day: day,
        );
    Widget outsideBuilder(
      BuildContext context,
      DateTime day,
      DateTime focusedDay,
    ) =>
        TableCalendarDayCell.configuration2(
          textStyle: KTextStyle.black26,
          decoration: ShapeDecoration(
            color: context.preference.appColor.colorB1,
            shape: KOutlinedBorderContinuousSideRadius
                .insideBlack26_02_vertical_0_16,
          ),
          day: day,
        );

    return switch (this) {
      // when sliding or changing page,
      // the 'newFocusedDay' is at the same position of 'focusedDay'
      TableCalendarDayCell.normal => (context, day, newFocusedDay) {
          beforeBuild?.call(day, newFocusedDay);
          return focusMonth != newFocusedDay.month
              ? outsideBuilder(context, day, newFocusedDay)
              : defaultBuilder(context, day, newFocusedDay);
        },
      TableCalendarDayCell.outside => (context, day, newfocusedDay) {
          beforeBuild?.call(day, newfocusedDay);
          return focusMonth != newfocusedDay.month
              ? defaultBuilder(context, day, newfocusedDay)
              : outsideBuilder(context, day, newfocusedDay);
        },
      TableCalendarDayCell.today => (context, day, newFocusedDay) {
          beforeBuild?.call(day, newFocusedDay);
          return TableCalendarDayCell.configuration2(
            textStyle: KTextStyle.black54,
            decoration: ShapeDecoration(
              color: context.preference.appColor.colorB3,
              shape: KOutlinedBorderContinuousRadius.vertical_0_40,
            ),
            day: day,
          );
        },
      TableCalendarDayCell.selected => (context, day, newFocusedDay) {
          beforeBuild?.call(day, newFocusedDay);
          return TableCalendarDayCell.configuration2(
            managementButtonOnTap: onTapIcon,
            textStyle: KTextStyle.boldWhite,
            decoration: ShapeDecoration(
              color: context.preference.appColor.colorPrimary,
              shape: KOutlinedBorderContinuousRadius.vertical_0_14,
            ),
            day: day,
          );
        },
    };
  }
}

enum TableCalendarRangeSwitchScope {
  twoWeek,
  oneYear;

  int get pageDateCount => switch (this) {
        TableCalendarRangeSwitchScope.twoWeek => 14,
        TableCalendarRangeSwitchScope.oneYear => 35 * 12,
      };
}

class CalendarEvent {
  final String id;
  String name;
  String description;
  DateTime? start;
  DateTime? end;

  CalendarEvent(
    this.id,
    this.start,
    this.end, {
    this.description = '',
    required this.name,
  });

  CalendarEvent.init()
      : id = DateTime.now().toString(),
        start = null,
        end = null,
        name = '',
        description = '';

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(covariant CalendarEvent other) => id == other.id;
}

class CalenderRepository {
  CalenderRepository._();
  static final CalenderRepository _instance = CalenderRepository._();

  bool _databaseNotYetOpen = true;
  factory CalenderRepository() {
    if (_instance._databaseNotYetOpen) {
      // TODO:
      _instance._databaseNotYetOpen = false;
    }

    return _instance;
  }

  List<CalendarEvent> getEventForDay(DateTime dateTime) {

    // TODO:
    return [
      CalendarEvent('id', DateTime.now(), null, name: 'name'),
      CalendarEvent('ad', DateTime.now(), null, name: 'come'),
      CalendarEvent('bd', DateTime.now(), null, name: 'na'),
      CalendarEvent('cd', DateTime.now(), null, name: 'a'),
    ];
  }
}
