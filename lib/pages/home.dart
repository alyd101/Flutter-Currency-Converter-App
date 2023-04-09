import 'package:currency_converter_app/components/code_dropdown_button.dart';
import 'package:currency_converter_app/components/convert_button.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter_app/providers/currency_converter_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map? currencyData;
  List<String>? codes;
  String? fromCurrency;
  String? toCurrency;
  var dataLoaded = false;

  @override
  void initState() {
    super.initState();
    storeData();
  }

  storeData() async {
    var readContext = context.read<CurrencyConverterProvider>();
    currencyData = await readContext.getCurrencies();
    codes = readContext.getCodes(currencyData!);
    fromCurrency = codes![0];
    toCurrency = codes![1];
    setState(() {
      dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var readContext = context.read<CurrencyConverterProvider>();
    var watchContext = context.watch<CurrencyConverterProvider>();
    var result = watchContext.result;
    TextEditingController amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Currency Converter",
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 30)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
            child: Visibility(
          visible: dataLoaded,
          replacement: const CircularProgressIndicator(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(result == null ? "" : result.toString(),
                    style: const TextStyle(fontSize: 20)),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              const Text(
                "From",
                style: TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 201, 201, 201)),
              ),
              CodeDropDownButton(
                  val: fromCurrency,
                  codes: codes,
                  onChanged: (value) {
                    fromCurrency = value;
                  }),
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 10),
                child: Text(
                  "To",
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 201, 201, 201)),
                ),
              ),
              CodeDropDownButton(
                val: toCurrency,
                codes: codes,
                onChanged: (value) {
                  toCurrency = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: "Amount"),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  maxLines: 1,
                ),
              ),
              ConvertButton(onTap: () {
                if (amountController.text.isNotEmpty) {
                  readContext.fromVal =
                      readContext.getValue(fromCurrency!, currencyData!);
                  readContext.toVal =
                      readContext.getValue(toCurrency!, currencyData!);
                  readContext.convert(double.parse(amountController.text));
                }
              })
            ],
          ),
        )),
      ),
    );
  }
}
