import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';

class CustomFlexibleSpaceBar extends StatefulWidget {
  /// Creates a flexible space bar.
  ///
  /// Most commonly used in the [AppBar.flexibleSpace] field.
  const CustomFlexibleSpaceBar({
    Key key,
    this.title,
    this.background,
    this.centerTitle
  }) : super(key: key);

  /// The primary contents of the flexible space bar when expanded.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Shown behind the [title] when expanded.
  ///
  /// Typically an [Image] widget with [Image.fit] set to [BoxFit.cover].
  final Widget background;

  /// Whether the title should be centered.
  ///
  /// Defaults to being adapted to the current [TargetPlatform].
  final bool centerTitle;

  /// Wraps a widget that contains an [AppBar] to convey sizing information down
  /// to the [FlexibleSpaceBar].
  ///
  /// Used by [Scaffold] and [SliverAppBar].
  static Widget createSettings({
    double toolbarOpacity,
    double minExtent,
    double maxExtent,
    @required double currentExtent,
    @required Widget child,
  }) {
    assert(currentExtent != null);
    return new CustomFlexibleSpaceBarSettings(
      toolbarOpacity: toolbarOpacity ?? 1.0,
      minExtent: minExtent ?? currentExtent,
      maxExtent: maxExtent ?? currentExtent,
      currentExtent: currentExtent,
      child: child,
    );
  }

  @override
  CustomFlexibleSpaceBarState createState() => new CustomFlexibleSpaceBarState();
}

class CustomFlexibleSpaceBarState extends State<CustomFlexibleSpaceBar> {
  bool _getEffectiveCenterTitle(ThemeData theme) {
    if (widget.centerTitle != null)
      return widget.centerTitle;
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return false;
      case TargetPlatform.iOS:
        return true;
    }
    return null;
  }

  Alignment _getTitleAlignment(bool effectiveCenterTitle) {
    if (effectiveCenterTitle)
      return Alignment.bottomCenter;
    final TextDirection textDirection = Directionality.of(context);
    assert(textDirection != null);
    switch (textDirection) {
      case TextDirection.rtl:
        return Alignment.bottomRight;
      case TextDirection.ltr:
        return Alignment.bottomLeft;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final CustomFlexibleSpaceBarSettings settings = context.inheritFromWidgetOfExactType(CustomFlexibleSpaceBarSettings);
//    assert(settings != null, 'A FlexibleSpaceBar must be wrapped in the widget returned by FlexibleSpaceBar.createSettings().');

    final List<Widget> children = <Widget>[];

    final double deltaExtent = settings.maxExtent - settings.minExtent;

    // 0.0 -> Expanded
    // 1.0 -> Collapsed to toolbar
    final double t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0);

    // background image
    if (widget.background != null) {
      final double fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
      const double fadeEnd = 1.0;
      assert(fadeStart <= fadeEnd);
      final double opacity = 1.0 - new Interval(fadeStart, fadeEnd).transform(t);
      final double parallax = new Tween<double>(begin: 0.0, end: deltaExtent / 4.0).lerp(t);
      if (opacity > 0.0) {
        children.add(new Positioned(
            top: -parallax,
            left: 0.0,
            right: 0.0,
            height: settings.maxExtent,
            child: new Opacity(
                opacity: opacity,
                child: widget.background
            )
        ));
      }
    }

    if (widget.title != null) {
      Widget title;
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          title = widget.title;
          break;
        case TargetPlatform.fuchsia:
        case TargetPlatform.android:
          title = new Semantics(
            namesRoute: true,
            child: widget.title,
          );
      }

      final ThemeData theme = Theme.of(context);
      final double opacity = settings.toolbarOpacity;
      if (opacity > 0.0) {
        TextStyle titleStyle = theme.primaryTextTheme.title;
        titleStyle = titleStyle.copyWith(
            color: titleStyle.color.withOpacity(opacity)
        );
        final bool effectiveCenterTitle = _getEffectiveCenterTitle(theme);
        final double scaleValue = new Tween<double>(begin: 1.5, end: 1.0).lerp(t);
        final Matrix4 scaleTransform = new Matrix4.identity()
          ..scale(scaleValue, scaleValue, 1.0);
        final Alignment titleAlignment = _getTitleAlignment(effectiveCenterTitle);
        children.add(new Container(
            padding: new EdgeInsetsDirectional.only(
                start: effectiveCenterTitle ? 0.0 : 72.0,
                bottom: 16.0
            ),
            child: new Transform(
                alignment: titleAlignment,
                transform: scaleTransform,
                child: new Align(
                    alignment: titleAlignment,
                    child: new DefaultTextStyle(
                      style: titleStyle,
                      child: title,
                    )
                )
            )
        ));
      }
    }

    return new ClipRect(child: new Stack(children: children));
  }
}

class CustomFlexibleSpaceBarSettings extends InheritedWidget {
  const CustomFlexibleSpaceBarSettings({
    Key key,
    this.toolbarOpacity,
    this.minExtent,
    this.maxExtent,
    this.currentExtent,
    Widget child,
  }) : super(key: key, child: child);

  final double toolbarOpacity;
  final double minExtent;
  final double maxExtent;
  final double currentExtent;

  @override
  bool updateShouldNotify(CustomFlexibleSpaceBarSettings oldWidget) {
    return toolbarOpacity != oldWidget.toolbarOpacity
        || minExtent != oldWidget.minExtent
        || maxExtent != oldWidget.maxExtent
        || currentExtent != oldWidget.currentExtent;
  }
}
