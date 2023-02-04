/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrowLeftIcon.svg
  SvgGenImage get arrowLeftIcon =>
      const SvgGenImage('assets/icons/arrowLeftIcon.svg');

  /// File path: assets/icons/calendarEventIcon.svg
  SvgGenImage get calendarEventIcon =>
      const SvgGenImage('assets/icons/calendarEventIcon.svg');

  /// File path: assets/icons/calendarIcon.svg
  SvgGenImage get calendarIcon =>
      const SvgGenImage('assets/icons/calendarIcon.svg');

  /// File path: assets/icons/clockIcon.svg
  SvgGenImage get clockIcon => const SvgGenImage('assets/icons/clockIcon.svg');

  /// File path: assets/icons/fileAddingIcon.svg
  SvgGenImage get fileAddingIcon =>
      const SvgGenImage('assets/icons/fileAddingIcon.svg');

  /// File path: assets/icons/locationIcon.svg
  SvgGenImage get locationIcon =>
      const SvgGenImage('assets/icons/locationIcon.svg');

  /// File path: assets/icons/logOutIcon.svg
  SvgGenImage get logOutIcon =>
      const SvgGenImage('assets/icons/logOutIcon.svg');

  /// File path: assets/icons/moreDotsIcon.svg
  SvgGenImage get moreDotsIcon =>
      const SvgGenImage('assets/icons/moreDotsIcon.svg');

  /// File path: assets/icons/pencilEditIcon.svg
  SvgGenImage get pencilEditIcon =>
      const SvgGenImage('assets/icons/pencilEditIcon.svg');

  /// File path: assets/icons/searchIcon.svg
  SvgGenImage get searchIcon =>
      const SvgGenImage('assets/icons/searchIcon.svg');

  /// File path: assets/icons/userProfileIcon.svg
  SvgGenImage get userProfileIcon =>
      const SvgGenImage('assets/icons/userProfileIcon.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        arrowLeftIcon,
        calendarEventIcon,
        calendarIcon,
        clockIcon,
        fileAddingIcon,
        locationIcon,
        logOutIcon,
        moreDotsIcon,
        pencilEditIcon,
        searchIcon,
        userProfileIcon
      ];
}

class Assets {
  Assets._();

  static const SvgGenImage beluga = SvgGenImage('assets/beluga.svg');
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const SvgGenImage uploadImage = SvgGenImage('assets/uploadImage.svg');

  /// List of all assets
  List<SvgGenImage> get values => [beluga, uploadImage];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
