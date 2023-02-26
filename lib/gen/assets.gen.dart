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

class $AssetsImgGen {
  const $AssetsImgGen();

  $AssetsImgBannersGen get banners => const $AssetsImgBannersGen();
  $AssetsImgIconsGen get icons => const $AssetsImgIconsGen();
}

class $AssetsImgBannersGen {
  const $AssetsImgBannersGen();

  /// File path: assets/img/banners/bath4.jpg
  AssetGenImage get bath4 =>
      const AssetGenImage('assets/img/banners/bath4.jpg');

  /// File path: assets/img/banners/panda.jpg
  AssetGenImage get panda =>
      const AssetGenImage('assets/img/banners/panda.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [bath4, panda];
}

class $AssetsImgIconsGen {
  const $AssetsImgIconsGen();

  /// File path: assets/img/icons/brightness.svg
  SvgGenImage get brightness =>
      const SvgGenImage('assets/img/icons/brightness.svg');

  /// File path: assets/img/icons/devices.svg
  SvgGenImage get devices => const SvgGenImage('assets/img/icons/devices.svg');

  /// File path: assets/img/icons/fan.svg
  SvgGenImage get fan => const SvgGenImage('assets/img/icons/fan.svg');

  /// File path: assets/img/icons/heating.svg
  SvgGenImage get heating => const SvgGenImage('assets/img/icons/heating.svg');

  /// File path: assets/img/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/img/icons/home.svg');

  /// File path: assets/img/icons/home_temp.svg
  SvgGenImage get homeTemp =>
      const SvgGenImage('assets/img/icons/home_temp.svg');

  /// File path: assets/img/icons/internet.svg
  SvgGenImage get internet =>
      const SvgGenImage('assets/img/icons/internet.svg');

  /// File path: assets/img/icons/lamp.svg
  SvgGenImage get lamp => const SvgGenImage('assets/img/icons/lamp.svg');

  /// File path: assets/img/icons/manage.svg
  SvgGenImage get manage => const SvgGenImage('assets/img/icons/manage.svg');

  /// File path: assets/img/icons/panda_icon.svg
  SvgGenImage get pandaIcon =>
      const SvgGenImage('assets/img/icons/panda_icon.svg');

  /// File path: assets/img/icons/percent.svg
  SvgGenImage get percent => const SvgGenImage('assets/img/icons/percent.svg');

  /// File path: assets/img/icons/selsius.svg
  SvgGenImage get selsius => const SvgGenImage('assets/img/icons/selsius.svg');

  /// File path: assets/img/icons/setting.svg
  SvgGenImage get setting => const SvgGenImage('assets/img/icons/setting.svg');

  /// File path: assets/img/icons/sound.svg
  SvgGenImage get sound => const SvgGenImage('assets/img/icons/sound.svg');

  /// File path: assets/img/icons/temp.svg
  SvgGenImage get temp => const SvgGenImage('assets/img/icons/temp.svg');

  /// File path: assets/img/icons/water.svg
  SvgGenImage get water => const SvgGenImage('assets/img/icons/water.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        brightness,
        devices,
        fan,
        heating,
        home,
        homeTemp,
        internet,
        lamp,
        manage,
        pandaIcon,
        percent,
        selsius,
        setting,
        sound,
        temp,
        water
      ];
}

class Assets {
  Assets._();

  static const $AssetsImgGen img = $AssetsImgGen();
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
