import 'dart:async';

import 'package:example_of_covid_19_news_app/model/report.dart';
import 'package:example_of_covid_19_news_app/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final APIService _apiService = APIService();
  final List<CartsData> _data = [];
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  final TextEditingController _inputDateController =
      TextEditingController(text: '2021-01-01');
  DateTime _selectedDate = DateTime.now();

  final List<InitialState> _listInitialState = [
    InitialState(initial: 'AK', description: 'Alaska')
  ];

  void _getListReportProcess() {
    _apiService.getListReport(_inputDateController.text).then((value) {
      if (value.dataProvider != null) {
        // ignore: avoid_print
        print(reportToJson(value));
        for (var item in value.dataProvider!) {
          _data.add(
              CartsData(state: item.usStatePostal!, tested: item.cntTested!));
        }
        Timer(Duration.zero, () {
          _isLoading.value = false;
        });
      } else {
        _data.clear();
        // ignore: avoid_print
        print(reportToJson(value));
      }
    });
  }

  void _reGetListReportProcess(String param) {
    _isLoading.value = true;
    _apiService.getListReport(param).then((value) {
      if (value.dataProvider != null) {
        // ignore: avoid_print
        print(reportToJson(value));
        for (var item in value.dataProvider!) {
          _data.add(
              CartsData(state: item.usStatePostal!, tested: item.cntTested!));
        }
        Timer(Duration.zero, () {
          _isLoading.value = false;
        });
      } else {
        // ignore: avoid_print
        print(reportToJson(value));
        _data.clear();
      }
    });
  }

  _showSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2019),
        lastDate: DateTime.now());

    if (picked != null) {
      final DateFormat formatterForInput = DateFormat('yyyy-MM-dd');
      final DateFormat formatterForInputText = DateFormat('dd-MM-yyyy');
      final String formattedInput = formatterForInput.format(picked);
      final String formattedInputText = formatterForInputText.format(picked);

      _inputDateController.text = formattedInputText;

      Timer(Duration.zero, () {
        _reGetListReportProcess(formattedInput);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getListReportProcess();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<CartsData, String>> series = [
      charts.Series(
        id: "state",
        data: _data,
        domainFn: (CartsData series, _) => series.state,
        measureFn: (CartsData series, _) => series.tested,
      )
    ];
    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, bool value, _) {
          if (value) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          } else {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[300],
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          height: double.infinity,
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ElevatedButton.icon(
                            label: const Text(''),
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () {
                              _showSelectDate(context);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          controller: _inputDateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Tanggal',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1))),
                        ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            charts.BarChart(
                              series,
                              animate: true,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25,
                                              left: 25,
                                              bottom: 70,
                                              top: 70),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            color: Colors.white,
                                            alignment: Alignment.topCenter,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        margin:
                                                            const EdgeInsets.only(
                                                                right: 5),
                                                        color: Colors.blue,
                                                        child: const Icon(
                                                          Icons.close,
                                                          size: 20,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Flexible(
                                                        child: Container(
                                                            color: Colors
                                                                .transparent,
                                                            child: const Text(
                                                              'Information About Initials Postal Code',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline),
                                                            ))),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Expanded(
                                                      child: ListView.builder(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          itemCount:
                                                              _listInitialState
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Row(
                                                              children: [
                                                                Flexible(
                                                                    child: Container(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child: Text(
                                                                            _listInitialState[index].initial))),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Flexible(
                                                                    child: Container(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child: const Text(
                                                                            ':'))),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Flexible(
                                                                    child: Container(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child: Text(
                                                                            _listInitialState[index].description))),
                                                              ],
                                                            );
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    margin: const EdgeInsets.only(right: 5),
                                    color: Colors.blue,
                                    child: const Icon(
                                      Icons.info,
                                      size: 20,
                                      color: Colors.white,
                                    )),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            );
          }
        });
  }
}

class CartsData {
  final String state;
  final int tested;

  CartsData({
    required this.state,
    required this.tested,
  });
}

class InitialState {
  final String initial;
  final String description;

  InitialState({
    required this.initial,
    required this.description,
  });
}
