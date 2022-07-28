import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../controls/home_screen_control.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:gold_health/apps/data/fakeData.dart';
import 'package:gold_health/apps/global_widgets/GradientText.dart';
import 'package:gold_health/apps/pages/dashboard/activity_trackerScreen.dart';
import 'package:gold_health/apps/routes/routeName.dart';
import '../../template/misc/colors.dart';
import 'widgets/button_gradient.dart';
import '../../controls/notification_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int touchedIndex = -1;
  double height_bmi_container = 0;
  double height_slideValue = 20;
  double weight_slideValue = 100;
  double height_process_container = 0;
  double value = 0;
  final List<int> _list = [for (int i = 1; i <= 140; i++) i];
  @override
  Widget build(BuildContext context) {
    var _heightDevice = MediaQuery.of(context).size.height;
    var _widthDevice = MediaQuery.of(context).size.width;

    final homeScreenController = Get.find<HomeScreenControl>();

    final List<String> timeProgress = [
      '6am - 8am',
      '8am - 10am',
      '1pm - 3pm',
      '3pm - 5pm'
    ];
    final Map<String, String> litersProgress = {
      '6am - 8am': '600ml',
      '8am - 10am': '250ml',
      '1pm - 3pm': '500ml'
    };
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 10,
          left: 20,
          right: 20,
        ),
        // height: _heightDevice,
        // width: _widthDevice,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Container(
              child: ListTile(
                isThreeLine: true,
                title: Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.headline5,
                ),
                // trailing: InkWell(
                //   borderRadius: BorderRadius.circular(15),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => NotifiCationScreen(),
                //       ),
                //     );
                //   },
                // child: Container(
                //   padding: const EdgeInsets.all(5),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     color: AppColors.primaryColor.withOpacity(0.2),
                //     ),
                //     child: Icon(
                //       Icons.notifications,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                trailing: Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(RouteName.notificationScreen);
                      },
                      icon: Obx(
                        () => SvgPicture.asset(
                          homeScreenController.isNotify
                              ? 'assets/icons/Notification-Icon_RedDot.svg'
                              : 'assets/icons/Notification-Icon.svg',
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Hoang Truong',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 24,
                      ),
                ),
              ),
            ),
            Container(
              // curve: Curves.fastOutSlowIn,
              // duration: const Duration(seconds: 20),
              padding: const EdgeInsets.only(
                  top: 30, bottom: 10, left: 10, right: 10),

              //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: AppColors.colorGradient1,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'BMI (Body Mass Index)',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'You have a normal weight',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ButtonGradient(
                            width: 120,
                            height: 44,
                            linearGradient: LinearGradient(
                              colors: [
                                Colors.purple[100]!,
                                Colors.purple[200]!
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                height_bmi_container =
                                    (height_bmi_container - 200).abs();
                              });
                            },
                            title: const Text(
                              'View More',
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 12.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          width: 80,
                          height: 80,
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                  });
                                },
                              ),
                              startDegreeOffset: 180,
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 1,
                              centerSpaceRadius: 0,
                              sections: FakeData.data
                                  .asMap()
                                  .map<int, PieChartSectionData>((index, data) {
                                    final isTouched = index == touchedIndex;
                                    final double fontSize = isTouched ? 25 : 16;
                                    final double radius = isTouched ? 100 : 80;

                                    return MapEntry(
                                      index,
                                      PieChartSectionData(
                                        color: data.color,
                                        value: data.percents,
                                        title: (data.name == 'now')
                                            ? '${data.percents}'
                                            : '',
                                        radius: isTouched ? 80 : 60,
                                        titleStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        titlePositionPercentageOffset: 0.55,
                                        badgeWidget: _Badge(
                                          data.imagePath,
                                          size: isTouched ? 40.0 : 30.0,
                                          borderColor: data.color,
                                        ),
                                        badgePositionPercentageOffset: .98,
                                      ),
                                    );
                                  })
                                  .values
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    height: height_bmi_container,
                    width: double.infinity,
                    duration: const Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _Badge(
                                  'assets/images/medal.png',
                                  size: 30,
                                  borderColor: AppColors.primaryColor1,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'BMI: 38.0',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Height:  ',
                                  style: TextStyle(
                                    color: AppColors.primaryColor1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                LoadHeight_weight(
                                  widthDevice: _widthDevice,
                                  imgePath: 'assets/images/height.png',
                                  fData: 120,
                                  sData: 177,
                                  color: AppColors.primaryColor1,
                                  press: () {},
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 60),
                                Text(
                                  '160cm',
                                  style: TextStyle(
                                      color: AppColors.primaryColor1,
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Text(
                                  '180cm',
                                  style: TextStyle(
                                      color: AppColors.primaryColor1,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Weight: ',
                                  style: TextStyle(
                                    color: AppColors.primaryColor2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                LoadHeight_weight(
                                  widthDevice: _widthDevice,
                                  imgePath: 'assets/images/weight.png',
                                  fData: 30,
                                  sData: 70,
                                  color: AppColors.primaryColor2,
                                  press: () {},
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 60),
                                Text(
                                  '60kg',
                                  style: TextStyle(
                                      color: AppColors.primaryColor2,
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Text(
                                  '80kg',
                                  style: TextStyle(
                                      color: AppColors.primaryColor2,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25, bottom: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: AppColors.colorContainerTodayTarget,
              ),
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Process',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                      ),
                      Spacer(),
                      ButtonGradient(
                        height: 40.0,
                        width: 90.0,
                        linearGradient: LinearGradient(
                          colors: [
                            Colors.blue[200]!,
                            Colors.blue[300]!,
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            height_process_container =
                                (height_process_container - 300).abs();
                          });
                        },
                        title: const Text(
                          'Check',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn,
                    height: height_process_container,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Day 1',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.primaryColor1),
                                  child: Text(
                                    'Start Over',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: _widthDevice,
                            height: 190,
                            child: MasonryGridView.count(
                              crossAxisCount: 6,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              itemCount: _list.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/calendar.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '${_list[index]}',
                                        style: TextStyle(
                                          color: AppColors.primaryColor1,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadHeight_weight(
                                widthDevice: _widthDevice * 100 / 55 * 0.7,
                                imgePath: 'assets/images/medal.png',
                                fData: 60,
                                sData: 100,
                                color: AppColors.primaryColor1,
                                press: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: _heightDevice * 0.6,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Activity Status',
                          overflow: TextOverflow.clip,
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          height: _heightDevice * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 232, 243, 252),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  'Heart Rate',
                                  style: TextStyle(
                                    fontFamily: 'Sen',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: GradientText(
                                  '78 BPM',
                                  gradient: AppColors.colorGradient1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                              Container(
                                height: _heightDevice * 0.1,
                                child: LineChart(
                                  LineChartData(
                                    borderData: FlBorderData(show: false),
                                    gridData: FlGridData(show: false),
                                    titlesData: FlTitlesData(show: false),
                                    lineTouchData: LineTouchData(
                                      enabled: true,
                                      touchTooltipData: LineTouchTooltipData(
                                        tooltipRoundedRadius: 20,
                                        tooltipBgColor: AppColors.primaryColor1,
                                        getTooltipItems: (List<LineBarSpot>
                                            touchedBarSpots) {
                                          return touchedBarSpots.map((barSpot) {
                                            final flSpot = barSpot;
                                            return LineTooltipItem(
                                              '${flSpot.x.toInt()}mins ago',
                                              const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                    minX: 1,
                                    maxX: 30,
                                    minY: 80,
                                    maxY: 170,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: const [
                                          FlSpot(1, 100),
                                          FlSpot(2, 130),
                                          FlSpot(3, 90),
                                          FlSpot(4, 150),
                                          FlSpot(5, 110),
                                          FlSpot(6, 120),
                                          FlSpot(7, 100),
                                          FlSpot(8, 120),
                                          FlSpot(9, 125),
                                          FlSpot(10, 100),
                                          FlSpot(11, 90),
                                          FlSpot(12, 150),
                                          FlSpot(13, 85),
                                          FlSpot(14, 100),
                                          FlSpot(15, 80),
                                          FlSpot(16, 100),
                                          FlSpot(17, 130),
                                          FlSpot(18, 90),
                                          FlSpot(19, 150),
                                          FlSpot(20, 110),
                                          FlSpot(21, 120),
                                          FlSpot(22, 100),
                                          FlSpot(23, 120),
                                          FlSpot(24, 125),
                                          FlSpot(25, 100),
                                          FlSpot(26, 90),
                                          FlSpot(27, 150),
                                          FlSpot(28, 85),
                                          FlSpot(29, 100),
                                          FlSpot(30, 120),
                                        ],
                                        barWidth: 2,
                                        dotData: FlDotData(show: false),
                                        gradient: AppColors.colorGradient,
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: AppColors
                                              .colorContainerTodayTarget,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient:
                                        AppColors.colorContainerTodayTarget,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: _heightDevice * 0.4,
                                width: _widthDevice * 0.45,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(0.5, 0.5),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Water Intake',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      '10 Liters',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    const SizedBox(height: 7),
                                    const Text(
                                      'Real time updates',
                                      style: TextStyle(
                                        fontFamily: 'Sen',
                                        fontSize: 15,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Divider(),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          child: Column(
                                            children: timeProgress.map((e) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 20),
                                                        height: 15,
                                                        width: 15,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              Colors
                                                                  .purple[100]!,
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  209,
                                                                  159,
                                                                  218),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        e,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1,
                                                      ),
                                                    ],
                                                  ),
                                                  if (litersProgress[e] != null)
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 6,
                                                                  top: 1),
                                                          child: DottedLine(
                                                            lineThickness: 1.5,
                                                            lineLength: 50,
                                                            direction:
                                                                Axis.vertical,
                                                            dashLength: 4.5,
                                                            dashGradient: [
                                                              Colors
                                                                  .purple[100]!,
                                                              const Color
                                                                  .fromARGB(
                                                                255,
                                                                209,
                                                                159,
                                                                218,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 30),
                                                        GradientText(
                                                          '${litersProgress[e]}',
                                                          gradient: AppColors
                                                              .colorGradient,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(0.5, 0.5),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sleep',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                      ),
                                      const SizedBox(height: 7),
                                      GradientText(
                                        '5h 10m',
                                        gradient: AppColors.colorGradient1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadHeight_weight extends StatelessWidget {
  const LoadHeight_weight({
    Key? key,
    required double widthDevice,
    required this.imgePath,
    required this.fData,
    required this.sData,
    required this.color,
    required this.press,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final String imgePath;
  final double fData;
  final double sData;
  final Color color;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              width: _widthDevice * 0.55,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryColor1.withOpacity(0.2),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _widthDevice * 0.55 * (fData / sData) - 20,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: color,
              ),
            ),
            InkWell(
              onTap: press,
              child: _Badge(
                imgePath,
                size: 25,
                borderColor: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(
          svgAsset,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
