import 'package:calculator/Screens/refactors/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '0';
  List<String> buttons = [
    'C',
    'DEL',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'ANS',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 107, 107, 107)),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: ((context, index) {
                        //C button (clear)
                        if (index == 0) {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion = '';
                                  userAnswer = '0';
                                });
                              },
                              buttonText: buttons[index],
                              color: const Color(0xFFBDBDBD),
                              textColor: Colors.black);
                        } //equal button
                        else if (index == buttons.length - 1) {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  equalPressed();
                                });
                              },
                              buttonText: buttons[index],
                              color: const Color(0xFFBDBDBD),
                              textColor: Colors.black);
                        }//delete button 
                         else if (index == 1) {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1); 
                                });
                              },
                              buttonText: buttons[index],
                              color: const Color(0xFFBDBDBD),
                              textColor: Colors.black);
                        } else {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index])
                                ? const Color(0xFFFE9D12)
                                : const Color(0xFF424242),
                            textColor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.white,
                          );
                        }
                      }))),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '÷' ||
        x == 'x' ||
        x == '-' ||
        x == '%' ||
        x == '=' ||
        x == '+') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    finalQuestion = finalQuestion.replaceAll('÷', '/');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
