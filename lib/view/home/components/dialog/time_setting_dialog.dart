import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/view/home/home_screen.dart';
import 'package:meditation/view/styles.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class TimeSettingDialog extends StatelessWidget {
  const TimeSettingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeSelectButtons = List.generate(
      meisoTimes.length,
      (int index) => TextButton(
          child: Text(
            meisoTimes[index].timeDisplayString,
            style: timeSettingDialogTextStyle,
          ),
          onPressed: () {
            _setTime(context, meisoTimes[index].timeMinutes);
            Navigator.pop(context);
          }),
    );

    return Container(
      height: 180.0 + 60.0,
      child: Column(
        children: [
          SizedBox(
            height: 8.0,
          ),
          Text(S.of(context).selectTime),
          SizedBox(
            height: 8.0,
          ),
          Table(
            children: [
              TableRow(
                children: [
                  timeSelectButtons[0],
                  timeSelectButtons[1],
                  timeSelectButtons[2],
                ],
              ),
              TableRow(
                children: [
                  timeSelectButtons[3],
                  timeSelectButtons[4],
                  timeSelectButtons[5],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _setTime(BuildContext context, int timeMinutes) {
    final viewModel = context.read<MainViewModel>();
    viewModel.setTime(timeMinutes);

    Fluttertoast.showToast(msg: S.of(context).timeAdjusted);
  }
}
