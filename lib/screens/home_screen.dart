import 'package:flutter/material.dart';
import 'package:sugar_balance/blocs/home_page_bloc.dart';
import 'package:sugar_balance/components/title_bar.dart';
import 'package:sugar_balance/navigation/keys.dart';
import 'package:sugar_balance/navigation/routes.dart';
import 'package:sugar_balance/utils/date_utils.dart';
import 'package:sugar_balance/widgets/radial_progress.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  HomePageBloc _homePageBloc;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    _homePageBloc = HomePageBloc();
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    _homePageBloc.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  TopBar(),
                  Positioned(
                    top: 60.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 35.0,
                          ),
                          onPressed: () {
                            _homePageBloc.subtractDate();
                          },
                        ),
                        StreamBuilder(
                          stream: _homePageBloc.dateStream,
                          initialData: _homePageBloc.selectedDate,
                          builder: (context, snapshot) {
                            return Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    formatterDayOfWeek.format(snapshot.data),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                        color: Colors.white,
                                        letterSpacing: 1.2),
                                  ),
                                  Text(
                                    formatterDate.format(snapshot.data),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Transform.rotate(
                          angle: 135.0,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            onPressed: () {
                              _homePageBloc.addDate();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              RadialProgress(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: Keys.addReading,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Routes.addReading);
        },
      ),
    );
  }
}

class MonthlyStatusListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              MonthlyStatusRow('February 2017', 'On going'),
              MonthlyStatusRow('January 2017', 'Failed'),
              MonthlyStatusRow('December 2016', 'Completed'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              MonthlyTargetRow('Lose weight', '3.8 ktgt/7 kg'),
              MonthlyTargetRow('Running per month', '15.3 km/20 km'),
              MonthlyTargetRow('Avg steps Per day', '10000/10000'),
            ],
          ),
        ],
      ),
    );
  }
}

class MonthlyStatusRow extends StatelessWidget {
  final String monthYear, status;

  MonthlyStatusRow(this.monthYear, this.status);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            monthYear,
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          Text(
            status,
            style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class MonthlyTargetRow extends StatelessWidget {
  final String target, targetAchieved;

  MonthlyTargetRow(this.target, this.targetAchieved);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            target,
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          Text(
            targetAchieved,
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
