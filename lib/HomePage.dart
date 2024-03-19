import 'package:flutter/material.dart';

void main() {
  runApp(BloodPressureApp());
}

class BloodPressureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      title: 'Blood Pressure Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BloodPressureScreen(),
    );
  }
}

class BloodPressureScreen extends StatefulWidget {
  @override
  _BloodPressureScreenState createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  TextEditingController systolicController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();

  void calculateBloodPressure(BuildContext context) {
    int S = int.tryParse(systolicController.text) ?? 0;
    int D = int.tryParse(diastolicController.text) ?? 0;
    String result;

    if (S > 180) {
      if (D > 120) {
        result = 'Invalid SYSTOLIC Blood Pressure and DIASTOLIC Blood Pressure.  \n Check Again. ';
      } else {
        result = 'Invalid SYSTOLIC Blood Pressure  \n Check Again. ';
      }
    } else {
      if (D > 120) {
        result = 'Invalid DIASTOLIC Blood Pressure  \n Check Again. ';
      } else {
        if (S >= 160) {
          if (D >= 100 && D <= 120) {
            result = "HIGH: STAGE 2 HYPERTENSION \n Seek medical attention promptly.";
          } else {
            result = "Invalid DIASTOLIC Blood Pressure. \n Check Again. ";
          }
        } else {
          if (S >= 140) {
            if (D >= 90 && D <= 100) {
              result = "HIGH: STAGE 1 HYPERTENSION \n Seek medical attention promptly.";
            } else {
              result = "Invalid DIASTOLIC Blood Pressure. \n Check Again. ";
            }
          } else {
            if (S >= 120) {
              if (D >= 80 && D <= 90) {
                result = "PRE HYPERTENSION  \n  Adopt healthy habits, consult healthcare provider regularly.";
              } else {
                result = "Invalid DIASTOLIC Blood Pressure. \n Check Again. ";
              }
            } else {
              if (S >= 90) {
                if (D >= 60 && D <= 80) {
                  result = "NORMAL Blood pressure. \n  Continue healthy habits, monitor periodically, consult doctor if necessary.";
                } else {
                  result = "Invalid DIASTOLIC Blood Pressure. \n Check Again. ";
                }
              } else {
                if (S >= 40) {
                  if (D >= 40 && D <= 60) {
                    result = "LOW Blood Pressure.  \n  Increase fluid intake, consume salt, consult doctor if symptoms persist.";
                  } else {
                    result = "Invalid DIASTOLIC Blood Pressure. \n Check Again. ";
                  }
                } else {
                  if (D >= 40) {
                    result = "Invalid SYSTOLIC Blood Pressure. \n Check Again. ";
                  } else {
                    result = "Invalid SYSTOLIC Blood Pressure and DIASTOLIC Blood Pressure.  \n Check Again. ";
                  }
                }
              }
            }
          }
        }
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          result: result,
          systolic: S,
          diastolic: D,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [Icon(Icons.menu)],
        title: Text('Blood Pressure Monitor',style: TextStyle(
          fontWeight: FontWeight.bold,color: Colors.white
        )),
      ),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: systolicController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              decoration: InputDecoration(
                labelText: 'SYSTOLIC BLOOD PRESSURE (S)',
              ),
            ),
            SizedBox(height: 45),
            TextField(
              controller: diastolicController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              decoration: InputDecoration(
                labelText: 'DIASTOLIC BLOOD PRESSURE (D)',
              ),
            ),
            SizedBox(height: 140),
            ElevatedButton(
              onPressed: () {
                calculateBloodPressure(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.green,
                textStyle: TextStyle(fontSize: 30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('Evaluate',style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String result;
  final int systolic;
  final int diastolic;

  ResultScreen({required this.result, required this.systolic, required this.diastolic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('RESULT',style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold

        )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueAccent
                  ),
                  child: Center(
                    child: Text(
                      'Systolic: $systolic',
                      style: TextStyle(fontSize: 25,color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 500,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueAccent
                  ),
                  child: Center(
                    child: Text(
                      'Diastolic: $diastolic',
                      style: TextStyle(fontSize: 25,
                      color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 500,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'RESULT : \n $result',
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Back'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
