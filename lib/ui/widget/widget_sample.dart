part of widget;

class Sample extends StatefulWidget {
  const Sample({super.key});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> with SingleTickerProviderStateMixin {
  bool? toggle;

  final List<Offset> points = <Offset>[
    const Offset(15, 100),
    const Offset(100, 30),
    const Offset(0, 30),
    const Offset(85, 100),
  ];

  @override
  Widget build(BuildContext context) {
    final appColor = context.preference.appColor;
    return Material(
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            clipBehavior: Clip.hardEdge,
            shape: KBorder.circle,
            child: InkWell(
              splashColor: appColor.colorD2,
              onTap: () {
                late final MyOverlayEntry entry;

                void insertOrAB() {
                  log('$toggle');
                  toggle = CustomOverlay.insertOrAB(
                    overlay: context.overlay,
                    entry: entry,
                    isB: toggle ?? false,
                  );
                }

                entry = MyOverlayEntry(
                  builder: (context) => Center(
                    child: Container(
                      width: 200,
                      height: 400,
                      decoration: KBoxDecoration.none,
                      child: GestureDetector(
                        onTapDown: (detail) {
                          points.add(detail.localPosition);
                          insertOrAB();
                        },
                        child: VContainer.squareRed_100,
                      ),
                    ),
                  ),
                );


                if (toggle != null && toggle == true) {
                  context.overlay.removeLast();
                  toggle = null;
                } else {
                  insertOrAB();
                }
              },
              child: const Padding(
                padding: KEdgeInsets.all_10,
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
