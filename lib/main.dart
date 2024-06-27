import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Application>? apps;
  PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
    loadApps();
  }

  Future<void> loadApps() async {
    List<Application> installedApps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
    );

    setState(() {
      apps = installedApps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          TimeScreen(), // Screen to show only time
          AppListScreen(apps: apps), // Screen to show list of apps
          MainScreen(), // Main home screen
        ],
      ),
    );
  }
}

class TimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        DateFormat.Hm().format(DateTime.now()), // Display current time
        style: TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
  }
}

class AppListScreen extends StatelessWidget {
  final List<Application>? apps;

  const AppListScreen({Key? key, this.apps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App List'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: apps == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: apps!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              apps![index].appName,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Home Screen'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Main Home Screen',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
