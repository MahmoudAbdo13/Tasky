import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension WidgetExtension on Widget? {
  Padding paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  ClipRRect cornerRadiusWithClipRRect(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  Widget expand({flex = 1}) => Expanded(flex: flex, child: this!);

  Padding paddingTop(double top) {
    return Padding(padding: EdgeInsets.only(top: top), child: this);
  }

  Padding paddingLeft(double left) {
    return Padding(padding: EdgeInsets.only(left: left), child: this);
  }

  /// return padding right
  Padding paddingRight(double right) {
    return Padding(padding: EdgeInsets.only(right: right), child: this);
  }

  /// return padding bottom
  Padding paddingBottom(double bottom) {
    return Padding(padding: EdgeInsets.only(bottom: bottom), child: this);
  }

  /// return padding all
  Padding paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  /// return custom padding from each side
  Padding paddingOnly({
    double top = 0.0,
    double left = 0.0,
    double bottom = 0.0,
    double right = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }

  /// set visibility
  Widget visible(bool visible, {Widget? defaultWidget}) {
    return visible ? this! : (defaultWidget ?? const SizedBox());
  }

  /// set parent widget in center
  Widget center({double? heightFactor, double? widthFactor}) {
    return Center(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: this,
    );
  }
}

/// Int extensions
extension IntExtensions on int? {
  /// Leaves given width of space
  Widget get width => SizedBox(width: this?.toDouble());

  /// Leaves given height of space
  Widget get height => SizedBox(height: this?.toDouble());
}

/// String extensions
extension StringExtension on String? {
  /// Returns true if given String is null or isEmpty
  bool get isEmptyOrNull =>
      this == null ||
          (this != null && this!.isEmpty) ||
          (this != null && this! == 'null');

  // Check null string, return given value if null
  String validate({String value = ''}) {
    if (isEmptyOrNull) {
      return value;
    } else {
      return this!;
    }
  }

  /// Capitalize given String
  String capitalizeFirstLetter() => (validate().isNotEmpty)
      ? (this!.substring(0, 1).toUpperCase() + this!.substring(1).toLowerCase())
      : validate();
}

/// Context Extensions
extension ContextExtensions on BuildContext {
  /// Return the height of status bar
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// return screen size
  Size size() => MediaQuery.of(this).size;

  /// return screen width
  double width() => MediaQuery.of(this).size.width;

  /// return screen height
  double height() => MediaQuery.of(this).size.height;

  /// return screen devicePixelRatio
  double pixelRatio() => MediaQuery.of(this).devicePixelRatio;

  /// returns brightness
  Brightness platformBrightness() => MediaQuery.of(this).platformBrightness;
}