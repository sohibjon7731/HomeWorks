import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DraggableList(),
    );
  }
}

class DraggableList extends StatefulWidget {
  const DraggableList({
    super.key,
  });

  @override
  State<DraggableList> createState() => _DraggableListState();
}

class _DraggableListState extends State<DraggableList> {
  var list = [Colors.red, Colors.blue, Colors.green];
  var hasListItemAccepted = [false, false, false];

  var activeIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Gap(50),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return LongPressDraggable<Color>(
                  data: list[index],
                  feedback: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(color: list[index]),
                  ),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(color: list[index]),
                  ),
                );
              },
              separatorBuilder: (_, __) => const Gap(12),
              itemCount: list.length,
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return DragTarget<Color>(
                  onAccept: (color) {
                    if (color == list[index]) {
                      setState(() {
                        print("Came here");
                        print(hasListItemAccepted[index]);
                        if (hasListItemAccepted[index]) {
                          hasListItemAccepted[index] = false;
                        } else {
                          hasListItemAccepted[index] = true;
                        }
                        activeIndex = -1;
                        print(hasListItemAccepted[index]);
                      });
                    }
                  },
                  onMove: (details) {
                    activeIndex = index;
                    setState(() {});
                  },
                  onAcceptWithDetails: (details) {
                    print("${details.offset}");
                  },
                  onLeave: (details) {
                    print("Working");
                    activeIndex = -1;
                    setState(() {});
                  },
                  builder: (_, candidateItems, rejectedItems) => Container(
                    width: 200,
                    height: 200,
                    color: activeIndex == index
                        ? list[index].withOpacity(.5)
                        : hasListItemAccepted[index]
                            ? list[index]
                            : Colors.white,
                    child: Center(
                      child: Text(getColorName(list[index])),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) {
                return const Gap(12);
              },
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }

  String getColorName(Color color) {
    switch (color) {
      case Colors.red:
        return "Qizil";
      case Colors.blue:
        return "Ko'k";
      case Colors.green:
        return "Yashil";
      default:
    }

    return '';
  }
}