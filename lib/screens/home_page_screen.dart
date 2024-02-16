import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import '../models/tnc_model.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;

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
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _BottomSheet(
                      addCard: (tncModel) {
                        _tNCModelsList.add(tncModel);
                        setState(() {});
                      },
                    );
                  },
                );
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

class _BottomSheet extends StatefulWidget {
  const _BottomSheet({required this.addCard});

  final Function(TnCModel) addCard;

  @override
  State<_BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<_BottomSheet> {
  final TextEditingController _controller = TextEditingController();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _speechEnabled = false;
  bool _recording = false;

  @override
  void initState() {
    super.initState();
  }

  _startSpeechToText() async {
    if (!_speechEnabled) {
      _speechEnabled = await _speechToText.initialize(
        onError: (speechRecognitionError) {
          debugPrint(speechRecognitionError.toJson().toString());
        },
        debugLogging: true,
      );
      debugPrint(_speechEnabled.toString());
      setState(() {});
    }
    if (_speechEnabled) {
      debugPrint("Started listening");
      _speechToText.listen(
        onResult: (result) {
          _stopSpeechToText();
          setState(() {
            _controller.text += result.recognizedWords;
          });
          debugPrint("Controller text: ${_controller.text}");
        },
        listenOptions: stt.SpeechListenOptions(
          autoPunctuation: true,
          partialResults: false,
        ),
      );
    } else {
      debugPrint("The user has denied the use of speech recognition.");
    }
  }

  @override
  void dispose() {
    _speechToText.cancel();
    super.dispose();
  }

  _stopSpeechToText() {
    _speechToText.stop();
    setState(() {
      _recording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var border = const OutlineInputBorder();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            "Add new TnC",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              hintText: "Enter tnc",
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _recording = !_recording;
                  });
                  if (_recording) {
                    _startSpeechToText();
                  } else {
                    _stopSpeechToText();
                  }
                },
                child: _recording
                    ? const Icon(
                        Icons.stop,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.mic,
                        color: Colors.black,
                      ),
              ),
            ),
          ),
          Text(
            _recording ? "Listening" : "",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {
                widget.addCard(TnCModel(
                  id: DateTime.now().millisecondsSinceEpoch,
                  value: _controller.text,
                  createdAt: DateTime.now().toIso8601String(),
                  updatedAt: DateTime.now().toIso8601String(),
                ));
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}
