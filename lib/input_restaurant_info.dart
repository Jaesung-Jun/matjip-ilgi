import 'package:flutter/material.dart';

class InputRestaurantInformationPage extends StatelessWidget {
  const InputRestaurantInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child : Column(
          children: <Widget>[
            OutlinedButton(
              onPressed: () => {Navigator.pop(context)},
              child: Text("버튼 테스트"),
            ),
          ],
        ),
      )
    );
  }
}
