import 'package:flutter/material.dart';
import 'package:ladon/shared/provider/OtpProvider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

//TODO: Check if we can convert it to a stateless widget
class OtpSaveWidget extends StatefulWidget {
  const OtpSaveWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<OtpSaveWidget> createState() => _OtpSaveWidgetState();
}

class _OtpSaveWidgetState extends State<OtpSaveWidget> {
  late final TextEditingController _textEditingController;
  late OtpProvider provider;
  late MobileScannerController controller;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    //TODO: Replace with alternative
    controller = MobileScannerController(formats: [BarcodeFormat.qrCode]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = context.read<OtpProvider>();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.size.width * .6,
          child: TextFormField(
            controller: _textEditingController,
            onSaved: (value) => provider.otp = value ?? "",
            onFieldSubmitted: (value) => provider.otp = value,
            onChanged: (value) => provider.otp = value,
            decoration: const InputDecoration(labelText: "OTP Secret"),
          ),
        ),
        IconButton(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) => MobileScanner(
                      controller: controller,
                      allowDuplicates: false,
                      onDetect: ((barcode, args) => setState(() {
                            String uri = barcode.rawValue ?? "";
                            String code = _parseOTPCode(uri);
                            _textEditingController.value =
                                TextEditingValue(text: code);
                            if (code != "-1") provider.otp = code;
                            controller.stop();
                            Navigator.of(context).pop();
                          }))));
            },
            icon: const Icon(Icons.qr_code))
      ],
    );
  }

  String _parseOTPCode(String uri) {
    Uri parsedUri = Uri.parse(uri);
    if (parsedUri.hasQuery) {
      Map<String, List<String>> queryParameters = parsedUri.queryParametersAll;
      return queryParameters["secret"]![0];
    } else {
      return "";
    }
  }
}
