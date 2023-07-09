import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ladon/features/otp/bloc/OtpBloc.dart';
import 'package:ladon/features/otp/bloc/events/OtpEvents.dart';
import 'package:ladon/features/otp/blueprints/OtpBlueprint.dart';
import 'package:ladon/features/otp/logic/generateOtp.dart';

class OtpTile extends StatelessWidget {
  const OtpTile({Key? key, required this.otpBlueprint}) : super(key: key);
  final OtpBlueprint otpBlueprint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => context.read<OtpBloc>().add(DeleteOtp(otpBlueprint)),
      leading: CircleAvatar(
        child: CachedNetworkImage(
          imageUrl: otpBlueprint.imageUrl,
          progressIndicatorBuilder: (context, message, progress) =>
              const CircularProgressIndicator.adaptive(),
          errorWidget: (context, errorMessge, other) =>
              const Icon(Icons.question_mark_rounded),
        ),
      ),
      title: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 30), (number) {
          return generateTotp(otpBlueprint.secret);
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else if (!snapshot.hasData && !snapshot.hasError) {
            return Text(generateTotp(otpBlueprint.secret));
          } else {
            return Text(snapshot.error.toString());
          }
        },
      ),
      trailing: IconButton(
          onPressed: () {
            //TODO: store the generated key for 30s instead of regenerateing it
            Clipboard.setData(
                ClipboardData(text: generateTotp(otpBlueprint.secret)));
          },
          icon: const Icon(Icons.copy)),
    );
  }
}
