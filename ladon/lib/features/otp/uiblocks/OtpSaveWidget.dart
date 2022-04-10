import 'package:flutter/material.dart';
import 'package:ladon/features/otp/logic/QrScanner.dart';
import 'package:ladon/shared/provider/OtpProvider.dart';
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

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = context.read<OtpProvider>();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
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
              String uri = await QrScanner.scan();
              String code = _parseOTPCode(uri);
              _textEditingController.value = TextEditingValue(text: code);
              if (code != "-1") provider.otp = code;
            },
            icon: const Icon(Icons.qr_code))
      ],
    );
  }

  String _parseOTPCode(String uri) {
    Uri parsedUri = Uri.parse(uri);
    Map<String, List<String>> queryParameters = parsedUri.queryParametersAll;
    return queryParameters["secret"]![0];
  }
}
