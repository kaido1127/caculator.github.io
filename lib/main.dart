import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
//--no-sound-null-safety
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caculator App',
      theme: ThemeData(primaryColor: Colors.black),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String input="0";
  String output="0";
  String cal="";
  double inputSize=38;
  double outputSize=48;

  buttonPress(String buttonText)
  {
      if(buttonText=='C') {
        output="0";
        input="0";
      }
      else if(buttonText=="⌫"){
        output="0";
        if(input.length==1) input="0";
        else input=input.substring(0,input.length-1);
      }
      else if(buttonText=="="){
        cal=input;
        cal=cal.replaceAll("÷", "/");
        cal=cal.replaceAll("×", "*");
        try{
          Parser p = Parser();
          Expression exp = p.parse(cal);

          ContextModel cm = ContextModel();
          output = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          output = "Error";
        }
      }
      else {
        if(input=="0") input=buttonText;
        else input+=buttonText;
      }
  }
  Widget buildButton(String buttonText,double buttonHeight,Color textColor)
  {
    return Container(
        height: MediaQuery.of(context).size.height*0.1*buttonHeight,
        child:TextButton(
            onPressed: (){
              setState(() {
                buttonPress(buttonText);
              });
            },
            child: Text(buttonText,style: TextStyle(color: textColor,fontSize: 40,fontWeight: FontWeight.normal),)
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Color(0xFF1b1e44),
      backgroundColor:Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black ,
        leading: Icon(Icons.calculate_outlined,size: 30,color: Colors.orange,),
        title: Text('Caculator',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.orange),),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              alignment: Alignment.centerRight,
              child: Text(input, style: TextStyle(fontSize: inputSize,color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              alignment: Alignment.centerRight,
              child: Text(output, style: TextStyle(fontSize: outputSize,color: Colors.white),
              ),
            ),
            Expanded(child: Divider()),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton('C', 1, Colors.orange),
                          buildButton('⌫', 1, Colors.orange),
                          buildButton('÷', 1, Colors.orange),
                        ]
                      ),
                      TableRow(
                          children: [
                            buildButton('7', 1, Colors.white),
                            buildButton('8', 1, Colors.white),
                            buildButton('9', 1, Colors.white),
                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton('4', 1, Colors.white),
                            buildButton('5', 1, Colors.white),
                            buildButton('6', 1, Colors.white),
                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton('1', 1, Colors.white),
                            buildButton('2', 1, Colors.white),
                            buildButton('3', 1, Colors.white),
                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton('.', 1, Colors.white),
                            buildButton('0', 1, Colors.white),
                            buildButton('00', 1, Colors.white),
                          ]
                      ),
                    ],
                  ),
                ),Container(
                  width: MediaQuery.of(context).size.width*0.25,
                  child: Table(
                    children: [
                      TableRow(children: [buildButton('×', 1, Colors.orange),]),
                      TableRow(children: [buildButton('-', 1, Colors.orange),]),
                      TableRow(children: [buildButton('+', 1, Colors.orange),]),
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          color: Colors.orange,
                            child:buildButton('=', 2, Colors.white),
                        )
                        ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
