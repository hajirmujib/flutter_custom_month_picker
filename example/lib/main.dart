import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int month = 3, year = 2024;
  final MonthYearController controller = MonthYearController.of();

  void resetDate() {
    setState(() {
      month = 3;
      year = 2024;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Month Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  resetDate();
                  controller.setMonth(3);
                  controller.setYear(2024);
                },
                child: const Text("Reset Date")),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              child: CustomMonthPicker(
                controller: controller,
                initialSelectedMonth: month,
                initialSelectedYear: year,
                highlightColor: const Color(0xFF1FA0C9),
                onSelected: (month, year) {
                  if (kDebugMode) {
                    print('Selected month: $month, year: $year');
                  }
                  setState(() {
                    this.month = month;
                    this.year = year;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  showMonthPicker(context, onSelected: (month, year) {
                    if (kDebugMode) {
                      print('Selected month: $month, year: $year');
                    }
                    setState(() {
                      this.month = month;
                      this.year = year;
                    });
                  },
                      initialSelectedMonth: month,
                      initialSelectedYear: year,
                      firstEnabledMonth: 3,
                      lastEnabledMonth: 10,
                      firstYear: 2000,
                      lastYear: 2025,
                      selectButtonText: 'OK',
                      cancelButtonText: 'Cancel',
                      highlightColor: Colors.purple,
                      textColor: Colors.black,
                      contentBackgroundColor: Colors.white,
                      dialogBackgroundColor: Colors.grey[200]);
                },
                child: const Text('Show Month Picker')),
            Text('Selected month: $month, year: $year')
          ],
        ),
      ),
    );
  }
}
