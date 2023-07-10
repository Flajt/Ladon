import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ladon/features/otp/bloc/OtpBloc.dart';
import 'package:ladon/features/otp/bloc/events/OtpEvents.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
  late MobileScannerController controller;
  late final OtpBloc _otpBloc;
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
    _otpBloc = context.read<OtpBloc>();
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
            onSaved: (value) => _otpBloc.add(SetOtpSecret(value ?? "")),
            onFieldSubmitted: (value) => _otpBloc.add(SetOtpSecret(value)),
            onChanged: (value) => _otpBloc.add(SetOtpSecret(value)),
            decoration: const InputDecoration(labelText: "OTP Secret"),
          ),
        ),
        IconButton(
            onPressed: () async {
              await controller.start();
              // ignore: use_build_context_synchronously
              await showDialog(
                  context: context,
                  builder: (context) => MobileScanner(
                      controller: controller,
                      onDetect: ((data) => setState(() {
                            String uri = data.barcodes.first.rawValue ?? "";
                            String code = _parseOTPCode(uri);
                            _textEditingController.value =
                                TextEditingValue(text: code);
                            if (code != "-1") _otpBloc.add(SetOtpSecret(code));
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
