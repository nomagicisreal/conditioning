part of calendar;

///
/// this file contains:
/// [ScreenDailyNote]
/// [ViewCalendarDailyNote]
/// [CellDailyNote]
/// [ViewDailyNoteDetail]
///
///

class ScreenDailyNote extends StatefulWidget {
  const ScreenDailyNote({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenDailyNote> createState() => _ScreenDailyNoteState();
}

class _ScreenDailyNoteState extends State<ScreenDailyNote> {
  DateTime? _selectedDate;
  bool _isSelectingSelectedDate = false;

  @override
  Widget build(BuildContext context) {
    final mainColor = context.preference.appColor;
    return Scaffold(
      backgroundColor: mainColor.colorB1,
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: !_isSelectingSelectedDate,
            child: AnimatedOpacity(
              opacity: _isSelectingSelectedDate ? 1.0 : 0.4,
              duration: KDuration.milli300,
              child: ViewDailyNoteDetail(
                dateTime: _selectedDate ?? DateTime.now(),
                enable: _isSelectingSelectedDate,
                backButtonPressed: () => setState(
                  () => _isSelectingSelectedDate = false,
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: _isSelectingSelectedDate,
            child: AnimatedOpacity(
              opacity: _isSelectingSelectedDate ? 0.0 : 1.0,
              duration: KDuration.milli300,
              child: ViewCalendarDailyNote(
                selectDate: (selectedDate) => setState(
                  () => _selectedDate = selectedDate,
                ),
                selectSelectedDate: () => setState(
                  () => _isSelectingSelectedDate = true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewCalendarDailyNote extends StatefulWidget {
  const ViewCalendarDailyNote({
    Key? key,
    required this.selectDate,
    required this.selectSelectedDate,
  }) : super(key: key);
  final void Function(DateTime selectedDate) selectDate;
  final VoidCallback selectSelectedDate;

  @override
  State<ViewCalendarDailyNote> createState() => _ViewCalendarDailyNoteState();
}

class _ViewCalendarDailyNoteState extends State<ViewCalendarDailyNote> {
  late final ValueNotifier<DateTime> _focusedDay;
  late DateTime _selectedDate;

  @override
  void initState() {
    _focusedDay = ValueNotifier(DateTime.now());
    _selectedDate = _focusedDay.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = context.preference.appColor;
    return Center(
      child: SizedBox(
        height: 420,
        child: TableCalendar(
          shouldFillViewport: true,
          locale: 'zh',
          focusedDay: _focusedDay.value,
          firstDay: DateTime.utc(1911, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          selectedDayPredicate: (date) => isSameDay(_selectedDate, date),
          onDaySelected: (selectedDate, focusedDate) {
            _focusedDay.value = focusedDate;

            setState(() {
              if (isSameDay(_selectedDate, selectedDate)) {
                widget.selectSelectedDate();
              } else {
                widget.selectDate(selectedDate);
                _selectedDate = selectedDate;
                // TODO: show AnimatedFinger around selected day
              }
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay.value = focusedDay;
            setState(() => _selectedDate = focusedDay);
          },
          pageJumpingEnabled: true,
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, builtDate, focusedDate) {
              return CellDailyNote(
                cellType: TableCalendarCellType.defaultDay,
                dateText: builtDate.day.toString(),
              );
            },
            outsideBuilder: (context, builtDate, focusedDate) {
              return CellDailyNote(
                cellType: TableCalendarCellType.outsideDay,
                dateText: builtDate.day.toString(),
              );
            },
            todayBuilder: (context, builtDate, focusedDate) {
              return CellDailyNote(
                cellType: TableCalendarCellType.today,
                dateText: builtDate.day.toString(),
              );
            },
            selectedBuilder: (context, builtDate, focusedDate) {
              return CellDailyNote(
                cellType: TableCalendarCellType.selectedDay,
                dateText: builtDate.day.toString(),
              );
            },
            headerTitleBuilder: (context, dateTime) => null,
          ),
          daysOfWeekVisible: false,

          // TODO: custom header with AnimatedArrow
          // headerVisible: false,
          headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              headerPadding: KEdgeInsets.symH_12,
              leftChevronIcon:
                  Icon(Icons.chevron_left, color: mainColor.colorD2),
              rightChevronIcon:
                  Icon(Icons.chevron_right, color: mainColor.colorD1)),
          // onCalendarCreated: (controller) => pageController = controller,
        ),
      ),
    );
  }
}

class CellDailyNote extends StatelessWidget {
  const CellDailyNote({
    Key? key,
    required this.cellType,
    required this.dateText,
  }) : super(key: key);
  final TableCalendarCellType cellType;
  final String dateText;

  @override
  Widget build(BuildContext context) {
    const defaultDecoration = KShapeDecoration.roundRect_8;
    final mainColor = context.preference.appColor;

    switch (cellType) {
      case TableCalendarCellType.defaultDay:
        return defaultAnimatedContainer(
          duration: KDuration.milli300,
          textStyle: const TextStyle(color: Colors.black45),
          decoration: defaultDecoration,
        );
      case TableCalendarCellType.outsideDay:
        return defaultAnimatedContainer(
          duration: KDuration.milli300,
          textStyle: const TextStyle(color: Colors.black26),
          decoration: defaultDecoration,
        );
      case TableCalendarCellType.today:
        return defaultAnimatedContainer(
          duration: KDuration.milli300,
          textStyle: KTextStyle.boldBlack,
          decoration: ShapeDecoration(
            color: mainColor.colorB1,
            shape: KBorderWithRadius.roundRect_8,
          ),
        );
      case TableCalendarCellType.selectedDay:
        return defaultAnimatedContainer(
          duration: KDuration.milli300,
          textStyle: KTextStyle.kWhite,
          decoration: BoxDecoration(
            color: mainColor.colorB3,
            shape: BoxShape.circle,
          ),
        );
    }
  }

  Widget defaultAnimatedContainer({
    required Duration duration,
    required Decoration decoration,
    required TextStyle textStyle,
  }) {
    const defaultCalendarStyle = CalendarStyle();
    final defaultMargin = defaultCalendarStyle.cellMargin;
    final defaultPadding = defaultCalendarStyle.cellPadding;
    final defaultAlignment = defaultCalendarStyle.cellAlignment;

    return AnimatedContainer(
      duration: duration,
      margin: defaultMargin,
      padding: defaultPadding,
      alignment: defaultAlignment,
      decoration: decoration,
      child: AnimatedDefaultTextStyle(
        style: textStyle,
        duration: duration,
        child: Text(dateText),
      ),
    );
  }
}

class ViewDailyNoteDetail extends StatefulWidget {
  const ViewDailyNoteDetail({
    Key? key,
    required this.dateTime,
    required this.enable,
    required this.backButtonPressed,
  }) : super(key: key);
  final DateTime dateTime;
  final bool enable;
  final VoidCallback backButtonPressed;

  @override
  State<ViewDailyNoteDetail> createState() => _ViewDailyNoteDetailState();
}

class _ViewDailyNoteDetailState extends State<ViewDailyNoteDetail> {
  late final double _windowHeight;
  late final FocusNode _focusNode;
  late final TextEditingController _noteController;

  late DailyNote? _note;

  String get _noteId => "${_newDay.year.toString()} "
      "${_newDay.month.toString()} "
      "${_newDay.day.toString()}";
  late DateTime _newDay;

  // final currentHour = dateTime.hour.toString();
  // final currentMinute = dateTime.minute.toString();
  // final currentSecond = dateTime.second.toString();

  late final DailyNoteLocalDatabaseProvider _database;
  bool _databaseOpen = false;

  Future<void> _saveNote() async {
    if (_noteController.text.isEmpty) {
      if (await _database.itemExist(_noteId)) {
        // TODO: show a dialog, make sure user want delete

        await _deleteNote();
      }
    } else {
      final newNote = DailyNote(id: _noteId, content: _noteController.text);

      if (_note == null) {
        await _database.itemInsert(newNote);
      } else {
        await _database.itemUpdate(_noteId, newNote);
      }
    }
  }

  Future<void> _deleteNote() async => await _database.itemDelete(_noteId);

  late Future<void> _getNoteFutureInstance;

  Future<void> _getNote() async {
    if (!_databaseOpen) {
      await _database.open();
      // await _database.close();
      // await _database.remove();
      _databaseOpen = true;
    }

    _note = await _database.itemGet(_noteId);
    _noteController.text = _note != null ? _note!.content : '';
  }

  @override
  void initState() {
    _windowHeight = windowSize.height;
    _focusNode = FocusNode();
    _database = DailyNoteLocalDatabaseProvider();
    _noteController = TextEditingController();
    _newDay = widget.dateTime;

    _getNoteFutureInstance = _getNote();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ViewDailyNoteDetail oldWidget) {
    final oldDay = oldWidget.dateTime;
    final newDay = widget.dateTime;
    if (!isSameDay(oldDay, newDay)) {
      _newDay = newDay;
      _getNoteFutureInstance = _getNote();
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
                  AnimatedOpacity(
                    opacity: widget.enable ? 1.0 : 0.0,
                    duration: KDuration.milli300,
                    child: IconButton(
                      onPressed: () {
                        _saveNote();

                        widget.backButtonPressed();
                      },
                      icon: const BackButtonIcon(),
                    ),
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
            onTap: () => setState(() => _focusNode.requestFocus()),
            focusColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Container(
              constraints: BoxConstraints.tightFor(
                // TODO: base on the size of keyboard
                height: widget.enable && _focusNode.hasFocus
                    ? _windowHeight * 0.45
                    : _windowHeight * 0.75,
              ),
              child: Padding(
                padding: KEdgeInsets.symH_12,
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: _getNoteFutureInstance,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return TextField(
                            enabled: widget.enable,
                            autofocus: widget.enable,
                            focusNode: _focusNode,
                            onTap: () => setState(_focusNode.requestFocus),
                            controller: _noteController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'note'),
                          );
                        default:
                          return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: widget.enable ? 1.0 : 0.0,
            duration: KDuration.milli300,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: KIcon.photo,
                  iconSize: 20.0,
                  splashRadius: 20.0,
                  onPressed: kVoidCallback,
                ),
                IconButton(
                  icon: KIcon.mailOutline,
                  iconSize: 20.0,
                  splashRadius: 20.0,
                  onPressed: kVoidCallback,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
