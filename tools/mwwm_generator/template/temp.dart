import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

// ignore: always_use_package_imports
import 'di/temp_component.dart';
// ignore: always_use_package_imports
import 'temp_wm.dart';

/// TODO Описание экрана
class $Temp$ extends MwwmWidget<$Temp$Component> {
  $Temp$({Key key})
      : super(
          widgetModelBuilder: create$Temp$WidgetModel,
          dependenciesBuilder: (context) => $Temp$Component(context),
          widgetStateBuilder: () => _$Temp$State(),
          key: key,
        );
}

class _$Temp$State extends WidgetState<$Temp$WidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<$Temp$Component>(context).component.scaffoldKey,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: white,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return const Text('temp screen');
  }
}
