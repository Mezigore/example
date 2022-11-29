import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/imported/round_checkbox.dart';
import 'package:uzhindoma/ui/common/widgets/input/address_input/address_input.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/address_form/address_form_wm.dart';
import 'package:uzhindoma/ui/widget/address_form/di/address_form_component.dart';

/// Состояние чекбокса адреса по умолчанию
enum AddressPrimaryCheckBoxState {
  ///Всегда в true
  alwaysTrue,

  /// Можно выбирать
  selectable,

  /// Его нет
  none,
}

/// Форма заполнения адреса пользователя
class AddressForm extends MwwmWidget<AddressFormComponent> {
  AddressForm({
    Key key,
    NewAddress initAddress,
    ValueChanged<NewAddress> onAddressAccepted,
    String acceptButtonText = saveTitle,
    AddressPrimaryCheckBoxState checkBoxState =
        AddressPrimaryCheckBoxState.none,
  })  : assert(acceptButtonText != null),
        assert(checkBoxState != null),
        super(
          key: key,
          dependenciesBuilder: (context) => AddressFormComponent(context),
          widgetStateBuilder: () => _AddressFormState(
            acceptButtonText,
            checkBoxState,
          ),
          widgetModelBuilder: (context) => createAddressFormWidgetModel(
            context,
            initAddress,
            onAddressAccepted,
          ),
        );
}

class _AddressFormState extends WidgetState<AddressFormWidgetModel> {
  _AddressFormState(
    this.acceptButtonText,
    // ignore: avoid_positional_boolean_parameters
    this.checkBoxState,
  );

  final String acceptButtonText;
  final AddressPrimaryCheckBoxState checkBoxState;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: wm.formKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddressInput(
              controller: wm.addressNameTextController,
              focusNode: wm.addressNameFocusNode,
              onEditingComplete: () => wm.flatFocusNode.requestFocus(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _SmallTextField(
                    controller: wm.flatTextController,
                    focusNode: wm.flatFocusNode,
                    onEditingComplete: () => wm.sectionFocusNode.requestFocus(),
                    label: addressFormFlatLabel,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SmallTextField(
                    controller: wm.sectionTextController,
                    focusNode: wm.sectionFocusNode,
                    onEditingComplete: () => wm.floorFocusNode.requestFocus(),
                    label: addressFormSectionAddressLabel,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SmallTextField(
                    controller: wm.floorTextController,
                    focusNode: wm.floorFocusNode,
                    onEditingComplete: () => wm.commentFocusNode.requestFocus(),
                    label: addressFormFloorAddressLabel,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.done,
              controller: wm.commentTextController,
              focusNode: wm.commentFocusNode,
              onEditingComplete: () => wm.commentFocusNode.unfocus(),
              keyboardType: TextInputType.text,
              validator: (_) => null,
              minLines: 1,
              maxLines: 2,
              maxLength: 300,
              decoration: const InputDecoration(
                labelText: commentLabel,
                hintText: addressFormCommentAddressHint,
              ),
            ),
            const SizedBox(height: 26),
            if (checkBoxState != AddressPrimaryCheckBoxState.none)
              StreamedStateBuilder<bool>(
                streamedState: wm.isDefaultState,
                builder: (_, isDefault) => InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: checkBoxState != AddressPrimaryCheckBoxState.alwaysTrue
                      ? () => wm.isDefaultChangedAction(!isDefault)
                      : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleCheckbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: isDefault ||
                            checkBoxState ==
                                AddressPrimaryCheckBoxState.alwaysTrue,
                        onChanged: checkBoxState !=
                                AddressPrimaryCheckBoxState.alwaysTrue
                            ? (_) => wm.isDefaultChangedAction(!isDefault)
                            : (_) {},
                      ),
                      Text(
                        addressIsDefaultAddressLabel,
                        style: textRegular16,
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
            const Spacer(),

            ///TODO krasikov: Добавить состояние загрузки
            StreamedStateBuilder<bool>(
              streamedState: wm.keyBoardOnScreenState,
              builder: (_, isKeyboardOnScreen) {
                if (isKeyboardOnScreen) return const SizedBox.shrink();
                return SafeArea(
                  child: AcceptButton(
                    callback: wm.enterAddressAction,
                    text: acceptButtonText,
                    padding: EdgeInsets.zero,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallTextField extends StatelessWidget {
  const _SmallTextField({
    Key key,
    @required this.label,
    @required this.controller,
    @required this.focusNode,
    @required this.onEditingComplete,
  })  : assert(label != null),
        assert(controller != null),
        assert(focusNode != null),
        assert(onEditingComplete != null),
        super(key: key);

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      keyboardType: TextInputType.number,
      validator: (_) => null,
      maxLength: 5,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
