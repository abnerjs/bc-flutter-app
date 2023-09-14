import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

import 'utils/bmi_rate.dart';
import 'model/imc.dart';
import 'repository/imc_history.dart';
import 'repository/height.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(IMCAdapter());
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
  late HeightRepository heightRepository;
  int _currentValue = 170;
  late IMCRepository imcRepository;
  List<IMC> imcHistory = [];

  var pesoController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    heightRepository = await HeightRepository.init();
    imcRepository = await IMCRepository.init();
    imcHistory = imcRepository.imcHistory;
    _currentValue = heightRepository.height;

    setState(() {});
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
                  itemCount: 5,
                  itemWidth: MediaQuery.of(context).size.width / 5,
                  value: _currentValue,
                  minValue: 0,
                  maxValue: 250,
                  itemHeight: 50,
                  axis: Axis.horizontal,
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                      heightRepository.height = value;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, right: 20, left: 20),
                  height: 50,
                  child: TextFormField(
                    controller: pesoController,
                    keyboardType: TextInputType.datetime,
                    cursorColor: const Color(0xFF777777),
                    decoration: InputDecoration(
                      floatingLabelStyle: GoogleFonts.montserrat(
                        color: const Color(0xFF000000),
                        height: 0.1,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFDDDDDD),
                      labelText: 'Peso em quilogramas',
                      labelStyle: GoogleFonts.montserrat(
                        color: const Color(0xFF555555),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 10, right: 20),
                  child: TextButton(
                    onPressed: () {
                      if (pesoController.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            elevation: 0,
                            content: Text(
                              "Dados inválidos",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.black,
                          ),
                        );
                        return;
                      } else {
                        var imc = IMC(
                          DateTime.now(),
                          _currentValue.toDouble(),
                          double.parse(pesoController.text),
                        );
                        imcRepository.add(imc);
                        pesoController.text = "";
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xFF000000),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    child: Text(
                      "Salvar",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                imcRepository.imcHistory.isEmpty
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 20,
                              left: 20,
                              top: 30,
                            ),
                            child: Text(
                              'Histórico de IMC',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: imcRepository.imcHistory.length,
                              itemBuilder: _buildItem,
                            ),
                          ),
                        ],
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
      color: getBMIType(imcRepository
              .imcHistory[imcRepository.imcHistory.length - 1 - index]
              .imc())
          .color,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      margin: EdgeInsets.only(left: index == 0 ? 20 : 0, right: 20),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(25),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "IMC",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      imcRepository.imcHistory[
                              imcRepository.imcHistory.length - 1 - index]
                          .imc()
                          .toStringAsFixed(1),
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(imcRepository
                      .imcHistory[imcRepository.imcHistory.length - 1 - index]
                      .dataCalculo),
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF777777),
                    fontStyle: FontStyle.italic,
                    height: 1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      imcRepository
                          .imcHistory[
                              imcRepository.imcHistory.length - 1 - index]
                          .altura
                          .toStringAsFixed(0),
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8, left: 4),
                      child: Text(
                        "cm",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      imcRepository
                          .imcHistory[
                              imcRepository.imcHistory.length - 1 - index]
                          .peso
                          .toStringAsFixed(0),
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8, left: 4),
                      child: Text(
                        "kg",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
