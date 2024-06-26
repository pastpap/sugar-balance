import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sugarbalance/blocs/filtered_reads/filtered_reads.dart';
import 'package:sugarbalance/blocs/home_page_bloc.dart';
import 'package:sugarbalance/components/title_bar.dart';
import 'package:sugarbalance/models/models.dart';
import 'package:sugarbalance/navigation/flutter_read_keys.dart';
import 'package:sugarbalance/navigation/keys.dart';
import 'package:sugarbalance/navigation/routes.dart';
import 'package:sugarbalance/themes/colors.dart';
import 'package:sugarbalance/utils/date_utils.dart';
import 'package:sugarbalance/utils/screen_sizes.dart';
import 'package:sugarbalance/widgets/filtered_reads.dart';
import 'package:sugarbalance/widgets/loading_indicator.dart';
import 'package:sugarbalance/widgets/radial_progress.dart';
import 'package:sugarbalance/widgets/readings_graph.dart';

class MyHomePage extends StatefulWidget {
  final HomePageBloc? homePageBloc;

  const MyHomePage({Key? key, this.homePageBloc}) : super(key: key);
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  HomePageBloc? _homePageBloc;
  late AnimationController _iconAnimationController;

  @override
  void initState() {
    _homePageBloc = widget.homePageBloc;
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    _homePageBloc!.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredReadsBloc = BlocProvider.of<FilteredReadsBloc>(context);
    bool bigPhone = MediaQuery.of(context).size.height > smallPhoneHeight;
    return BlocBuilder(
        bloc: filteredReadsBloc,
        builder: (context, dynamic state) {
          if (state is FilteredReadLoading) {
            return LoadingIndicator(key: Keys.readsLoading);
          } else if (state is FilteredReadLoaded) {
            final reads = state.filteredReads;
            return Scaffold(
              body: SlidingUpPanel(
                renderPanelSheet: false,
                color: Colors.purpleAccent,
                collapsed: _floatingCollapsed(),
                panel: _floatingPanel(),
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
                                      _homePageBloc!.subtractDate();
                                    },
                                  ),
                                  StreamBuilder(
                                    stream: _homePageBloc!.dateStream,
                                    initialData: _homePageBloc!.selectedDate,
                                    builder: (context, snapshot) {
                                      return Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              formatterDayOfWeek.format(
                                                  DateTime.parse(snapshot.data
                                                      .toString())),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24.0,
                                                  color: Colors.white,
                                                  letterSpacing: 1.2),
                                            ),
                                            Text(
                                              formatterDate.format(
                                                  DateTime.parse(snapshot.data
                                                      .toString())),
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
                                        _homePageBloc!.addDate();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        bigPhone
                            ? buildRadialProgressAndChartColumn(reads)
                            : Container(
                                height: 320,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 50.0,
                                            color: Colors.black12,
                                          ),
                                        ),
                                        buildRadialProgressAndChartColumn(
                                            reads),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: FloatingActionButton(
                  key: Keys.addReading,
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.addReading);
                  },
                ),
              ),
            );
          } else {
            return Container(key: FlutterReadsKeys.filteredReadsEmptyContainer);
          }
        });
  }

  Column buildRadialProgressAndChartColumn(List<Reading> reads) {
    return Column(
      children: <Widget>[
        RadialProgress(
          highestOfToday: getHighestReadToday(reads),
        ),
        Container(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
            child: reads.isEmpty
                ? Icon(
                    Icons.insert_chart,
                    size: 200.0,
                    color: Colors.black12,
                  )
                : ReadingsGraph(
                    reads: reads,
                    animate: true,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _floatingCollapsed() {
    return Container(
      decoration: BoxDecoration(
        color: firstColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Center(
        child: Text(
          "Swipe up for today's readings",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
  }

  Widget _floatingPanel() {
    return Container(
      decoration: BoxDecoration(
          color: secondColor,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.grey,
            ),
          ]),
      margin: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
        margin: const EdgeInsets.only(top: 24.0),
        child: FilteredReads(),
      ),
    );
  }

  double getHighestReadToday(List<Reading> filteredReads) {
    double result = 0;
    filteredReads.forEach((element) {
      if (result < element.value!) {
        result = element.value!.toDouble();
      }
    });
    return result;
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
