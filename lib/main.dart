import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(new MyApp());

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Demo'),
      ),
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeBlue,
          child: Text('ios风格的Buttton'),
          onPressed: () {},
        ),
      ),
    );
  }
}

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
            RaisedButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark, // 按钮主题
              splashColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Text('文本字体样式'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new TextFontStyle()));
              },
            ),
            FlatButton(child: Text('按钮'),onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new Button())
              );
            },),
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
                        ));
              },
            ),
            MaterialButton(
              child: Text(
                'dome1',
                style: TextStyle(fontSize: 30.0),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new TapboxA()));
              },
            ),
            FlatButton(
              child: Text(
                'demo2',
                style: TextStyle(fontSize: 30.0),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ParentWidget()));
              },
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ParentWidgetC()));
              },
              child: Text(
                'demo3',
                style: TextStyle(fontSize: 30.0, color: Colors.deepOrange),
              ),
            ),
            MaterialButton(
              child: Text(
                '去瞅瞅ios风格的页面咯',
                style: TextStyle(fontSize: 30.0, color: Colors.red[900]),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CupertinoTestRoute()));
              },
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


// 自定义 Scaffold
class MyScaffold extends StatelessWidget {
  MyScaffold(this.myTitle, this.myBody);

  final String myTitle;
  final Widget myBody;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text(myTitle)),
      body: myBody
    );
  }
}

// 文本字体样式
class TextFontStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MyScaffold('文本字体样式',
        Column(
          children: <Widget>[
            Text(
              'Text("Hello world", textAlign: TextAlign.center,) textAlign：文本的对齐方式；可以选择左对齐、右对齐还是居中。注意，对齐的参考系是Text widget本身。本例中虽然是指定了居中对齐，但因为Text文本内容宽度不足一行，Text的宽度和文本内容长度相等，那么这时指定对齐方式是没有意义的，只有Text宽度大于文本内容长度时指定此属性才有意义。',
              textAlign: TextAlign.center,
            ),
            Text(
              'maxLines、overflow：指定文本显示的最大行数，默认情况下，文本是自动折行的，如果指定此参数，则文本最多不会超过指定的行。如果有多余的文本，可以通过overflow来指定截断方式，默认是直接截断，本例中指定的截断方式TextOverflow.ellipsis，它会将多余文本截断后以省略符“...”表示；TextOverflow的其它截断方式请参考SDK文档。',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'textScaleFactor：代表文本相对于当前字体大小的缩放因子，相对于去设置文本的样式style属性的fontSize，它是调整字体大小的一个快捷方式。该属性的默认值可以通过MediaQueryData.textScaleFactor获得，如果没有MediaQuery，那么会默认值将为1.0。',
              textScaleFactor: 1.5,
            ),
            Text(
              'TextStyle\ncolor: Colors.blue,\nfontSize: 30,\nheight: 1.2, \nfontFamily: "Courier",\nbackground: new Paint()..color=Colors.yellow,\ndecoration: TextDecoration.underline,\ndecorationStyle: TextDecorationStyle.dashed,',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                height: 1.2,
                fontFamily: 'Courier',
                background: new Paint()..color = Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
              textAlign: TextAlign.center,
            ),
            Text.rich(
              TextSpan(style: TextStyle(fontSize: 30.0),children: [
              TextSpan(text: 'Home:'),
              TextSpan(
                  text: 'https://flutter.io',
                  style: TextStyle(color: Colors.blue))
            ])),
            DefaultTextStyle(
              style: TextStyle(
                color: Colors.red,
                fontSize: 20.0
              ),
              textAlign: TextAlign.right,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('hello flutter'),
                  Text('I am is jack'),
                  Text('i am is bobo', style: TextStyle(
                    inherit: false,
                    color: Colors.blue
                  ),)
                ],
              ),
            )
          ],
        ));
  }
}

// 按钮
class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MyScaffold('按钮', 
     Center(child: Column(children: <Widget>[
       RaisedButton(child: Text('RaisedButton'),onPressed: () {},),
       FlatButton(child: Text('FlatButton'), onPressed: () {},),
       OutlineButton(child: Text('OutlineButton'),onPressed: () {},),
       IconButton(icon: Icon(Icons.thumb_up), onPressed: () {},),
       RaisedButton(child: Text('自定义按钮'), onPressed: () {},
        color: Colors.blue, 
        highlightColor: Colors.blue[700], // 点击时高亮
        colorBrightness: Brightness.dark,
        splashColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
       )
     ],)
      )
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
        appBar: AppBar(title: Text('state 切换')),
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
                color: _active ? Colors.red[700] : Colors.blue[600]),
          ),
        )));
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
        child: new TapboxB(active: _active, onChange: _handleTapboxChange));
  }
}

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChange})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChange;

  void handleTap() {
    onChange(!active);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('demo2')),
        body: Center(
          child: GestureDetector(
            onTap: handleTap,
            child: Container(
              child: Center(
                child: Text(
                  active ? 'active' : 'inactive',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
              width: 200.0,
              height: 200.0,
              decoration:
                  BoxDecoration(color: active ? Colors.blue : Colors.green),
            ),
          ),
        ));
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
        appBar: AppBar(title: Text('demo3 混合管理状态')),
        body: Center(
            child: new TapboxC(active: _active, onChange: _handleChange)));
  }
}

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChange})
      : super(key: key);

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
          child: Text(
            widget.active ? 'active' : 'inactive',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            color: widget.active ? Colors.black : Colors.yellow,
            border: _highlight
                ? Border.all(width: 10.0, color: Colors.teal[700])
                : null),
      ),
    );
  }
}
