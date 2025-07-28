import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonScaffold extends StatelessWidget {
  final String? title;
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Drawer? drawer;
  final Drawer? endDrawer;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawerScrim;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final Key? scaffoldKey;

  const CommonScaffold({
    Key? key,
    this.title,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.drawer,
    this.endDrawer,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.persistentFooterButtons,
    this.drawerScrim,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Or any color you want
        statusBarIconBrightness: Brightness.dark, // Android: dark icons (black)
        statusBarBrightness: Brightness.light, // iOS: dark icons (black)
      ),
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar ??
            (title != null
                ? AppBar(
              title: Text(title!),
            )
                : null),
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        drawer: drawer,
        endDrawer: endDrawer,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColor,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        persistentFooterButtons: persistentFooterButtons,
        drawerScrimColor: drawerScrim != null ? Colors.transparent : null,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      ),
    );
  }
}
