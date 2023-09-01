part of widget;

class CustomApp extends StatelessWidget {
  const CustomApp({
    super.key,
    required this.screen,
    this.theme,
  });

  final Screen screen;
  final ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: theme,
      initialRoute: screen.name,
      title: 'Conditioning',
      // onGenerateRoute: (s) => s.toScreenSettings.pageRouteBuilder,
      // onGenerateRoute: (s) => s.toPageRouteBuilder,
      // home: screen.widget,
      home: screen.widget,
    );
  }
}
