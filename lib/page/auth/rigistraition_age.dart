import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final actives = [
    false,
    false,
    false,
    false,
    false,
  ];
  final clears = [
    false,
    false,
    false,
    false,
    false,
  ];
  final number = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "0"];
  String code = '';
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Container(
              height: 100,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (var i = 0; i < actives.length; i++)
                  AnymationBox(
                    clear: clears[i],
                    active: actives[i],
                  )
              ]),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 0.7 / 0.6),
            itemBuilder: (context, index) => index == 9
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.all(4),
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (currentIndex == 5) currentIndex++;
                          index == 11 ? code = code.substring(0, code.length - 1) :
                          index == 10
                              ? code += number[index - 1]
                              : code += number[index];
                          actives[code.length - 1] = !actives[code.length - 1];
                          //if (code.length == 5) code = '';
                          print(code);
                        });
                      },
                      color: index == 11 ? Colors.white : Colors.grey,
                      child: index == 11
                          ? SizedBox(
                              child: Icon(Icons.backspace, size: 60),
                            )
                          : Center(
                              child: Text(number[index],
                                  style: TextStyle(fontSize: 30))),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    )),
            itemCount: 12,
          ),
        ),
      ],
    ));
  }
}

class AnymationBox extends StatefulWidget {
  final clear;
  final active;
  const AnymationBox({super.key, this.clear = false, this.active = false});

  @override
  State<AnymationBox> createState() => _AnymationBoxState();
}

class _AnymationBoxState extends State<AnymationBox>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clear) {
      animationController.forward(from: 0);
    }
    return AnimatedBuilder(
      animation: animationController,
      builder: ((context, child) => Container(
            margin: const EdgeInsets.all(8),
            child: Stack(children: [
              Container(),
              AnimatedContainer(
                duration: Duration(milliseconds: 600),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.active ? Colors.grey : Colors.black),
              )
            ]),
          )),
    );
  }
}
