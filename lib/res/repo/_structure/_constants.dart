part of structure;

///
/// this file contains:
///
/// [emptyStringList]
/// [emptyMap]
/// [androidPackageName]
/// [iOSBundleId]
///
/// [Repeat]
///
///

const List<String> emptyStringList = [];
const Map emptyMap = {};

const String androidPackageName = 'com.example.tempt';
const String iOSBundleId = androidPackageName;


enum Repeat {
  once,
  onceAndRemember,
  timesForEveryWorkDay,
  timesForEveryWeekend,
  timesForEveryDay,
  timesForHour,
  timesForMinute,
  timesForSecond,
  dateTimesForEveryWeek,
  dateTimesForEveryMonth,
  dateTimesForEveryYear,
}