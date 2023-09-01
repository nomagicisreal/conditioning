part of calendar;

///
/// this file contains:
/// [_calendarBorderCircular]
///
/// [ScreenMyCalendar]
/// [ViewMyCalendar]
/// [ViewMyCalendarEventDetail]
/// [ViewMyCalendarEventModification]
///
/// [MyCalendarHeadArrowKind]
/// [MyCalendarHead]
/// [MyCalendarCellTailClipper]
/// [MyCalendarCell]
/// [MyCalendarTail]
///
///

const double _calendarBorderCircular = 10;

class ScreenMyCalendar extends StatefulWidget {
  const ScreenMyCalendar({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenMyCalendar> createState() => _ScreenMyCalendarState();
}

class _ScreenMyCalendarState extends State<ScreenMyCalendar> {
  DateTime? _newEventDefaultStartTime;
  OrgEvent? _focusedEvent;
  bool _enableModifyEvent = false;

  @override
  Widget build(BuildContext context) {
    final mainColor = context.preference.appColor;
    return Scaffold(
      backgroundColor: mainColor.colorB1,
      body: Stack(
        children: [
          Padding(
            padding: KEdgeInsets.symH_8,
            child: ViewMyCalendar(
              showAddingEventView: _showModifyEventView,
              seeEventDetail: _showEventDetailView,
            ),
          ),

          // TODO: penpes
          IgnorePointer(
            ignoring: _focusedEvent == null,
            child: AnimatedOpacity(
              opacity: _focusedEvent == null ? 0.0 : 1.0,
              duration: KDuration.milli300,
              child: ViewMyCalendarEventDetail(
                orgEvent: _focusedEvent,
                backButtonPressed: _hideEventDetailView,
                editButtonPressed: _showModifyEventView,
              ),
            ),
          ),

          // TODO: penpes
          IgnorePointer(
            ignoring: !_enableModifyEvent,
            child: AnimatedOpacity(
              opacity: _enableModifyEvent ? 1.0 : 0.0,
              duration: KDuration.milli300,
              child: ViewMyCalendarEventModification(
                defaultAddingEventStartTime: _newEventDefaultStartTime,
                existOrgEvent: _focusedEvent,
                cancelButtonPressed: _hideModifyEventView,
                saveButtonPressed: () =>
                    _hideModifyEventAndEventDetailView(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showModifyEventView(DateTime startTime) => setState(() {
        _newEventDefaultStartTime = startTime;
        _enableModifyEvent = true;
      });

  void _hideModifyEventView() => setState(() {
        _newEventDefaultStartTime = null;
        _enableModifyEvent = false;
      });

  void _showEventDetailView(OrgEvent event) =>
      setState(() => _focusedEvent = event);

  void _hideEventDetailView() => setState(() => _focusedEvent = null);

  void _hideModifyEventAndEventDetailView(BuildContext context) {
    _hideModifyEventView();
    _hideEventDetailView();
    context.showSnackbarWithMessage(
      duration: KDuration.milli300,
      message: 'save event',
    );
  }
}

class ViewMyCalendar extends StatefulWidget {
  const ViewMyCalendar({
    Key? key,
    required this.showAddingEventView,
    required this.seeEventDetail,
  }) : super(key: key);
  final void Function(DateTime time)
      showAddingEventView; // only manager can add event
  final void Function(OrgEvent event)
      seeEventDetail; // only manager can modify event

  @override
  State<ViewMyCalendar> createState() => _ViewMyCalendarState();
}

class _ViewMyCalendarState extends State<ViewMyCalendar> {
  late final PageController _pageController;
  List<OrgEvent> _selectedEvents = <OrgEvent>[];
  DateTime? _selectedDate;

  // '_isTodayOnPage', '_showNavToTodayButton' flow:
  // 1. arrowTap() ensure start with false
  // 2. todayBuilder() check if today exist on calendar page
  // 3. pageChanged() decide whether todayButton should show.
  bool _isTodayOnPage = true;
  MyCalendarHeadArrowKind? _arrowKind;

  // '_latestFocusedMonthBoundDate' keep focusedDate as latestFocusedMonth in two condition:
  // 1. user navigate to the page which contain latestFocusedMonth and previous/nextMonth
  // 2. calendar newFocusedDate been assign by next/previousMonth date, but not latestFocusedMonth date
  late DateTime _latestFocusedDate;
  DateTime? _latestFocusedMonthBoundDate;
  bool _latestFocusedMonthBoundDateFound =
      false; // help finding lastDay of month

  /// Event Manager usages:
  late RangeSelectionMode _rangeSelectionMode;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  // TODO: move transaction to bloc
  bool _isDatabaseOpen = false;
  final OrgEventLocalDatabaseProvider _database =
      OrgEventLocalDatabaseProvider();

  @override
  void initState() {
    _latestFocusedDate = DateTime.now();
    _rangeSelectionMode = RangeSelectionMode.toggledOff;
    super.initState();
  }

  Future<void> _getEventsForDay() async {
    if (!_isDatabaseOpen) {
      await _database.open();
      // await _database.close();
      // await _database.remove();
      _isDatabaseOpen = true;
    }
    // TODO: getEventsForDay from database
    // _database.columnGet(id)

    final newList = <OrgEvent>[];
    for (var i = 0; i < 5; i++) {
      String id = _selectedDate!.day.toString();
      if (i == 1) {
        id = _selectedDate!.month.toString();
      }
      newList.add(OrgEvent(
          id: '$i $id',
          name: 'name $i',
          startDateTime: _selectedDate!,
          endDateTime: DateTime.now()));
    }
    _selectedEvents = newList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyCalendarHead(
          height: 40.0,
          focusedDay: _latestFocusedDate,
          showTodayButton: !_isTodayOnPage,
          showTodayButtonWith: _arrowKind,
          onTodayButtonTap: () => setState(() {
            _arrowKind = null;
            _latestFocusedDate = DateTime.now();
          }),
          onLeftArrowTap: () {
            _arrowKind = MyCalendarHeadArrowKind.twoWeekArrowLeft;
            _isTodayOnPage = false;
            _pageController.previousPage(
              duration: KDuration.milli300,
              curve: Curves.easeOut,
            );
          },
          onRightArrowTap: () {
            _arrowKind = MyCalendarHeadArrowKind.twoWeekArrowRight;
            _isTodayOnPage = false;
            _pageController.nextPage(
              duration: KDuration.milli300,
              curve: Curves.easeOut,
            );
          },
        ),
        SizedBox(
          height: 360,
          child: Padding(
            padding: KEdgeInsets.onlyBottom_16,
            child: TableCalendar(
              locale: 'zh',
              firstDay: DateTime.utc(1911, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              shouldFillViewport: true,
              headerVisible: false,
              daysOfWeekVisible: true,
              calendarFormat: CalendarFormat.twoWeeks,
              daysOfWeekStyle: const DaysOfWeekStyle(
                decoration: BoxDecoration(),
                weekdayStyle: TextStyle(color: Colors.black),
                weekendStyle: TextStyle(color: Colors.black45),
              ),
              onCalendarCreated: (pageController) =>
                  _pageController = pageController,
              focusedDay: _latestFocusedDate,
              onPageChanged: (newFocusedDate) {
                // page changed after two page builders

                /// keep focus latestFocusedMonth
                final latestFocusedMonth = _latestFocusedDate.month;
                final newFocusedMonth = newFocusedDate.month;
                if (_latestFocusedMonthBoundDate != null) {
                  if (latestFocusedMonth == newFocusedMonth) {
                    _latestFocusedDate = newFocusedDate;
                  } else {
                    _latestFocusedDate = _latestFocusedMonthBoundDate!;
                  }
                  _latestFocusedMonthBoundDate = null;
                  _latestFocusedMonthBoundDateFound = false;
                } else {
                  _latestFocusedDate = newFocusedDate;
                }

                /// update header
                setState(() {});
              },
              calendarBuilders: CalendarBuilders(
                // cannot setState in builder
                defaultBuilder: (context, builtDay, focusedDay) {
                  return _buildCalendarCell(
                    cellType: TableCalendarCellType.defaultDay,
                    dateText: builtDay.day.toString(),
                  );
                },
                todayBuilder: (context, builtDay, focusedDay) {
                  _isTodayOnPage = true;
                  return _buildCalendarCell(
                    cellType: TableCalendarCellType.today,
                    dateText: builtDay.day.toString(),
                  );
                },
                selectedBuilder: (context, builtDay, focusedDay) {
                  if (isSameDay(builtDay, DateTime.now())) {
                    _isTodayOnPage = true;
                  }
                  return _buildCalendarCell(
                    cellType: TableCalendarCellType.selectedDay,
                    dateText: builtDay.day.toString(),
                  );
                },
                outsideBuilder: (context, builtDay, focusedDay) {
                  final currentFocusedMonth = _latestFocusedDate.month;
                  final outsideFocusedMonth = focusedDay.month;
                  if (currentFocusedMonth != outsideFocusedMonth) {
                    if (outsideFocusedMonth > builtDay.month) {
                      // lastDay bound
                      _latestFocusedMonthBoundDate = builtDay;
                    } else if (outsideFocusedMonth < builtDay.month) {
                      // firstDay bound
                      if (!_latestFocusedMonthBoundDateFound) {
                        _latestFocusedMonthBoundDate = builtDay;
                        _latestFocusedMonthBoundDateFound = true;
                      }
                    }
                  }

                  return _buildCalendarCell(
                    cellType: TableCalendarCellType.outsideDay,
                    dateText: builtDay.day.toString(),
                  );
                },
                // rangeStartBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // rangeEndBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // withinRangeBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // disabledBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // holidayBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // rangeHighlightBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // singleMarkerBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // markerBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // weekNumberBuilder: ,
              ),
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) => setState(() {
                if (!isSameDay(_selectedDate, selectedDay)) {
                  _arrowKind = null; // update header without arrow
                  _selectedDate = selectedDay;
                  _latestFocusedDate = focusedDay;
                  _getEventsForDay();
                } else {
                  _arrowKind = null;
                  _selectedDate = null; // cancel select
                }

                if (isManager) {
                  _rangeStart = null;
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                }
              }),

              /// event manager usages
              // rangeStartDay: _rangeStart,
              // rangeEndDay: _rangeEnd,
              // rangeSelectionMode: _rangeSelectionMode,
              // onRangeSelected: (start, end, focusedDay) {
              //   setState(() {
              //     _selectedDate = null;
              //     _latestFocusedDate = focusedDay;
              //     _rangeStart = start;
              //     _rangeEnd = end;
              //     _rangeSelectionMode = RangeSelectionMode.toggledOn;
              //   });
              // },
            ),
          ),
        ),
        AnimatedContainer(
          height: _selectedDate == null ? 0.0 : 180.0,
          duration: KDuration.milli300,
          child: Padding(
            padding: KEdgeInsets.symH_12,
            child: IgnorePointer(
              ignoring: _selectedDate == null,
              child: AnimatedOpacity(
                opacity: _selectedDate == null ? 0.0 : 1.0,
                duration: KDuration.milli300,
                child: MyCalendarTail(
                  userPref: widget.userPref,
                  eventListForDay: _selectedEvents,
                  eventOnTap: widget.seeEventDetail,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCalendarCell({
    required TableCalendarCellType cellType,
    required String dateText,
  }) {
    // 1. colors: background color, cell color (default, outside, today, selected)
    // 2. cell border (Border, Round, Continuous, Beveled, Outline, Baseline, Stadium) for (default, outside, today, selected)
    //    normal Border enable more configuration other than 'radius', like 'spreadRadius', 'shadowRadius', 'offset'

    return MyCalendarCell(
      cellType: cellType,
      dateText: dateText,
      addEventButtonOnTap:
          isManager ? () => widget.showAddingEventView(_selectedDate!) : null,
    );
  }
}

class ViewMyCalendarEventDetail extends StatefulWidget {
  const ViewMyCalendarEventDetail({
    Key? key,
    required this.orgEvent,
    required this.backButtonPressed,
    required this.editButtonPressed,
  }) : super(key: key);
  final OrgEvent? orgEvent;
  final void Function() backButtonPressed;
  final void Function(DateTime eventStartTime) editButtonPressed;

  @override
  State<ViewMyCalendarEventDetail> createState() =>
      _ViewMyCalendarEventDetailState();
}

class _ViewMyCalendarEventDetailState extends State<ViewMyCalendarEventDetail> {
  late final double _windowHeight;
  late final FocusNode _focusNode;
  late final TextEditingController _chatTextController;
  late OrgEvent? _event;

  @override
  void initState() {
    _chatTextController = TextEditingController();
    _focusNode = FocusNode();
    _windowHeight = vDevice.windowSize.height;

    super.initState();
  }

  // TODO: move transactions to bloc
  bool _isDatabaseOpen = false;
  late final OrgEventLocalDatabaseProvider _database;

  Future<void> _deleteOrgEvent(OrgEvent event) async {
    if (!_isDatabaseOpen) {
      await _database.open();
      // await _database.close();
      // await _database.remove();
      _isDatabaseOpen = true;
    }
    await _database.itemDelete(event.id);
  }

  @override
  void dispose() {
    _chatTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ViewMyCalendarEventDetail oldWidget) {
    if (widget.orgEvent == null) {
      _chatTextController.clear();
    } else {
      _event = widget.orgEvent;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = context.preference.appColor;
    _event = widget.orgEvent;

    return Material(
      color: mainColor.colorB2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: KEdgeInsets.symH_8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  splashRadius: 20,
                  icon: KIcon.backspace,
                  iconSize: 28,
                  padding: EdgeInsets.zero,
                  onPressed: widget.backButtonPressed,
                ),
                Text(_event?.name ?? ''),
                IconButton(
                  splashRadius: 20.0,
                  icon: KIcon.edit,
                  iconSize: 28,
                  padding: EdgeInsets.zero,
                  onPressed: () =>
                      widget.editButtonPressed(_event!.startDateTime),
                ),
              ],
            ),
          ),
          Divider(thickness: 2.0, color: mainColor.colorB3),
          Padding(
            padding: KEdgeInsets.symH_12,
            child: SingleChildScrollView(child: Container()),
          ),
        ],
      ),
    );
  }
}

class ViewMyCalendarEventModification extends StatefulWidget {
  const ViewMyCalendarEventModification({
    Key? key,
    required this.defaultAddingEventStartTime,
    required this.existOrgEvent,
    required this.cancelButtonPressed,
    required this.saveButtonPressed,
  }) : super(key: key);
  final DateTime? defaultAddingEventStartTime;
  final OrgEvent? existOrgEvent;
  final void Function() cancelButtonPressed;
  final void Function() saveButtonPressed;

  @override
  State<ViewMyCalendarEventModification> createState() =>
      _ViewMyCalendarEventModificationState();
}

class _ViewMyCalendarEventModificationState
    extends State<ViewMyCalendarEventModification> {
  late final TextEditingController _eventNameController;
  late final TextEditingController _eventDescriptionController;
  OrgEvent? _orgEvent;

  // TODO: move transactions to bloc
  bool _isDatabaseOpen = false;
  late final OrgEventLocalDatabaseProvider _database;

  OrgEvent _createOrgEvent(String eventId) => OrgEvent(
        id: eventId,
        name: _eventNameController.text,
        startDateTime: _orgEvent!.startDateTime,
        endDateTime: _orgEvent!.endDateTime,
      );

  Future<void> _saveOrgEvent() async {
    if (!_isDatabaseOpen) {
      await _database.open();
      // await _database.close();
      // await _database.remove();
      _isDatabaseOpen = true;
    }

    if (widget.defaultAddingEventStartTime != null) {
      final eventId = DateTime.now().millisecondsSinceEpoch.toString();
      final newOrgEvent = _createOrgEvent(eventId);
      _database.itemInsert(newOrgEvent);
    } else if (widget.existOrgEvent != null) {
      final eventId = _orgEvent!.id;
      final newOrgEvent = _createOrgEvent(eventId);
      await _database.itemUpdate(eventId, newOrgEvent);
    } else {
      throw Exception('impossible');
    }

    _orgEvent = null;
    _eventDescriptionController.clear();
    _eventNameController.clear();
  }

  @override
  void initState() {
    _database = OrgEventLocalDatabaseProvider();
    _eventNameController = TextEditingController();
    _eventDescriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = context.preference.appColor;
    _orgEvent = widget.existOrgEvent;
    if (widget.defaultAddingEventStartTime == null && _orgEvent == null) {
      return Material(color: mainColor.colorB3, child: Container());
    } else {
      _eventNameController.text = _orgEvent?.name ?? '';
      _eventDescriptionController.text = _orgEvent?.description ?? '';

      return Material(
        color: mainColor.colorB3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: KEdgeInsets.symH_8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    splashRadius: 20,
                    color: Colors.white,
                    icon: KIcon.delete,
                    iconSize: 28,
                    padding: EdgeInsets.zero,
                    onPressed: widget.cancelButtonPressed,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      autofocus: true,
                      controller: _eventNameController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'event name',
                        hintStyle: KTextStyle.white_24,
                      ),
                      style: KTextStyle.white_28,
                      cursorColor: Colors.white,
                    ),
                  ),
                  IconButton(
                    splashRadius: 20.0,
                    color: Colors.white,
                    icon: KIcon.check,
                    iconSize: 28,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (_eventNameController.text.isEmpty) {
                        context.showSnackbarWithMessage(
                          duration: KDuration.milli300,
                          message: 'name must not be null',
                        );
                      } else {
                        _saveOrgEvent();
                        widget.saveButtonPressed();
                      }
                    },
                  ),
                ],
              ),
            ),
            Divider(
              indent: 16.0,
              endIndent: 16.0,
              thickness: 4.0,
              color: mainColor.colorB1,
            ),
            Padding(
              padding: KEdgeInsets.symH_12,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'start : ${widget.defaultAddingEventStartTime?.month}/${widget.defaultAddingEventStartTime?.day}',
                      style: KTextStyle.kWhite,
                    ),
                    Text(
                        ' end  : ${widget.defaultAddingEventStartTime?.month}/${widget.defaultAddingEventStartTime?.day}',
                        style: const TextStyle(color: Colors.white)),
                    KDivider.white,
                    TextField(
                      controller: _eventDescriptionController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'description',
                        hintStyle: KTextStyle.kWhite,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

enum MyCalendarHeadArrowKind {
  twoWeekArrowLeft,
  twoWeekArrowRight,
  oneYearArrowLeft,
  oneYearArrowRight,
}

class MyCalendarHead extends StatefulWidget {
  final double height;
  final DateTime focusedDay;
  final bool showTodayButton;
  final MyCalendarHeadArrowKind? showTodayButtonWith;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  const MyCalendarHead({
    Key? key,
    required this.height,
    required this.focusedDay,
    required this.showTodayButton,
    this.showTodayButtonWith,
    required this.onTodayButtonTap,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
  }) : super(key: key);

  @override
  State<MyCalendarHead> createState() => _MyCalendarHeadState();
}

class _MyCalendarHeadState extends State<MyCalendarHead> {
  late final GlobalKey<AnimatedListState> _titleWidgetsKey;

  AnimatedListState? get _titleWidgetsState => _titleWidgetsKey.currentState;
  final List<Widget> _titleWidgets = <Widget>[];
  double _headerHeight = 40.0;

  @override
  void initState() {
    _titleWidgets.add(_textWidget(widget.focusedDay));
    _titleWidgetsKey = GlobalKey<AnimatedListState>();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyCalendarHead oldWidget) {
    final oldFocusedDate = oldWidget.focusedDay;
    final newFocusedDate = widget.focusedDay;
    if (newFocusedDate.month != oldFocusedDate.month) {
      /// remove old text
      final oldTextIndex = _findWidgetIndex('SizedBox');
      _titleWidgets.removeAt(oldTextIndex);
      _titleWidgetsState!.removeItem(
          oldTextIndex,
          (context, animation) => SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: widget.showTodayButtonWith != null ? 1.0 : -1.0,
                child: _textWidget(oldWidget.focusedDay),
              ));

      /// insert new text
      _titleWidgets.insert(oldTextIndex, _textWidget(widget.focusedDay));
      _titleWidgetsState!.insertItem(oldTextIndex);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final arrow = widget.showTodayButtonWith;
    if (arrow != null) {
      if (widget.showTodayButton) {
        switch (arrow) {
          case MyCalendarHeadArrowKind.oneYearArrowLeft:
          case MyCalendarHeadArrowKind.twoWeekArrowLeft:
            if (_titleWidgets.length == 1) {
              _titleWidgets.insert(1, _todayButton);
              _titleWidgetsState!.insertItem(1);
            }
            break;

          case MyCalendarHeadArrowKind.oneYearArrowRight:
          case MyCalendarHeadArrowKind.twoWeekArrowRight:
            if (_titleWidgets.length == 1) {
              _titleWidgets.insert(0, _todayButton);
              _titleWidgetsState!.insertItem(0);
            }
            break;
          default:
            throw Exception('no such arrow');
        }
      } else {
        if (_titleWidgets.length == 2) {
          _removeTodayButton();
        }
      }
    }
    _headerHeight = widget.height;

    // TODO: build arrow for next month, next year
    return Row(
      children: [
        IconButton(
          splashRadius: 16,
          icon: const Icon(Icons.chevron_left),
          iconSize: _headerHeight / 2,
          onPressed: widget.onLeftArrowTap,
        ),
        const Spacer(),
        AnimatedContainer(
          width: _titleWidgets.length == 1 ? 120 : 180,
          height: _headerHeight,
          duration: KDuration.milli300,
          child: AnimatedList(
            key: _titleWidgetsKey,
            scrollDirection: Axis.horizontal,
            initialItemCount: _titleWidgets.length,
            itemBuilder: (context, index, animation) {
              final currentWidget = _titleWidgets.elementAt(index);

              double currentAxisAlignment = 0.0;
              if (currentWidget.toStringShort() == 'IconButton') {
                if (index == 0) {
                  currentAxisAlignment = 1.0;
                } else if (index == 1) {
                  currentAxisAlignment = -1.0;
                }
              } else if (currentWidget.toStringShort() == 'SizedBox') {
                currentAxisAlignment = 1.0;
              }

              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: currentAxisAlignment,
                child: currentWidget,
              );
            },
          ),
        ),
        const Spacer(),
        IconButton(
          splashRadius: 16,
          icon: const Icon(Icons.chevron_right),
          iconSize: _headerHeight / 2,
          onPressed: widget.onRightArrowTap,
        ),
      ],
    );
  }

  // TODO: only modify yearText, only modify monthText
  Widget _textWidget(DateTime focusedDate) => SizedBox(
        width: 120,
        height: widget.height,
        child: Center(
          child: Text(
            DateFormat.yMMM('zh').format(focusedDate),
            style: TextStyle(fontSize: _headerHeight / 2),
          ),
        ),
      );

  Widget get _todayButton => IconButton(
        splashRadius: 16,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.calendar_today),
        iconSize: _headerHeight / 2,
        onPressed: () {
          widget.onTodayButtonTap();
          _removeTodayButton();
        },
      );

  void _removeTodayButton() {
    final index = _findWidgetIndex('IconButton');
    _titleWidgets.removeAt(index);
    _titleWidgetsState!.removeItem(
        index,
        (context, animation) => SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              axisAlignment: index == 0 ? 1.0 : -1.0,
              // 1.0: remove to left, -1.0: remove to right
              child: _todayButton,
            ));
  }

  int _findWidgetIndex(String widgetName) {
    final firstElementName = _titleWidgets.elementAt(0).toStringShort();
    if (firstElementName == widgetName) {
      return 0;
    } else {
      return 1;
    }
  }
}

class MyCalendarCellTailClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double width = size.width;
    final double height = size.height;

    // A------B
    // |      |
    // F      C
    //  \    /
    //   E--D
    return Path()
      ..moveTo(0.0, height - (_calendarBorderCircular + 8)) // A
      ..lineTo(width, height - (_calendarBorderCircular + 8)) // B
      ..lineTo(width, height - _calendarBorderCircular) // C
      ..lineTo(width - _calendarBorderCircular, height) // D
      ..lineTo(_calendarBorderCircular, height) // E
      ..lineTo(0.0, height - _calendarBorderCircular) // F
      ..close();
  }

  @override
  bool shouldReclip(MyCalendarCellTailClipper oldClipper) => false;
}

class MyCalendarCell extends StatelessWidget {
  const MyCalendarCell({
    Key? key,
    required this.cellType,
    required this.dateText,
    this.addEventButtonOnTap,
  }) : super(key: key);
  final TableCalendarCellType cellType;
  final String dateText;
  final void Function()? addEventButtonOnTap;

  @override
  Widget build(BuildContext context) {
    final mainColor = context.preference.appColor;
    return Stack(
      children: [
        _cellOf(color: mainColor),
        if (addEventButtonOnTap != null)
          IgnorePointer(
            ignoring: cellType != TableCalendarCellType.selectedDay,
            child: AnimatedOpacity(
              opacity:
                  cellType == TableCalendarCellType.selectedDay ? 1.0 : 0.0,
              duration: KDuration.milli300,
              child: ClipPath(
                clipper: MyCalendarCellTailClipper(),
                child: GestureDetector(
                  onTap: addEventButtonOnTap,
                  child: Container(
                    width: 64,
                    color: mainColor.colorD3,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Icon(Icons.add, color: Colors.white)],
                    ),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _cellOf({required MainColor color}) {
    const myCalendarStyle = CalendarStyle(
      cellMargin: KEdgeInsets.onlyTop_16,
      cellPadding: KEdgeInsets.onlyTop_12,
    );

    final margin = myCalendarStyle.cellMargin;
    final padding = myCalendarStyle.cellPadding;
    const alignment = Alignment.topCenter;

    switch (cellType) {
      case TableCalendarCellType.defaultDay:
        return AnimatedContainer(
          duration: KDuration.milli300,
          margin: margin,
          padding: padding,
          alignment: alignment,
          decoration: ShapeDecoration(
            color: color.primaryColor,
            shape: KBorderWithRadius.continuousRectVertical_0_56,
          ),
          child: AnimatedDefaultTextStyle(
            style: KTextStyle.kBlack87,
            duration: KDuration.milli300,
            child: Text(dateText),
          ),
        );
      case TableCalendarCellType.outsideDay:
        return AnimatedContainer(
          duration: KDuration.milli300,
          margin: margin,
          padding: padding,
          alignment: alignment,
          decoration: KShapeDecoration.outlineBlack25_02,
          child: AnimatedDefaultTextStyle(
            style: KTextStyle.kBlack26,
            duration: KDuration.milli300,
            child: Text(dateText),
          ),
        );
      case TableCalendarCellType.today:
        return AnimatedContainer(
          duration: KDuration.milli300,
          margin: margin,
          padding: padding,
          decoration: ShapeDecoration(
            color: color.colorD1,
            shape: KBorderWithRadius.roundRectVertical_0_8,
          ),
          alignment: alignment,
          child: AnimatedDefaultTextStyle(
            style: KTextStyle.boldBlack,
            duration: KDuration.milli300,
            child: Text(dateText),
          ),
        );
      case TableCalendarCellType.selectedDay:
        return AnimatedContainer(
          duration: KDuration.milli300,
          margin: margin,
          padding: padding,
          decoration: ShapeDecoration(
            color: color.colorB2,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(_calendarBorderCircular),
              ),
            ),
          ),
          alignment: alignment,
          child: AnimatedDefaultTextStyle(
            style: KTextStyle.boldWhite,
            duration: KDuration.milli300,
            child: Text(dateText),
          ),
        );
    }
  }
}

class MyCalendarTail extends StatefulWidget {
  const MyCalendarTail({
    Key? key,
    required this.eventListForDay,
    required this.eventOnTap,
  }) : super(key: key);
  final List<OrgEvent> eventListForDay;
  final void Function(OrgEvent event) eventOnTap;

  @override
  State<MyCalendarTail> createState() => _MyCalendarTailState();
}

class _MyCalendarTailState extends State<MyCalendarTail> {
  final List<OrgEvent> _selectedEvents = <OrgEvent>[];
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  AnimatedListState? get _listState => _key.currentState;

  @override
  void didUpdateWidget(covariant MyCalendarTail oldWidget) {
    final oldEvents = oldWidget.eventListForDay;
    final newEvents = widget.eventListForDay;
    if (_selectedEvents.isNotEmpty) {
      /// find same events
      final sameEvents = <int, OrgEvent>{};
      for (var newEvent in newEvents) {
        for (var index = 0; index < oldEvents.length; index++) {
          final oldEvent = oldEvents[index];
          if (newEvent.id == oldEvent.id) {
            sameEvents.putIfAbsent(index, () => oldEvent);
          }
        }
      }

      /// remove different events
      for (var index = _selectedEvents.length - 1; index >= 0; index--) {
        if (!sameEvents.keys.contains(index)) {
          final removedEvent = _selectedEvents.removeAt(index);
          _listState!.removeItem(
            index,
            (context, animation) => SizeTransition(
              sizeFactor: animation,
              child: _eventWidgetOf(
                event: removedEvent,
                mainColor: context.preference.appColor,
              ),
            ),
          );
        }
      }
    }

    /// insert new events
    for (var index = 0; index < newEvents.length; index++) {
      final newEvent = newEvents[index];
      bool eventExist = false;
      for (var element in _selectedEvents) {
        if (element.id == newEvent.id) {
          eventExist = true;
        }
      }
      if (!eventExist) {
        _selectedEvents.insert(index, newEvent);
        _listState!.insertItem(index);
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = context.preference.appColor;

    return Container(
      decoration: ShapeDecoration(
        color: mainColor.colorB3,
        shape: KInputBorder.outline,
      ),

      child: AnimatedList(
        key: _key,
        initialItemCount: _selectedEvents.length,
        itemBuilder: (context, index, animation) => FadeTransition(
          opacity: animation,
          child: _eventWidgetOf(
            event: _selectedEvents[index],
            mainColor: mainColor,
          ),
        ),
      ),
    );
  }

  Widget _eventWidgetOf({
    required OrgEvent event,
    required MainColor mainColor,
  }) {
    return SizedBox(
      height: 64,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: KEdgeInsets.onlyRight_8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 32,
                      width: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor.colorB3,
                        ),
                        onPressed: () => widget.eventOnTap(event),
                        child: const Center(child: KIcon.readMore),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: KEdgeInsets.symH_12 + KEdgeInsets.onlyRight_4,
                child: Card(
                  child: Padding(
                    padding: KEdgeInsets.all_8,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 156,
                          child: Center(
                            child: Text(event.name),
                          ),
                        ),
                        const SizedBox(
                          height: 48.0,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),
                        ),
                        SizedBox(
                          width: 96,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'start: ${event.startDateTime.month}/${event.startDateTime.day}'),
                              Text(
                                  ' end : ${event.endDateTime.month}/${event.endDateTime.day}'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
