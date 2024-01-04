import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  /*static final ligth = FlexThemeData.light(
    scheme: FlexScheme.blueM3,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    appBarStyle: FlexAppBarStyle.primary,
    blendLevel: 7,
    swapColors: true,
    appBarOpacity:
        0.95, //opacidade da barra de aplicativos como 0.95, tornando-a um pouco transparente.
    appBarElevation: 0,
    transparentStatusBar:
        true, //Torna a barra de status do dispositivo transparente.
    /* subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
      inputDecoratorRadius: 15,
    ),*/
    useMaterial3ErrorColors: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,

    fontFamily: GoogleFonts.openSans().fontFamily,
  );*/

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
