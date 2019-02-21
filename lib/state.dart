import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('计数器')
        ),
        body: new CounterWidget()
      )
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key key,
    this.initValue: 0
  });

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  void initState() {
    super.initState();
    // 初始化状态
    _counter = widget.initValue;
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Center(
      child: FlatButton(
        child: Text('$_counter'),
        onPressed: () => setState(() => ++_counter),
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget 完成更新');
  }

  @override 
  void deactivate() {
    super.deactivate();
    print('deactivate 关闭、解除');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose 部署');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble 重组');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies 完成改变依赖');
  }
}