import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toshiconversormoeda/components/text_variation.dart';

import 'components/build_text_field.dart';
import 'components/empty_card.dart';

const request = "https://api.hgbrasil.com/finance?format=json&key=d612ccc4";

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(hintColor: Colors.green, primaryColor: Colors.green),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolarAtual;
  double dolarVariation;
  double euroAtual;
  double euroVariation;
  double ibovespa;
  double nasdaq;

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    } else if (text.isNotEmpty) {
      double real = double.parse(text);
      dolarController.text = (real / dolarAtual).toStringAsFixed(2);
      euroController.text = (real / euroAtual).toStringAsFixed(2);
      print(text);
    }
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    } else if (text.isNotEmpty) {
      double dolar = double.parse(text);
      realController.text = (dolar * this.dolarAtual).toStringAsFixed(2);
      euroController.text =
          (dolar * this.dolarAtual / euroAtual).toStringAsFixed(2);
    }
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    } else if (text.isNotEmpty) {
      double euro = double.parse(text);
      realController.text = (euro * euroAtual).toStringAsFixed(2);
      dolarController.text =
          (euro * this.euroAtual / dolarAtual).toStringAsFixed(2);
    }
  }

  void _clearAll() {
    realController.clear();
    dolarController.clear();
    euroController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\$ Toshi Conversor \$"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return EmptyCard("Carregando dados...");
            default:
              if (snapshot.hasError) {
                return EmptyCard("Erro ao carregar dados...");
              } else {
                dolarAtual =
                    snapshot.data["results"]["currencies"]["USD"]["buy"];
                euroAtual =
                    snapshot.data["results"]["currencies"]["EUR"]["buy"];
                dolarVariation =
                    snapshot.data["results"]["currencies"]["USD"]["variation"];
                euroVariation =
                    snapshot.data["results"]["currencies"]["EUR"]["variation"];
                ibovespa =
                    snapshot.data["results"]["stocks"]["IBOVESPA"]["variation"];
                nasdaq =
                    snapshot.data["results"]["stocks"]["NASDAQ"]["variation"];

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.monetization_on_rounded,
                          size: 150.00,
                          color: Colors.green[800],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                        ),
                        Text(
                          "Digite o valor a ser convertido:",
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BuildTextField(
                                label: "Reais",
                                prefix: "\$ ",
                                textEditingController: realController,
                                function: _realChanged,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BuildTextField(
                                label: "Dólar",
                                prefix: "US\$ ",
                                textEditingController: dolarController,
                                function: _euroChanged,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextVariation(valueVariation: dolarVariation),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BuildTextField(
                                label: "Euros",
                                prefix: "€ ",
                                textEditingController: euroController,
                                function: _euroChanged,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextVariation(valueVariation: euroVariation),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                        ),
                        Text(
                          "Cotação da bolsa de valores",
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.all(16),
                                color: Colors.grey[200],
                                child: Text(
                                  "IBOVESPA",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextVariation(valueVariation: ibovespa),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.all(16),
                                color: Colors.grey[200],
                                child: Text(
                                  "NASDAQ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextVariation(valueVariation: nasdaq),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
