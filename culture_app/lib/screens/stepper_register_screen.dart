import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StepperRegisterScreen extends StatefulWidget {
  @override
  _StepperRegisterScreenState createState() => _StepperRegisterScreenState();
}

class _StepperRegisterScreenState extends State<StepperRegisterScreen> {
  List<Step> steps = [
    Step(
        title: const Text('Conta'),
      isActive: true,
      state: StepState.editing,
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      state: StepState.editing,
      title: const Text('Address'),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Home Address'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Postcode'),
          ),
        ],
      ),
    ),
    Step(
      state: StepState.error,
      title: const Text('Avatar'),
      subtitle: const Text("Error!"),
      content: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red,
          )
        ],
      ),
    ),
  ];

  int currentStep = 0;
  bool complete = false;

  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Create an account'),
        ),
        body: Column(
          children: <Widget>[
            complete ? Expanded(
              child: Center(
                child: AlertDialog(
                  title: new Text("Profile Created"),
                  content: new Text(
                    "Tada!",
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        setState(() => complete = false);
                      },
                    ),
                  ],
                ),
              ),
            )
                : Expanded(
              child: Stepper(
                type: StepperType.horizontal,
                steps: steps,
                currentStep: currentStep,
                onStepContinue: next,
                onStepTapped: (step) => goTo(step),
                onStepCancel: cancel,
              ),
            ),
          ],
        ),);
  }
}
