import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'welcome to flutter',
      routes: <String,WidgetBuilder>{
        '/RoutePage': (BuildContext context) => new RoutePage()
      },
      home: new LoginPage()
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  static const LOGO = 'images/oschina.png';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 10.0),
            child: new Image.asset(LOGO)
            // child:Text('where is my image wwww' , style: new TextStyle(color: Colors.red),)
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 50.0, 30.0, 10.0),
            child: new TextField(
              decoration: new InputDecoration(
                hintText: '请输入用户名'
              ),
              // controller: TextEditingController(),
            ),
          ),
          new Container(
            width: 300.0,
            margin: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: new Card(
              color: Colors.green,
              elevation: 6.0,
              child: new FlatButton(
                onPressed:() {
                  Navigator.pushNamed(context, '/RoutePage');
                },
                child: new Padding(
                  padding:EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: Text('马上登录', style: TextStyle(color: Colors.white, fontSize: 18.0),)
                )
              ),
            )
          )
        ],
      )
    );
  }
}

class RoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 新页面
    return Scaffold(
        appBar: AppBar(
          title: Text('router-page'),
        ),
        body: Center(child: Text('这是路由页面'),)
      );
  }
}