import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

import 'model/imc.dart';
import 'repository/imc_history.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          background: const Color(0xFFF5F5F9),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Cálculo IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentValue = 170;
  var imcRepository = IMCRepository();
  List<IMC> imcHistory = [];

  @override
  void initState() {
    super.initState();
    imcHistory = imcRepository.imcHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFFF5F5F9),
        title: Container(
          margin: const EdgeInsets.only(top: 40),
          child: Text(
            widget.title,
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        titleSpacing: 40,
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Text(
                    'Altura (cm)',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                NumberPicker(
                  selectedTextStyle: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                  textStyle: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFc4c4c4),
                  ),
                  itemCount: imcHistory.length,
                  itemWidth: MediaQuery.of(context).size.width / 5,
                  value: _currentValue,
                  minValue: 0,
                  maxValue: 250,
                  itemHeight: 50,
                  axis: Axis.horizontal,
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, right: 20, left: 20),
                  height: 60,
                  child: TextField(
                    cursorColor: const Color(0xFF777777),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFDDDDDD),
                      labelText: 'Peso em quilogramas',
                      labelStyle: GoogleFonts.montserrat(
                        color: const Color(0xFF555555),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: _buildItem,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildItem(BuildContext context, int index) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.only(left: index == 4 ? 20 : 0, right: 20),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}
