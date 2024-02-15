import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import '../models/tnc_model.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  final List<TnCModel> _tNCModelsList = [
    TnCModel(
      id: 11989,
      value: "1 Year Service Warranty & 5 Years Plywood Warranty",
      createdAt: "2024-01-06 12:08:11",
      updatedAt: "2024-01-06 12:08:11",
    ),
    TnCModel(
      id: 11990,
      value: "Customer Should inform about the Changes (if any Design & colour) before\nproduction or else Customer should pay Extra",
      createdAt: "2024-01-06 12:08:11",
      updatedAt: "2024-01-06 12:08:11",
    ),
    TnCModel(
      id: 11991,
      value: "Material will be delivered 3-4 weeks the date of Confirmation of Order",
      createdAt: "2024-01-06 12:08:11",
      updatedAt: "2024-01-06 12:08:11",
    ),
    TnCModel(
      id: 11992,
      value: "Quotation cant be changed / revised once accepted by the customer",
      createdAt: "2024-01-06 12:08:11",
      updatedAt: "2024-01-06 12:08:11",
    ),
    TnCModel(
      id: 11993,
      value: "If any extra works are needed then it should be paid by customer",
      createdAt: "2024-01-06 12:08:11",
      updatedAt: "2024-01-06 12:08:11",
    ),
    TnCModel(
      id: 11994,
      value: "Custom Handles will be charged extra.Handle price may vary based of designs &\nspecifications",
      createdAt: "2024-01-06 12:08:11",
      updatedAt: "2024-01-06 12:08:11",
    ),
    TnCModel(
      id: 11995,
      value: "Once the Project is confirmed, the amount cannot be refunded",
      createdAt: "2024-01-06 12:08:11",
      updatedAt: "2024-01-06 12:08:11",
    ),
    TnCModel(
      id: 11996,
      value: "This Quote will be valid only for 15 Days",
      createdAt: "2024-01-06 12:08:11",
      updatedAt: "2024-01-06 12:08:11",
    ),
    TnCModel(
      id: 11997,
      value: "Any additional work which is out of the quotation in any aspects is to be paid extra by\nthe customer",
      createdAt: "2024-01-06 12:08:11",
      updatedAt: "2024-01-06 12:08:11",
    ),
  ];

  static const TranslateLanguage sourceLanguage = TranslateLanguage.english;
  static const TranslateLanguage targetLanguage = TranslateLanguage.hindi;
  late final OnDeviceTranslator onDeviceTranslator;

  @override
  void initState() {
    super.initState();
    onDeviceTranslator = OnDeviceTranslator(sourceLanguage: sourceLanguage, targetLanguage: targetLanguage);
  }

  @override
  void dispose() {
    onDeviceTranslator.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
        scrolledUnderElevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: _tNCModelsList.length + 1,
        itemBuilder: (context, index) {
          if (index == _tNCModelsList.length) {
            return TextButton(
              onPressed: () {
                //todo
              },
              child: const Text("Add More"),
            );
          }
          return _TnCCard(
            tnCModel: _tNCModelsList[index],
            onDeviceTranslator: onDeviceTranslator,
          );
        },
      ),
    );
  }
}

class _TnCCard extends StatefulWidget {
  const _TnCCard({required this.tnCModel, required this.onDeviceTranslator});

  final TnCModel tnCModel;
  final OnDeviceTranslator onDeviceTranslator;

  @override
  State<_TnCCard> createState() => _TnCCardState();
}

class _TnCCardState extends State<_TnCCard> {
  String? hindiText;
  bool _translating = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            offset: const Offset(1, 1),
            blurRadius: 8,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            widget.tnCModel.value,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          if (_translating) const CircularProgressIndicator(),
          if (hindiText != null)
            Text(
              hindiText!,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  setState(() {
                    _translating = true;
                  });
                  hindiText = await widget.onDeviceTranslator.translateText(widget.tnCModel.value);
                  setState(() {
                    _translating = false;
                  });
                },
                child: const Text(
                  "Read in Hindi",
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
