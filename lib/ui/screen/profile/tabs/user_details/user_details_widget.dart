import 'package:flutter/material.dart' hide Action;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/user/favourite_item.dart';
import 'package:uzhindoma/domain/user/gender_info.dart';
import 'package:uzhindoma/domain/user/user_info.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/radio.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/main/widget/cards/card.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/user_details/di/user_details_component.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/user_details/user_details_wm.dart';
import 'package:uzhindoma/ui/widget/common/suggest_tile.dart';
import 'package:uzhindoma/util/const.dart';
import 'package:uzhindoma/util/validate_data.dart';

// ignore_for_file: prefer_mixin

/// Widget [UserDetailsWidget] - Мои данные
class UserDetailsWidget extends MwwmWidget<UserDetailsComponent> {
  UserDetailsWidget({
    Key key,
  }) : super(
          key: key,
          widgetModelBuilder: createUserDetailsWm,
          dependenciesBuilder: (context) => UserDetailsComponent(context),
          widgetStateBuilder: () => _UserDetailsWidgetState(),
        );
}

class _UserDetailsWidgetState extends WidgetState<UserDetailsWidgetModel>
    with WidgetsBindingObserver {
  double devicePixelRatio;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    devicePixelRatio ??= WidgetsBinding.instance.window.devicePixelRatio;
  }

  @override
  void didChangeMetrics() {
    wm.isOpenKeyboardState.accept(
      WidgetsBinding.instance.window.viewInsets.bottom > 0,
    );
    wm.bottomSizeState.accept(
      WidgetsBinding.instance.window.viewInsets.bottom / devicePixelRatio,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<EntityState<UserInfo>>(
      streamedState: wm.userState,
      builder: (context, entity) {
        return Stack(
          children: [
            SwipeRefresh.adaptive(
              scrollController: wm.scrollController,
              onRefresh: wm.reloadAction,
              stateStream: wm.reloadState.stream,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Form(
                  key: wm.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RenderMetricsObject<dynamic>(
                          id: idTopWidget,
                          manager: wm.renderManager,
                          child: const SizedBox(height: 32),
                        ),
                        wm.birthdayController.controller.value.text.isEmpty
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: pressedButton,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 24),
                                child: Text(
                                  wm.userState.value.data.noBirthdayText,
                                  style: textMedium16,
                                ),
                              )
                            : const SizedBox(),
                        const _Title(text: userDetailsWidgetMainText),
                        const _TextInfo(
                          text: userDetailsWidgetMinimalInformationText,
                        ),
                        const SizedBox(height: 24),
                        _TextField(
                          isEnable: !entity.isLoading,
                          controller: wm.nameController.controller,
                          labelText: userDetailsWidgetNameText,
                          focusNode: wm.nameFocus,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                          validator: _validOnEmpty,
                          onAddFocusNode: wm.onAddFocusWithError,
                          onRemoveFocusNode: wm.onRemoveFocusWithError,
                        ),
                        const SizedBox(height: 16),
                        _TextField(
                          isEnable: !entity.isLoading,
                          controller: wm.lastNameController.controller,
                          labelText: userDetailsWidgetSurnameText,
                          focusNode: wm.lastNameFocus,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                          validator: _validOnEmpty,
                          onAddFocusNode: wm.onAddFocusWithError,
                          onRemoveFocusNode: wm.onRemoveFocusWithError,
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap:
                              entity.isLoading ? null : wm.onChangePhoneAction,
                          child: _TextField(
                            isEnable: false,
                            controller: wm.phoneController.controller,
                            labelText: userDetailsWidgetPhoneText,
                            suffixIcon: Icons.arrow_forward_ios,
                            textInputType: null,
                            validator: _validOnEmpty,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const _CaptionsText(text: userDetailsWidgetInfoSmsText),
                        const SizedBox(height: 16),
                        _TextField(
                          isEnable: !entity.isLoading,
                          controller: wm.emailController.controller,
                          labelText: userDetailsWidgetEmailText,
                          focusNode: wm.emailFocus,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                          onAddFocusNode: wm.onAddFocusWithError,
                          onRemoveFocusNode: wm.onRemoveFocusWithError,
                          validator: (text) =>
                              validateEmail(text) ? null : emptyString,
                        ),
                        const SizedBox(height: 8),
                        const _CaptionsText(
                          text: userDetailsWidgetDetailsInfoText,
                        ),
                        const SizedBox(height: 40),
                        const _Title(text: userDetailsWidgetMoreText),
                        const _TextInfo(text: userDetailsWidgetMoreInfoText),
                        const SizedBox(height: 24),
                        StreamedStateBuilder<bool>(
                          streamedState: wm.lockBirthdayState,
                          builder: (context, isLock) {
                            return GestureDetector(
                              onTap: entity.isLoading || isLock
                                  ? null
                                  : wm.onChangeBirthdayAction,
                              child: _TextField(
                                isEnable: false,
                                controller: wm.birthdayController.controller,
                                labelText: userDetailsWidgetBirthdayText,
                                textInputType: null,
                                style: textRegular16Secondary,

                                /// Необязательное поле
                                validator: (_) => null,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        const _CaptionsText(
                          text: userDetailsWidgetBirthdayInfoText,
                        ),
                        const SizedBox(height: 26),
                        _RadioButtons(
                          callback: wm.onSelectGenderAction,
                          genderState: wm.genderState,
                        ),
                        const SizedBox(height: 34),
                        const _Title(text: userDetailsWidgetFavoriteDishesText),
                        const _TextInfo(
                          text: userDetailsWidgetFavoriteDishesInfoText,
                        ),
                        StreamedStateBuilder<List<FavouriteItem>>(
                          streamedState: wm.favouriteItemsState,
                          builder: (context, items) {
                            return _FavoriteDishes(
                              items: items,
                              onRemoveItem: wm.onRemoveFavouriteItem,
                            );
                          },
                        ),
                        RenderMetricsObject<dynamic>(
                          id: idFavoriteDishes,
                          manager: wm.renderManager,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: StreamedStateBuilder<List<FavouriteItem>>(
                              streamedState: wm.favouriteItemsState,
                              builder: (context, items) {
                                return (items?.length ?? 0) >= 5
                                    ? const SizedBox.shrink()
                                    : _TextField(
                                        controller: wm.favoriteDishesController
                                            .controller,
                                        textInputAction: TextInputAction.done,
                                        labelText:
                                            userDetailsWidgetFavoriteDishesLabelTextText,
                                        focusNode: wm.focusNode,
                                        // Всегда валидно
                                        validator: (_) => null,
                                        textInputType: TextInputType.text,
                                      );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: wm.onDeleteAccount,
                          child: const Text(
                            'Удалить аккаунт',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(45, 125, 225, 1)),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Все содержимое будет стерто: вся история \nваших заказов, все ваши оценки рецептов и \nужинов, персональные данные. Чтобы \nвосстановить аккаунт напишите в WhatsApp на \nномер +79161704385.',
                          style: TextStyle(fontSize: 14),
                        ),
                        StreamedStateBuilder<double>(
                          streamedState: wm.heightFavoriteState,
                          builder: (context, height) {
                            return (height == null || height == 0.0)
                                ? const SizedBox(height: 84)
                                : SizedBox(
                                    height: height,
                                    width: double.infinity,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 32),
                                      child: StreamBuilder<String>(
                                        stream:
                                            wm.favoriteDishesController.stream,
                                        builder: (context, snapshot) {
                                          return _SearchFavorite(
                                            key: UniqueKey(),
                                            searchFavoriteState:
                                                wm.searchFavoriteState,
                                            searchText: snapshot.data,
                                            onSelectFavoriteItem:
                                                wm.onSelectFavoriteItem,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            StreamedStateBuilder<bool>(
              streamedState: wm.acceptButtonState,
              builder: (context, snapshot) {
                return (snapshot ?? false)
                    ? _AcceptButton(callback: wm.onSaveAction)
                    : const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  String _validOnEmpty(String text) =>
      text?.trim()?.isNotEmpty ?? false ? null : emptyString;
}

class _SearchFavorite extends StatelessWidget {
  _SearchFavorite({
    Key key,
    @required this.searchFavoriteState,
    @required this.onSelectFavoriteItem,
    String searchText,
  })  : searchText = searchText ?? emptyString,
        assert(searchFavoriteState != null),
        assert(onSelectFavoriteItem != null),
        super(key: key);

  final StreamedState<EntityState<List<FavouriteItem>>> searchFavoriteState;

  final _controller = ScrollController();

  final String searchText;

  final Action<FavouriteItem> onSelectFavoriteItem;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: double.infinity,
        child: StreamedStateBuilder<EntityState<List<FavouriteItem>>>(
          streamedState: searchFavoriteState,
          builder: (context, entityState) {
            if (entityState?.hasError ?? false) {
              return const CardWidget(
                borderRadius: 12,
                child: _InfoSearchFavoriteDishes(
                  text: userDetailsWidgetSearchErrorText,
                ),
              );
            }
            if (entityState?.data == null) {
              return const SizedBox.shrink();
            }

            if (entityState.data.isEmpty) {
              return const CardWidget(
                borderRadius: 12,
                child: _InfoSearchFavoriteDishes(
                  text: userDetailsWidgetNoSearchText,
                ),
              );
            }

            return CardWidget(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Scrollbar(
                  controller: _controller,
                  isAlwaysShown: true,
                  thickness: 2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _controller,
                    itemCount: entityState.data.length,
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    itemBuilder: (_, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => onSelectFavoriteItem
                              .accept(entityState.data[index]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: SuggestTileWidget(
                              suggest: entityState.data[index].name,
                              searchedText: searchText,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InfoSearchFavoriteDishes extends StatelessWidget {
  const _InfoSearchFavoriteDishes({
    Key key,
    @required this.text,
  })  : assert(text != null),
        super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        text,
        style: textRegular14Hint,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _FavoriteDishes extends StatelessWidget {
  const _FavoriteDishes({
    Key key,
    @required this.items,
    @required this.onRemoveItem,
  })  : assert(onRemoveItem != null),
        super(key: key);

  final List<FavouriteItem> items;

  final Action<FavouriteItem> onRemoveItem;

  @override
  Widget build(BuildContext context) {
    if (items == null || items.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.only(top: items.isNotEmpty ? 24 : 0),
      child: Column(
        children: [
          const Divider(),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              return Row(
                children: [
                  const SizedBox(height: 11),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          items[index].name,
                          style: textRegular16,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onRemoveItem.accept(items[index]),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Center(
                            child: SvgPicture.asset(
                              icDelete,
                              color: iconColor,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                ],
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _AcceptButton extends StatelessWidget {
  const _AcceptButton({
    Key key,
    this.callback,
  }) : super(key: key);

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final EdgeInsets padding = data.padding;
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(bottom: padding.bottom),
          color: white,
          child: AcceptButton(
            text: userDetailsWidgetSaveText,
            callback: callback,
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: textMedium24),
    );
  }
}

class _RadioButtons extends StatelessWidget {
  const _RadioButtons({
    Key key,
    this.callback,
    this.genderState,
  }) : super(key: key);
  final Action<GenderInfo> callback;

  final StreamedState<GenderInfo> genderState;

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<GenderInfo>(
      streamedState: genderState,
      builder: (context, gender) {
        return Row(
          children: [
            _RadioButton(
              callback: () => callback?.call(GenderInfo.M),
              gender: gender,
              title: userDetailsWidgetRadioManText,
              isSelected: gender == GenderInfo.M,
            ),
            _RadioButton(
              callback: () => callback?.call(GenderInfo.F),
              gender: gender,
              title: userDetailsWidgetRadioWomanText,
              isSelected: gender == GenderInfo.F,
            ),
          ],
        );
      },
    );
  }
}

class _RadioButton extends StatelessWidget {
  const _RadioButton({
    Key key,
    this.gender,
    this.callback,
    @required this.isSelected,
    @required this.title,
  })  : assert(isSelected != null),
        assert(title != null),
        super(key: key);

  final GenderInfo gender;
  final VoidCallback callback;
  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleRadio(isSelected: isSelected),
            const SizedBox(width: 10),
            Text(title, style: textRegular16Hint),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class _CaptionsText extends StatelessWidget {
  const _CaptionsText({
    Key key,
    @required this.text,
  })  : assert(text != null),
        super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: textRegular12Secondary,
      ),
    );
  }
}

class _TextInfo extends StatelessWidget {
  const _TextInfo({
    Key key,
    @required this.text,
  })  : assert(text != null),
        super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textRegular14Secondary,
    );
  }
}

class _TextField extends StatefulWidget {
  const _TextField({
    @required this.labelText,
    @required this.textInputType,
    @required this.validator,
    this.textInputAction,
    this.controller,
    this.focusNode,
    this.isEnable,
    this.suffixIcon,
    Key key,
    this.style,
    this.onAddFocusNode,
    this.onRemoveFocusNode,
  })  : assert(labelText != null),
        assert(validator != null),
        super(key: key);

  final TextStyle style;
  final FocusNode focusNode;
  final bool isEnable;

  final TextInputAction textInputAction;

  /// Контроллер ввода
  final TextEditingController controller;

  final String labelText;

  /// Иконка
  final IconData suffixIcon;

  final TextInputType textInputType;

  final FormFieldValidator<String> validator;

  final ValueChanged<FocusNode> onAddFocusNode;
  final ValueChanged<FocusNode> onRemoveFocusNode;

  @override
  State<StatefulWidget> createState() {
    return _TextFieldState();
  }
}

class _TextFieldState extends State<_TextField> {
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _validator,
      focusNode: _focusNode,
      controller: widget.controller,
      enabled: widget.isEnable,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      style: widget.style ?? textRegular16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: 100,
      autocorrect: false,
      decoration: InputDecoration(
        enabled: widget.isEnable ?? true,
        filled: true,
        counterText: emptyString,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        labelText: widget.labelText,
        labelStyle: textRegular16Secondary,
        errorStyle: textRegular12Error.copyWith(height: 0),
        errorMaxLines: 2,
        fillColor: textFormFieldFillColor,
        suffixIcon: widget.suffixIcon == null
            ? null
            : Icon(
                widget.suffixIcon,
                size: 16,
                color: iconColor40o,
              ),
      ),
    );
  }

  String _validator(String text) {
    final errorText = widget.validator(text);
    if (errorText != null) {
      widget.onAddFocusNode?.call(_focusNode);
    } else {
      widget.onRemoveFocusNode?.call(_focusNode);
    }
    return errorText;
  }
}
