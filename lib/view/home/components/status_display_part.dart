import 'package:flutter/material.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/utils/constants.dart';
import 'package:meditation/view/styles.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class StatusDisplayPart extends StatelessWidget {
  const StatusDisplayPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final runningStatus = context.select<MainViewModel, RunningStatus>(
        (viewModel) => viewModel.runningStatus);

    return Column(
      children: [
        SizedBox(height: 8.0),
        Text(
          _upperSmallText(context, runningStatus),
          style: statusUpperTextStyle,
        ),
        Selector<MainViewModel, int>(
            selector: (context, viewModel) =>
                viewModel.intervalRemainingSeconds,
            builder: (context, intervalRemainingSeconds, child) {
              return Text(
                _lowerLargeText(
                    context, runningStatus, intervalRemainingSeconds),
                style: statusLowerTextStyle,
              );
            }),
      ],
    );
  }

  String _upperSmallText(BuildContext context, RunningStatus runningStatus) {
    String displayText = "";
    switch (runningStatus) {
      case RunningStatus.BEFORE_START:
        displayText = "";
        break;
      case RunningStatus.ON_START:
        displayText = S.of(context).startsIn;
        break;
      case RunningStatus.INHALE:
        displayText = S.of(context).inhale;
        break;
      case RunningStatus.HOLD:
        displayText = S.of(context).hold;
        break;
      case RunningStatus.EXHALE:
        displayText = S.of(context).exhale;
        break;
      case RunningStatus.PAUSE:
        displayText = S.of(context).pause;
        break;
      case RunningStatus.FINISHED:
        displayText = "";
        loadInterstitialAd(context);
        break;
    }
    return displayText;
  }

  String _lowerLargeText(BuildContext context, RunningStatus runningStatus,
      int intervalRemainingSeconds) {
    String displayText = "";
    if (runningStatus == RunningStatus.BEFORE_START) {
      displayText = "";
    } else if (runningStatus == RunningStatus.FINISHED) {
      displayText = S.of(context).finished;
    } else {
      displayText = intervalRemainingSeconds.toString();
    }
    return displayText;
  }

  void loadInterstitialAd(BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    final isDeleteAd = viewModel.isDeleteAd;
    if (!isDeleteAd) viewModel.loadInterstitialAd();
  }
}
