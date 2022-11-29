import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/widgets/input/address_input/address_input_wm.dart';

/// [Component] для <AddressInput>
class AddressInputComponent implements Component {
  AddressInputComponent(BuildContext context) {
    _parent = Injector.of<AppComponent>(context).component;

    _messageController = MaterialMessageController(scaffoldKey);
    _dialogController = DefaultDialogController(scaffoldKey);

    _wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        _messageController,
        _dialogController,
        _parent.scInteractor,
      ),
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  AppComponent _parent;
  MessageController _messageController;
  DialogController _dialogController;
  WidgetModelDependencies _wmDependencies;
}

AddressInputWidgetModel createAddressInputWidgetModel(
  BuildContext context,
  TextEditingController textEditingController,
  FocusNode focusNode,
) {
  final component = Injector.of<AddressInputComponent>(context).component;

  return AddressInputWidgetModel(
    component._wmDependencies,
    component._parent.addressInteractor,
    textEditingController,
    focusNode,
  );
}
