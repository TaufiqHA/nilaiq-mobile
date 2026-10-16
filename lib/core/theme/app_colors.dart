import 'package:flutter/material.dart';

/// A palette that mirrors the NilaiQ website design tokens
/// (converted from the OKLCH values defined in `resources/css/app.css`).
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.brand,
    required this.brandStrong,
    required this.brandSoft,
    required this.heading,
    required this.body,
    required this.borderColor,
    required this.borderMedium,
    required this.pageBg,
    required this.cardBg,
    required this.tertiary,
    required this.secondarySoft,
    required this.disabled,
    required this.danger,
    required this.dangerSoft,
  });

  final Color brand;
  final Color brandStrong;
  final Color brandSoft;
  final Color heading;
  final Color body;
  final Color borderColor;
  final Color borderMedium;
  final Color pageBg;
  final Color cardBg;
  final Color tertiary;
  final Color secondarySoft;
  final Color disabled;
  final Color danger;
  final Color dangerSoft;

  static const Color brandDefault = Color(0xFF006FFE);
  static const Color brandStrongDefault = Color(0xFF0054E2);
  static const Color brandSoftDefault = Color(0x26006FFE);

  /// Radius token (`--radius-base: 0.75rem`).
  static const double radius = 12;
  static const double radiusXs = 6;

  static const AppPalette light = AppPalette(
    brand: Color(0xFF006FFE),
    brandStrong: Color(0xFF0054E2),
    brandSoft: Color(0x26006FFE),
    heading: Color(0xFF071117),
    body: Color(0xFF4C575F),
    borderColor: Color(0xFFD8DFE4),
    borderMedium: Color(0xFFD2D8DD),
    pageBg: Color(0xFFF3FAFF),
    cardBg: Colors.white,
    tertiary: Color(0xFFE2E9EE),
    secondarySoft: Color(0xFFECF3F8),
    disabled: Color(0xFF7B8186),
    danger: Color(0xFFC53443),
    dangerSoft: Color(0x1AC53443),
  );

  static const AppPalette dark = AppPalette(
    brand: Color(0xFF006FFE),
    brandStrong: Color(0xFF0054E2),
    brandSoft: Color(0x33006FFE),
    heading: Color(0xFFE9F0F5),
    body: Color(0xFF9BA3AA),
    borderColor: Color(0xFF172128),
    borderMedium: Color(0xFF202A32),
    pageBg: Color(0xFF0B1117),
    cardBg: Color(0xFF121A21),
    tertiary: Color(0xFF16202A),
    secondarySoft: Color(0xFF0F171E),
    disabled: Color(0xFF50565A),
    danger: Color(0xFFED7477),
    dangerSoft: Color(0x33ED7477),
  );

  @override
  AppPalette copyWith({
    Color? brand,
    Color? brandStrong,
    Color? brandSoft,
    Color? heading,
    Color? body,
    Color? borderColor,
    Color? borderMedium,
    Color? pageBg,
    Color? cardBg,
    Color? tertiary,
    Color? secondarySoft,
    Color? disabled,
    Color? danger,
    Color? dangerSoft,
  }) {
    return AppPalette(
      brand: brand ?? this.brand,
      brandStrong: brandStrong ?? this.brandStrong,
      brandSoft: brandSoft ?? this.brandSoft,
      heading: heading ?? this.heading,
      body: body ?? this.body,
      borderColor: borderColor ?? this.borderColor,
      borderMedium: borderMedium ?? this.borderMedium,
      pageBg: pageBg ?? this.pageBg,
      cardBg: cardBg ?? this.cardBg,
      tertiary: tertiary ?? this.tertiary,
      secondarySoft: secondarySoft ?? this.secondarySoft,
      disabled: disabled ?? this.disabled,
      danger: danger ?? this.danger,
      dangerSoft: dangerSoft ?? this.dangerSoft,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) {
      return this;
    }

    return AppPalette(
      brand: Color.lerp(brand, other.brand, t)!,
      brandStrong: Color.lerp(brandStrong, other.brandStrong, t)!,
      brandSoft: Color.lerp(brandSoft, other.brandSoft, t)!,
      heading: Color.lerp(heading, other.heading, t)!,
      body: Color.lerp(body, other.body, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderMedium: Color.lerp(borderMedium, other.borderMedium, t)!,
      pageBg: Color.lerp(pageBg, other.pageBg, t)!,
      cardBg: Color.lerp(cardBg, other.cardBg, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      secondarySoft: Color.lerp(secondarySoft, other.secondarySoft, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      dangerSoft: Color.lerp(dangerSoft, other.dangerSoft, t)!,
    );
  }
}

/// Convenient access to the [AppPalette] from any [BuildContext].
extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}
