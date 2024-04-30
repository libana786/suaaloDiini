import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool _areButtonsDisabled = false;

  // ... other code

  void disableButtons() {
    setState(() {
      _areButtonsDisabled = true;
    });
  }

  // ... other methods (like enabling buttons)

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
            children: [
              TextButton(
                onPressed: () {
                  // Handle button 1 press
                },
                child: Text('Button 1'),
              ),
              SizedBox(height: 10), // Add spacing between buttons (optional)
              TextButton(
                onPressed: () {
                  // Handle button 2 press
                },
                child: Text('Button 2'),
              ),
              SizedBox(height: 10), // Add spacing between buttons (optional)
              TextButton(
                onPressed: () {
                  // Handle button 3 press
                },
                child: Text('Button 3'),
              ),
            ],
          ),
          Visibility(
            visible: _areButtonsDisabled,
            child: Container(
              color: Colors.black.withOpacity(0.3), // Semi-transparent black
              child: Material(
                child: InkWell(
                  // Consumes taps
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
