import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
);

class PieChartSample1State extends State {
  int touchedIndex = -1;
  int carb = 55;
  int fat = 30;
  int protein = 15;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.62,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Оценка питания по данным покупок", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
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
                  centerSpaceRadius: 60,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Indicator(
                color: Colors.blue,
                text: 'Углеводы $carb%',
                isSquare: false,
                size: touchedIndex == 0 ? 18 : 16,
                textColor: touchedIndex == 0
                    ? Colors.blueGrey
                    : Colors.blueGrey,
              ),
              Indicator(
                color: Colors.orangeAccent,
                text: 'Жир $fat%',
                isSquare: false,
                size: touchedIndex == 1 ? 18 : 16,
                textColor: touchedIndex == 1
                    ? Colors.blueGrey
                    : Colors.blueGrey,
              ),
              Indicator(
                color: Colors.lightGreen,
                text: 'Белок $protein%',
                isSquare: false,
                size: touchedIndex == 2 ? 18 : 16,
                textColor: touchedIndex == 2
                    ? Colors.blueGrey
                    : Colors.blueGrey,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          TextButton(
            onPressed: () {}, 
            child: Text("БЖУ баланс подробнее", style: TextStyle(color: Colors.lightGreen, fontSize: 17))),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              TextButton.icon(
                onPressed: (){}, 
                label: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Text("350000 каллорий", style: TextStyle(color: Colors.black45, fontSize: 17)),
                    Text("куплено за период 30 дней", style: TextStyle(color: Colors.black, fontSize: 14))
                  ],
                ),
                iconAlignment: IconAlignment.end, 
              ),
              ElevatedButton.icon( 
                label: Icon(Icons.stairs_outlined),
                onPressed: (){},
                )
            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              TextButton.icon(
                onPressed: (){
                  carb = fat;
                }, 
                label: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text("Индекс здорового питаний", style: TextStyle(color: Colors.black45, fontSize: 17)),
                    Text("60%", style: TextStyle(color: Colors.black, fontSize: 14))
                  ],

                ),
                iconAlignment: IconAlignment.end, 
              ),
              ElevatedButton.icon( 
                label: Icon(CupertinoIcons.smiley),
                onPressed: (){},
                )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              TextButton.icon(
                onPressed: (){}, 
                label: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text("Полнота сбора данных: 65%", style: TextStyle(color: Colors.black45, fontSize: 17)),
                    Text("Добавление чеков", style: TextStyle(color: Colors.black, fontSize: 14))
                  ],

                ),
                iconAlignment: IconAlignment.end, 
              ),
              ElevatedButton.icon( 
                label: Icon(Icons.shopping_cart_outlined),
                onPressed: (){},
                )
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.folder_outlined),
            label: Text("Все отчёты"),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      3,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = Colors.lightBlue;
        const color1 = Colors.orangeAccent;
        const color2 = Colors.lightGreen;
        const color_enable = Colors.blueGrey;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: (touchedIndex != i) ? color0 : color_enable,
              value: carb.toDouble(),
              title: '',
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: Colors.white, width: 6)
                  : BorderSide(
                      color: Colors.white),
            );
          case 1:
            return PieChartSectionData(
              color: (touchedIndex != i) ? color1 : color_enable,
              value: fat.toDouble(),
              title: '',
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: Colors.white, width: 6)
                  : BorderSide(
                      color: Colors.white,
                      )
            );
          case 2:
            return PieChartSectionData(
              color: (touchedIndex != i) ? color2 : color_enable,
              value: protein.toDouble(),
              title: '',
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? const BorderSide(
                      color: Colors.white, width: 6)
                  : BorderSide(
                      color:Colors.white,
              )
            );

          default:
            throw Error();
        }
      },
    );
  }
}
// Column(
//   children: [
//     Container(margin: EdgeInsets.all(20),
//       child: PieChart(
//         PieChartData(
//           sections: [
//             PieChartSectionData(
//               value: 55,
//               color: Colors.lightBlue,
//               titleStyle: textStyle,
//               title: ""
//             ),
//             PieChartSectionData(
//               value: 30,
//               color: Colors.orangeAccent,
//               titleStyle: textStyle,
//               title: ""
//             ),
//             PieChartSectionData(
//               value: 15,
//               color: Colors.lightGreen,
//               titleStyle: textStyle,
//               title: ""
//             )
//           ],
//           centerSpaceRadius: 80,
//           pieTouchData: PieTouchData(
//           )
//         )
//       ),
//     ),
//   ],
// );