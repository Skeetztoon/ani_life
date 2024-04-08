import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ThemeExtensions on BuildContext {
  // //Можно юзать context.colors вместо Theme.of(context).extension<AppColors>
  // AppColors get colors => Theme.of(this).extension<AppColors>()!;
  //
  // //context.textStyles вместо Theme.of(context).extension<AppTextStyles>
  // AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;

  //context.locale вместо AppLocalizations.of(context)
  AppLocalizations? get locale => AppLocalizations.of(this);
}
