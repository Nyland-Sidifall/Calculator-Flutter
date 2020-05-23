import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Simple Calculator'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String displayStr = '0';
  String numStr = "0";
  double result = 0;
  String operation;
  bool shouldCalc = false;


  Widget createButton(String title){
    return Expanded(
      child: ButtonTheme(
        height: double.infinity,
        child: OutlineButton(
          onPressed: () => {pressButton(title)},
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          highlightedBorderColor: Colors.black,
        ),
      ),
    );
  }

  Widget createRow(String title1,String title2,String title3,String title4){
    return Expanded(
      child: Row(
        children: <Widget>[
          createButton(title1),
          createButton(title2),
          createButton(title3),
          createButton(title4),
        ],
      ),
    );
  }

  pressButton(String title){
    setState(() {
      if(title == '+'||title == '-'||title == '*'||title == '/'){
        if(shouldCalc){
          calc();
        }else{
          result = double.parse(numStr) ?? 0;
          shouldCalc = true;
        }
        numStr = '';
        operation = title;
      }else if(title == '='){
        calc();
        shouldCalc = false;
      }else if(title == 'CE'){
        numStr = '';
        displayStr = '0';
        result = 0;
        shouldCalc = false;
      }else{
        if(numStr == '0' || numStr == "0.0"){
          numStr = '';
        }
        numStr += title;
        displayStr = numStr;
      }
    });
  }

  calc(){
    switch(operation){
      case "+":
        result = result += double.parse(numStr);
        break;
      case "-":
        result = result -= double.parse(numStr);
        break;
      case "*":
        result = result *= double.parse(numStr);
        break;
      case "/":
        result = result /= double.parse(numStr);
        break;
    }
    numStr = result.toString();
    displayStr = numStr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Color.fromARGB(10,0,0,0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Text(
                      displayStr,
                      style: TextStyle(
                        fontSize: 80,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  createRow("+","-","*","/"),
                  createRow("7","8","9","0"),
                  createRow("4","5","6","CE"),
                  createRow("1","2","3","="),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
