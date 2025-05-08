import 'package:driver/Public/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double maxItemWidth=900;
const double paddingSize=30;
const double borderSize=1;

const Color accentColor=Color(0xff413A8C);
const Color accentColor2=Color(0xffFFC910);

const Color accentColorShade100=Color(0xffFDEDE8);
const Color accentColorShade200=Color(0xffF7C6B4);
const Color accentColorShade300=Color(0xffF29D81);
const Color accentColorShade400=Color(0xffED744E);
const Color accentColorShade500=Color(0xffE84B1B);
const Color accentColorShade600=Color(0xffB33A14);
const Color accentColorShade700=Color(0xff7F290E);
const Color accentColorShade800=Color(0xff4B1808);
const Color accentColorShade900=Color(0xff170702);

const Color dominantColor=Color(0xff283992);
const Color dominantColorShade100=Color(0xffEBEDFA);
const Color additionalColor1Shade101=Color(0xffF8F8FF);
const Color dominantColorShade200=Color(0xffBBC0E0);
const Color dominantColorShade300=Color(0xff8A93C6);
const Color dominantColorShade400=Color(0xff5966AC);
const Color dominantColorShade500=Color(0xff283992);
const Color dominantColorShade600=Color(0xff202C74);
const Color dominantColorShade700=Color(0xff172054);
const Color dominantColorShade800=Color(0xff0E1434);
const Color dominantColorShade900=Color(0xff050814);

const Color additionalColor1=Color(0xff534A5D);
const Color additionalColor1Shade100=Color(0xffF2F1F4);
const Color additionalColor1Shade200=Color(0xffCBC8CF);
const Color additionalColor1Shade300=Color(0xffA39EA9);
const Color additionalColor1Shade400=Color(0xff7B7483);
const Color additionalColor1Shade500=Color(0xff534A5D);
const Color additionalColor1Shade600=Color(0xff433B4A);
const Color additionalColor1Shade700=Color(0xff312B36);
const Color additionalColor1Shade800=Color(0xff1F1B22);
const Color additionalColor1Shade900=Color(0xff0D0B0E);

const Color additionalColor2=Color(0xff969EB4);
const Color additionalColor2Shade100=Color(0xffF0F1F4);
const Color additionalColor2Shade200=Color(0xffDBDDE4);
const Color additionalColor2Shade300=Color(0xffC4C8D4);
const Color additionalColor2Shade400=Color(0xffADB3C4);
const Color additionalColor2Shade500=Color(0xff969EB4);
const Color additionalColor2Shade600=Color(0xff747B8A);
const Color additionalColor2Shade700=Color(0xff515661);
const Color additionalColor2Shade800=Color(0xff2E3138);
const Color additionalColor2Shade900=Color(0xff0B0C0F);

const Color complementaryColor=Color(0xffBAC4DE);
const Color complementaryColorShade100=Color(0xffEEF0F7);
const Color complementaryColorShade200=Color(0xffE1E5F0);
const Color complementaryColorShade300=Color(0xffD4DAEA);
const Color complementaryColorShade400=Color(0xffC7CFE4);
const Color complementaryColorShade500=Color(0xffBAC4DE);
const Color complementaryColorShade600=Color(0xff8F95AA);
const Color complementaryColorShade700=Color(0xff626777);
const Color complementaryColorShade800=Color(0xff353944);
const Color complementaryColorShade900=Color(0xff080B11);

const Color errorColor=Color(0xffC30000);
const Color errorLightColor5=Color(0xffED2E2E);
const Color errorExtraLightColor5=Color(0xffFFF2F2);

const Color successColor=Color(0xff00966D);
const Color successLightColor5=Color(0xff00BA88);
const Color successExtraLightColor5=Color(0xffF3FDFA);

const Color warningColor=Color(0xffA9791C);
const Color warningLightColor=Color(0xffF4B740);
const Color warningExtraLightColor=Color(0xffFFF8E1);

const Color blackColor=Color(0xff000000);
const Color whiteColor=Color(0xffFFFFFF);

final List<BoxShadow> boxShadow=[BoxShadow(color: blackColor.withOpacity(0.1),blurRadius: 4,offset: Offset(0,4))];

 Map<int, Color> _primaryMap = {
  50: appColor.withOpacity(0.05),
  100: appColor.withOpacity(0.1),
  200: appColor.withOpacity(0.2),
  300: appColor.withOpacity(0.3),
  400: appColor.withOpacity(0.4),
  500: appColor.withOpacity(0.5),
  600: appColor.withOpacity(0.6),
  700: appColor.withOpacity(0.7),
  800: appColor.withOpacity(0.8),
  900: appColor.withOpacity(0.9),
};

 MaterialColor primarySwatch = MaterialColor(appColor.value, _primaryMap);