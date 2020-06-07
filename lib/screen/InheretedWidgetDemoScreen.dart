import 'package:flutter/material.dart';

class InheretedWidgetDemoScreen extends StatelessWidget {
  static const ROUTE_NAME = '/inhereted-widget-demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InheretedWidgetDemo(
        child: InheretedWidgetDemoScreenInner1(),
      ),
    );
  }
}

class InheretedWidgetDemoScreenInner1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Desde inner1: " + InheretedWidgetDemo.of(context).nombre),
          InheretedWidgetDemoScreenInner2(),
        ]);
  }
}

class InheretedWidgetDemoScreenInner2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Desde inner2: " + InheretedWidgetDemo.of(context).nombre),
      ],
    );
  }
}

class InheretedWidgetDemo extends InheritedWidget {
  final String nombre = 'Propiedad heredada';

  InheretedWidgetDemo({Key key, @required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheretedWidgetDemo oldWidget) =>
      oldWidget.nombre != this.nombre;

  static InheretedWidgetDemo of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheretedWidgetDemo>();
}
