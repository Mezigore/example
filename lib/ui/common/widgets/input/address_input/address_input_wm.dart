import 'package:flutter/widgets.dart' hide Action;
import 'package:rxdart/rxdart.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/interactor/address/address_interactor.dart';
import 'package:uzhindoma/ui/common/widgets/input/fixed_edit_controller.dart';

/// [WidgetModel] для <AddressInput>
class AddressInputWidgetModel extends WidgetModel {
  AddressInputWidgetModel(
    WidgetModelDependencies dependencies,
    this._addressInteractor,
    TextEditingController textEditingController,
    FocusNode focusNode,
  )   : focusNode = focusNode ?? FocusNode(),
        textEditingController = textEditingController ?? FixedEditController(),
        super(dependencies);

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final AddressInteractor _addressInteractor;

  final selectAction = Action<String>();
  final suggestsState = StreamedState<List<String>>([]);
  final focusState = StreamedState<bool>(false);
  final currentInputState = StreamedState<String>();
  final lastSelectionState = StreamedState<String>();

  @override
  void onLoad() {
    super.onLoad();
    textEditingController.addListener(_listenEditText);
    focusNode.addListener(_listenFocus);
    if (textEditingController?.text != null &&
        textEditingController.text.trim().isNotEmpty) {
      lastSelectionState.accept(textEditingController.text);
    }
    _subscribeToChangeText();
  }

  @override
  void onBind() {
    super.onBind();
    bind<String>(
      selectAction,
      (suggestion) {
        lastSelectionState.accept(suggestion);
        suggestsState.accept();
        textEditingController.text = suggestion;
      },
    );
  }

  @override
  void dispose() {
    textEditingController.removeListener(_listenEditText);
    focusNode.removeListener(_listenFocus);
    textEditingController.dispose();
    super.dispose();
  }

  void _listenEditText() {
    if (textEditingController.text == lastSelectionState.value) return;
    currentInputState.accept(textEditingController.text);
  }

  void _subscribeToChangeText() {
    subscribe(
      currentInputState.stream.debounceTime(const Duration(milliseconds: 500)),
      _loadSuggestions,
    );
  }

  void _loadSuggestions(String address) {
    if (address == null || address.isEmpty) {
      suggestsState.accept();
      return;
    }
    doFuture(
      _addressInteractor.searchAddress(address),
      suggestsState.accept,
    );
  }

  void _listenFocus() {
    focusState.accept(focusNode.hasFocus);
  }
}
