import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

Future<String> loadAssets() async {
  return await rootBundle.loadString('assets/config.json');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'flutter', home: new Count(title: '计数器'),
        // 注册路由表
        routes: {"new_page": (context) => MapRoute('MapRoute argument')});
  }
}

class Count extends StatefulWidget {
  Count({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CountState createState() => new _CountState();
}

class _CountState extends State<Count> {
  int _counter = 0;

  void _addCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new NewRoute()));
              },
              textColor: Colors.red,
              child: Text('走你'),
            ),
            FlatButton(
              child: Text('去吧'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'new_page');
              },
            ),
            new RandomWordWidget(),
            // Text(loadAssets().toString()),
            Image.asset('images/oschina.png'),
            DecoratedBox(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('images/oschina.png'))),
            ),
            FlatButton(
              child: Text('查看 flutter State 生命周期'),
              textColor: Colors.purple,
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CounterWidget()
                        // builder: (context) => Text('xxx')
                    )
                  );
              },
            ),
            FlatButton(
              child: Text('dome1', style: TextStyle(fontSize: 30.0),),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new TapboxA()
                  )
                );
              },
            ),
            FlatButton(
              child: Text('demo2', style: TextStyle(fontSize: 30.0),),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new ParentWidget())
                );
              },
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new ParentWidgetC())
                );
              },
              child: Text('demo3', style: TextStyle(fontSize: 30.0, color: Colors.deepOrange),),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCounter,
        tooltip: '加',
        child: Icon(Icons.add),
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('新页面')),
        body: Echo(
          text: 'hello world',
          backgroundColor: Colors.red,
        ));
  }
}

class MapRoute extends StatelessWidget {
  MapRoute(this.tip);
  final String tip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MapRoute'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('这个是通过注册路由表来的一个页面'), Text('$tip')],
          ),
        ));
  }
}

// 使用english_words包来生成随机字符串。
class RandomWordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return Padding(
      child: Text(wordPair.toString(),
          style: TextStyle(fontSize: 30.0, color: Colors.orange)),
      padding: EdgeInsets.all(8.0),
    );
  }
}

class Echo extends StatelessWidget {
  const Echo({
    Key key,
    @required this.text,
    @required this.backgroundColor,
  }) : super(key: key);

  final String text;
  final Color backgroundColor;

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key key, this.initValue: 0});

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
    return Scaffold(
        appBar: AppBar(title: Text('state 生命周期')),
        body: Center(
          child: FlatButton(
            child: Text('$_counter'),
            onPressed: () => setState(() => ++_counter),
          ),
        ));
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget 完成更新');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate 关闭、路由');
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

// 1, TapboxA Widget管理自己的state。
class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => new _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('state 切换')
      ),
      body: Center(
        child: GestureDetector(
          onTap: _handleTap,
          child: Container(
            child: Center(
              child: Text(
                _active ? 'Active' : 'Inactive',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: _active ? Colors.red[700] : Colors.blue[600]
            ),
          ),
        )

      )
    );
  }
}

// 2, ParentWidget 父widget管理子widget状态
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChange(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new TapboxB(
        active:_active,
        onChange: _handleTapboxChange
      )
    );
  }
}

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChange}) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChange;

  void handleTap() {
    onChange(!active);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('demo2')
      ),
      body: Center(
        child: GestureDetector(
          onTap: handleTap,
          child: Container(
            child: Center(
              child: Text(active ? 'active' : 'inactive', style: TextStyle(fontSize: 30.0, color: Colors.white),),
            ),
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: active ? Colors.blue : Colors.green
            ),
          ),
        ),
      )
    );
  }
}

// 混合管理（父widget和子widget都管理状态）
class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => new _ParentWidgetCState(); 
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleChange(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('demo3 混合管理状态')
      ),
      body:Center(
        child: new TapboxC(
          active: _active,
          onChange: _handleChange
        )
      )
    );
  }
}

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChange}) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChange;

  @override
  _TapboxCState createState() => new _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _onTapHandle() {
    widget.onChange(!widget.active);
  }

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: _onTapHandle,
        onTapCancel: _onTapCancel,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Container(
          child: Center(
            child: Text(widget.active ? 'active' : 'inactive', style: TextStyle(fontSize: 30.0, color: Colors.white),),
          ),
          width: 200.0,
          height: 200.0,
          decoration:BoxDecoration(
            color: widget.active ? Colors.black : Colors.yellow,
            border: _highlight ? Border.all(width: 10.0, color: Colors.teal[700]) : null
          ),
        ),
      );
    }
}
