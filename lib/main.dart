import 'package:MyTaste/components/drawer.dart';
import 'package:MyTaste/pages/FilterPage.dart';
import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'HomeBody.dart';
import 'constants.dart';

Alice alice;
Dio dio;

Future<void> main() async {
  await DotEnv().load('.env');
  dio = Dio(
    BaseOptions(baseUrl: zomatoSearchURL, headers: {
      'user-key': DotEnv().env['ZomatoAPI2'],
      'Accept': 'application/json',
    }),
  );
  alice = Alice(
      navigatorKey: navigatorKey, showNotification: true, darkTheme: true);
  dio.interceptors.add(alice.getDioInterceptor());

  runApp(MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        '/': (context) => MyHomePage(),
        '/FilterPage': (context) => SearchFilter()
      },
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        drawer: myDrawer(context),
        body: HomeBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text("MyTaste"),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/FilterPage');
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              child: Icon(Icons.tune),
            ),
          ),
        )
      ],
    );
  }
}
