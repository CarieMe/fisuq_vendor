import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../Helper/Constant.dart';
import 'Indicator.dart';
import '../../../../Provider/home_provider.dart';
import '../../../../Widget/validation.dart';
import '../../home.dart';

catChart(
  HomeProvider val,
  BuildContext context,
  Function setState,
) {
  Size size = MediaQuery.of(context).size;
  double width = size.width > size.height ? size.height : size.width;
  double ratio;
  if (width > 600) {
    ratio = 0.5;
    // Do something for tablets here
  } else {
    ratio = 0.8;
    // Do something for phones
  }
  return AspectRatio(
    aspectRatio: 1.23,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
      child: NeuContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: TextBL(
                getTranslated(context, "CatWiseCount")!,
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: AspectRatio(
                      aspectRatio: .8,
                      child: Stack(
                        children: [
                          PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback: (fl, pieTouchResponse) async {
                                  Future.delayed(Duration.zero).then(
                                    (_) async {
                                      final desiredTouch =
                                          pieTouchResponse!.touchedSection
                                                  is! PointerExitEvent &&
                                              pieTouchResponse.touchedSection
                                                  is! PointerUpEvent;
                                      if (desiredTouch &&
                                          pieTouchResponse.touchedSection !=
                                              null) {
                                        touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      } else {
                                        touchedIndex = -1;
                                      }
                                      setState();
                                    },
                                  );
                                },
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              startDegreeOffset: 180,
                              centerSpaceRadius: 40,
                              sections: showingSections(val),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shrinkWrap: true,
                      itemCount: colorList.length,
                      itemBuilder: (context, i) {
                        return Indicators(
                          color: colorList[i],
                          text: val.catList![i] + " " + val.catCountList![i],
                          textColor: touchedIndex == i
                              ? AppColor.primary
                              : Theme.of(context).indicatorColor,
                          isSquare: true,
                          size: 20,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

List<PieChartSectionData> showingSections(HomeProvider val) {
  return List.generate(
    val.catCountList!.length,
    (i) {
      final isTouched = i == touchedIndex;

      final double fontSize = isTouched ? textFontSize25 : textFontSize16;
      final double radius = isTouched ? 60 : 50;

      return PieChartSectionData(
        color: colorList[i],
        value: double.parse(
          val.catCountList![i].toString(),
        ),
        title: "",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          color: const Color(0xffffffff),
        ),
      );
    },
  );
}
