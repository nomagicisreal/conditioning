part of calendar;

///
/// this file contains:
/// [SampleTableCalendarNote]
/// [_SampleTableCalendarDailyNoteViewCalendar]
/// [_SampleTableCalendarDailyNoteElementMonthArrow]
/// [_SampleTableCalendarDailyNoteElementDateCell]
/// [_SampleTableCalendarDailyNoteViewDailyNote]
///
/// TODO: complete all the personal note usage, no matter daily note or other type of note
///
///

class SampleTableCalendarNote extends StatefulWidget {
  SampleTableCalendarNote({
    super.key,
    DateTime? initialDateTime,
  }) : initialFocusedDay = initialDateTime ?? DateTime.now();

  final DateTime initialFocusedDay;

  @override
  State<SampleTableCalendarNote> createState() =>
      _SampleTableCalendarNoteState();
}

class _SampleTableCalendarNoteState
    extends State<SampleTableCalendarNote> {
  final MyOverlay _overlay = MyOverlay();

  void _showSelectedDateNoteDetail(DateTime dateTime) {
    bool shouldBackToCalendarView = false;
    _overlay.addFadingEntry(
      context: context,
      shouldFadeOut: () => shouldBackToCalendarView,
      builder: (context) => _SampleTableCalendarDailyNoteViewDailyNote(
        dateTime: dateTime,
        backButtonPressed: () {
          shouldBackToCalendarView = true;
          _overlay.removeLast();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.preference.appColor.colorB1,
      child: _SampleTableCalendarDailyNoteViewCalendar(
        initialFocusedDay: widget.initialFocusedDay,
        onSelectingSelectedDate: _showSelectedDateNoteDetail,
      ),
    );
  }
}

class _SampleTableCalendarDailyNoteViewCalendar extends StatefulWidget {
  const _SampleTableCalendarDailyNoteViewCalendar({
    super.key,
    this.animatedMonthArrow = true,
    required this.initialFocusedDay,
    // required this.onSelectDate,
    required this.onSelectingSelectedDate,
  });

  final DateTime initialFocusedDay;

  // final Processor<DateTime> onSelectDate;
  final Processor<DateTime> onSelectingSelectedDate;
  final bool animatedMonthArrow;

  @override
  State<_SampleTableCalendarDailyNoteViewCalendar> createState() =>
      _SampleTableCalendarDailyNoteViewCalendarState();
}

class _SampleTableCalendarDailyNoteViewCalendarState
    extends State<_SampleTableCalendarDailyNoteViewCalendar> {
  late final DateTime _focusedDay;
  late DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = _focusedDay = widget.initialFocusedDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 420,
        child: TableCalendar(
          shouldFillViewport: true,
          // locale: 'zh',
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(1911, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          selectedDayPredicate: FPredicator.isSameDayWith(_selectedDate),
          onDaySelected: (selectedDate, focusedDate) {
            _focusedDay = focusedDate;

            setState(() {
              if (isSameDay(_selectedDate, selectedDate)) {
                widget.onSelectingSelectedDate(selectedDate);
              } else {
                _selectedDate = selectedDate;
                // TODO: show AnimatedFinger around selected day
              }
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          pageJumpingEnabled: true,
          calendarBuilders: CalendarBuilders(
            prioritizedBuilder: null,
            todayBuilder: TableCalendarDayCell.today.builderStyle1,
            selectedBuilder: TableCalendarDayCell.selected.builderStyle1,
            rangeStartBuilder: null,
            rangeEndBuilder: null,
            withinRangeBuilder: null,
            rangeHighlightBuilder: null,
            outsideBuilder: TableCalendarDayCell.outside.builderStyle1,
            disabledBuilder: null,
            holidayBuilder: null,
            defaultBuilder: TableCalendarDayCell.normal.builderStyle1,
            singleMarkerBuilder: null,
            markerBuilder: null,
            dowBuilder: null,
            headerTitleBuilder: (context, dateTime) => null,
            weekNumberBuilder: null,
          ),
          daysOfWeekVisible: false,
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            headerPadding: KEdgeInsets.symH_12,
            leftChevronIcon: _SampleTableCalendarDailyNoteElementMonthArrow(
              isPrevious: true,
              // isAnimatable: null,
            ),
            rightChevronIcon: _SampleTableCalendarDailyNoteElementMonthArrow(
              isPrevious: false,
              // isAnimatable: null,
            ),
          ),
          // onCalendarCreated: (controller) => pageController = controller,
        ),
      ),
    );
  }
}

class _SampleTableCalendarDailyNoteElementMonthArrow extends StatelessWidget {
  const _SampleTableCalendarDailyNoteElementMonthArrow._({
    super.key,
    required this.iconBuilder,
  });

  factory _SampleTableCalendarDailyNoteElementMonthArrow({
    Direction3DIn6 directionA = Direction3DIn6.left,
    Direction3DIn6 directionB = Direction3DIn6.right,
    DurationFR? isAnimatable = KDurationFR.second1,
    required bool isPrevious,
  }) {
    final iconData = switch (directionA) {
      Direction3DIn6.left => switch (directionB) {
          Direction3DIn6.right =>
            isPrevious ? Icons.chevron_left : Icons.chevron_right,
          _ => throw UnimplementedError(),
        },
      _ => throw UnimplementedError(),
    };

    Icon iconOf(BuildContext context) => Icon(
          iconData,
          color: context.preference.appColor.colorD1,
        );

    final end =
        (isPrevious ? KOffsetDirection.left : KOffsetDirection.right) * 0.2;

    final iconBuilder = isAnimatable != null
        ? (context) => MyAnimationSin.slider(
              amplitudePosition: end,
              times: 1,
              child: iconOf(context),
            )
        : iconOf;

    return _SampleTableCalendarDailyNoteElementMonthArrow._(
        iconBuilder: iconBuilder);
  }

  final WidgetBuilder iconBuilder;

  @override
  Widget build(BuildContext context) => iconBuilder(context);
}

class _SampleTableCalendarDailyNoteViewDailyNote extends StatefulWidget {
  const _SampleTableCalendarDailyNoteViewDailyNote({
    super.key,
    required this.dateTime,
    required this.backButtonPressed,
  });

  final DateTime dateTime;
  final VoidCallback backButtonPressed;

  @override
  State<_SampleTableCalendarDailyNoteViewDailyNote> createState() =>
      _SampleTableCalendarDailyNoteViewDailyNoteState();
}

class _SampleTableCalendarDailyNoteViewDailyNoteState
    extends State<_SampleTableCalendarDailyNoteViewDailyNote> {
  late final FocusNode _focusNode;
  late final TextEditingController _noteController;

  // late DailyNote? _note;

  String get _noteId => "${_newDay.year.toString()} "
      "${_newDay.month.toString()} "
      "${_newDay.day.toString()}";
  late DateTime _newDay;

  // final currentHour = dateTime.hour.toString();
  // final currentMinute = dateTime.minute.toString();
  // final currentSecond = dateTime.second.toString();

  // late final DailyNoteLocalDatabaseProvider _database;
  bool _databaseOpen = false;

  Future<void> _saveNote() async {
    if (_noteController.text.isEmpty) {
      //   if (await _database.itemExist(_noteId)) {
      //     // TODO: show a dialog, make sure user want delete
      //
      //     await _deleteNote();
      //   }
      // } else {
      //   final newNote = DailyNote(id: _noteId, content: _noteController.text);
      //
      //   if (_note == null) {
      //     await _database.itemInsert(newNote);
      //   } else {
      //     await _database.itemUpdate(_noteId, newNote);
      //   }
    }
  }

  // Future<void> _deleteNote() async => await _database.itemDelete(_noteId);

  late Future<void> _futureNote;

  Future<void> _getNote() async {
    if (!_databaseOpen) {
      // await _database.open();
      // await _database.close();
      // await _database.remove();
      _databaseOpen = true;
    }

    // _note = await _database.itemGet(_noteId);
    // _noteController.text = _note != null ? _note!.content : '';
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    // _database = DailyNoteLocalDatabaseProvider();
    _noteController = TextEditingController();
    _newDay = widget.dateTime;

    _futureNote = _getNote();
    super.initState();
  }

  @override
  void didUpdateWidget(
      covariant _SampleTableCalendarDailyNoteViewDailyNote oldWidget) {
    final dateTime = widget.dateTime;
    if (!FDateTime.isSameDay(oldWidget.dateTime, dateTime)) {
      _newDay = dateTime;
      _futureNote = _getNote();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _noteController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      _saveNote();

                      widget.backButtonPressed();
                    },
                    icon: kBackButton,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${widget.dateTime.month} / ${widget.dateTime.day}')
                ],
              )
            ],
          ),
          InkWell(
            focusColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Padding(
              padding: KEdgeInsets.symH_18,
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: _futureNote,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return TextField(
                          enabled: true,
                          autofocus: true,
                          focusNode: _focusNode,
                          onTap: _focusNode.requestFocus,
                          controller: _noteController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: KDecorationInput.collapsed
                              .copyWith(hintText: 'note'),
                        );
                      default:
                        return KProgressIndicator.circular;
                    }
                  },
                ),
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: KIconMaterial.photo,
                iconSize: 20.0,
                splashRadius: 20.0,
                onPressed: kVoidCallback,
              ),
              IconButton(
                icon: KIconMaterial.mailOutline,
                iconSize: 20.0,
                splashRadius: 20.0,
                onPressed: kVoidCallback,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
