import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/ui/common/widgets/input/fixed_edit_controller.dart';
import 'package:uzhindoma/util/const.dart';

/// [WidgetModel] для <AddressForm>
// ignore: prefer_mixin
class AddressFormWidgetModel extends WidgetModel with WidgetsBindingObserver {
  AddressFormWidgetModel(
    WidgetModelDependencies dependencies,
    this.initAddress,
    this.onAddressAccepted,
  ) : super(dependencies);

  final NewAddress initAddress;
  final ValueChanged<NewAddress> onAddressAccepted;

  final formKey = GlobalKey<FormState>();

  final addressNameTextController = FixedEditController();
  final flatTextController = TextEditingController();
  final floorTextController = TextEditingController();
  final sectionTextController = TextEditingController();
  final commentTextController = TextEditingController();

  final addressNameFocusNode = FocusNode();
  final flatFocusNode = FocusNode();
  final floorFocusNode = FocusNode();
  final sectionFocusNode = FocusNode();
  final commentFocusNode = FocusNode();

  final enterAddressAction = Action<void>();
  final isDefaultChangedAction = Action<bool>();
  final keyBoardOnScreenState = StreamedState<bool>(false);
  final isDefaultState = StreamedState<bool>(false);

  @override
  void didChangeMetrics() {
    keyBoardOnScreenState.accept(
      WidgetsBinding.instance.window.viewInsets.bottom > 0,
    );
  }

  @override
  void onLoad() {
    super.onLoad();
    _initAddress();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void onBind() {
    super.onBind();
    bind(isDefaultChangedAction, isDefaultState.accept);
    bind<void>(enterAddressAction, (_) => _acceptAddress());
  }

  void _initAddress() {
    if (initAddress == null) return;
    addressNameTextController.text = initAddress.name ?? emptyString;
    flatTextController.text = initAddress.flat?.toString() ?? emptyString;
    floorTextController.text = initAddress.floor?.toString() ?? emptyString;
    sectionTextController.text = initAddress.section?.toString() ?? emptyString;
    commentTextController.text = initAddress.comment ?? emptyString;
    isDefaultState.accept(initAddress.isDefault);
  }

  void _acceptAddress() {
    commentFocusNode.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      final newAddress = NewAddress(
        name: addressNameTextController.text,
        flat: int.tryParse(flatTextController.text),
        floor: int.tryParse(floorTextController.text),
        section: int.tryParse(sectionTextController.text),
        comment: commentTextController.text,
        isDefault: isDefaultState.value,
      );
      onAddressAccepted?.call(newAddress);
    }
  }
}
