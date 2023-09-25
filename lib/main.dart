import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// App feature elements.
import 'package:hearthstone_api/features/app/data/router.dart';

// Supabase feature elements.
import 'package:hearthstone_api/features/supabase/providers/client.dart';

// If we need to do anything before bootstrapping the app
// it belongs here.
Future<void> main() async {
  await Hive.initFlutter();

  runApp(
    const ProviderScope(
      child: AppEntry(),
    ),
  );
}

///
/// The main entry widget for the application.
///
class AppEntry extends ConsumerWidget {
  const AppEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// This node is used for removing focus from anything else in the app.
    final mainFocus = FocusNode();

    /// Make sure supabase client is configured.
    final _ = ref.watch(getSupabaseClientProvider);

    final textTheme = Theme.of(context).textTheme;
    final sliderTheme = SliderThemeData.fromPrimaryColors(
      primaryColor: Colors.deepOrange,
      primaryColorDark: Colors.deepOrange[700]!,
      primaryColorLight: Colors.deepOrange[100]!,
      valueIndicatorTextStyle: GoogleFonts.roboto(textStyle: textTheme.labelSmall),
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          FocusScope.of(context).requestFocus(mainFocus);
        }
      },
      child: MaterialApp.router(
        routerDelegate: router.delegate(),
        routeInformationParser: router.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        title: 'Hearthstone Card Searcher',
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        ),
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          sliderTheme: sliderTheme.copyWith(
            trackHeight: 5,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 20),
          ),
          chipTheme: ChipThemeData(
            brightness: Brightness.light,
            backgroundColor: Colors.grey[300]!,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            labelStyle: GoogleFonts.neuton(
              textStyle: textTheme.bodySmall?.copyWith(color: Colors.black87),
            ),
            secondaryLabelStyle: GoogleFonts.neuton(
              textStyle: textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
            secondarySelectedColor: Colors.deepOrange,
            selectedColor: Colors.deepOrange,
            disabledColor: Colors.grey[300]!,
          ),
          textTheme: GoogleFonts.ralewayTextTheme(textTheme).copyWith(
            bodySmall: GoogleFonts.neuton(textStyle: textTheme.bodySmall),
            bodyLarge: GoogleFonts.neuton(textStyle: textTheme.bodyLarge),
            bodyMedium: GoogleFonts.neuton(textStyle: textTheme.bodyMedium),
            displayLarge: GoogleFonts.roboto(textStyle: textTheme.displayLarge),
            displayMedium: GoogleFonts.roboto(textStyle: textTheme.displayMedium),
            displaySmall: GoogleFonts.roboto(textStyle: textTheme.displaySmall),
            headlineMedium: GoogleFonts.roboto(textStyle: textTheme.headlineMedium),
            headlineSmall: GoogleFonts.roboto(
              textStyle: textTheme.headlineSmall?.copyWith(fontSize: 24),
            ),
            titleLarge: GoogleFonts.roboto(
              textStyle: textTheme.titleLarge?.copyWith(
                fontSize: 18,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            titleMedium: GoogleFonts.raleway(
              textStyle: textTheme.titleMedium?.copyWith(fontSize: 14, letterSpacing: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
