import 'package:flutter/material.dart';
import '../widgets/widgets.dart';  // Import your custom widgets here

class SetInstructionsScaffold extends StatefulWidget {
  final String medication;

  const SetInstructionsScaffold({Key? key, required this.medication}) : super(key: key);

  @override
  _SetInstructionsScaffoldState createState() => _SetInstructionsScaffoldState();
}

class _SetInstructionsScaffoldState extends State<SetInstructionsScaffold> {
  bool intervalEnabled = false;
  bool timesPerDayEnabled = false;
  bool daysOfWeekEnabled = false;
  bool mealTimingEnabled = false;
  bool quantityEnabled = false;
  bool turnOffEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medication),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildToggleField(
                'Interval',
                enabled: intervalEnabled,
                onChanged: (value) {
                  setState(() => intervalEnabled = value);
                },
                child: intervalEnabled
                    ? Row(
                        children: [
                          DropdownButton<int>(
                            value: 6, // Default value
                            items: List.generate(12, (index) => DropdownMenuItem(
                              value: index + 1,
                              child: Text('${index + 1} hours'),
                            )),
                            onChanged: (value) {},
                          ),
                        ],
                      )
                    : null,
              ),
              buildToggleField(
                'Times per Day',
                enabled: timesPerDayEnabled,
                onChanged: (value) {
                  setState(() => timesPerDayEnabled = value);
                },
                child: timesPerDayEnabled
                    ? Row(
                        children: [
                          DropdownButton<int>(
                            value: 3, // Default value
                            items: List.generate(10, (index) => DropdownMenuItem(
                              value: index + 1,
                              child: Text('${index + 1} times'),
                            )),
                            onChanged: (value) {},
                          ),
                        ],
                      )
                    : null,
              ),
              buildToggleField(
                'Specified Days of the Week',
                enabled: daysOfWeekEnabled,
                onChanged: (value) {
                  setState(() => daysOfWeekEnabled = value);
                },
                child: daysOfWeekEnabled
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(7, (index) {
                          return Checkbox(
                            value: false,
                            onChanged: (value) {},
                          );
                        }),
                      )
                    : null,
              ),
              buildToggleField(
                'Select Meal Timing',
                enabled: mealTimingEnabled,
                onChanged: (value) {
                  setState(() => mealTimingEnabled = value);
                },
                child: mealTimingEnabled
                    ? Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('Before Meal'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                              ),
                              child: const Text('After Meal'),
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
              buildToggleField(
                'Quantity',
                enabled: quantityEnabled,
                onChanged: (value) {
                  setState(() => quantityEnabled = value);
                },
                child: quantityEnabled
                    ? Row(
                        children: [
                          DropdownButton<int>(
                            value: 2, // Default value
                            items: List.generate(10, (index) => DropdownMenuItem(
                              value: index + 1,
                              child: Text('${index + 1} pills'),
                            )),
                            onChanged: (value) {},
                          ),
                        ],
                      )
                    : null,
              ),
              buildToggleField(
                'Turn off after',
                enabled: turnOffEnabled,
                onChanged: (value) {
                  setState(() => turnOffEnabled = value);
                },
                child: turnOffEnabled
                    ? Row(
                        children: [
                          DropdownButton<int>(
                            value: 2, // Default value
                            items: List.generate(10, (index) => DropdownMenuItem(
                              value: index + 1,
                              child: Text('${index + 1} weeks'),
                            )),
                            onChanged: (value) {},
                          ),
                        ],
                      )
                    : null,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Additional Instructions',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
