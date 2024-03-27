import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static final ligth = FlexThemeData.light(
    scheme: FlexScheme.gold,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    swapColors: true,
    useMaterial3ErrorColors: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: GoogleFonts.openSans().fontFamily,
  );
}
