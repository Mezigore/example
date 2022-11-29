import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/ui/res/animations.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

// ignore: always_use_package_imports
import 'cart_button_wm.dart';
// ignore: always_use_package_imports
import 'di/cart_button_component.dart';

/// Виджет кнопки корзины.
class CartButton extends MwwmWidget<CartButtonComponent> {
  CartButton({Key key})
      : super(
          widgetModelBuilder: createCartButtonWidgetModel,
          dependenciesBuilder: (context) => CartButtonComponent(context),
          widgetStateBuilder: () => _CartButtonState(),
          key: key,
        );
}

class _CartButtonState extends WidgetState<CartButtonWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<Cart>(
      streamedState: wm.cartState,
      loadingBuilder: (ctx, cart) {
        final count = cart?.menu?.length ?? 0;
        if (count > 0) {
          return _CartButton(mode: _CartButtonMode.loading, cart: cart);
        }

        return _CartButton(mode: _CartButtonMode.hidden);
      },
      errorBuilder: (ctx, cart, exception) {
        final count = cart?.menu?.length ?? 0;
        if (count > 0) {
          return _CartButton(
            mode: _CartButtonMode.content,
            cart: cart,
            onTap: wm.openCartAction,
          );
        }

        return _CartButton(mode: _CartButtonMode.hidden);
      },
      child: (ctx, cart) {
        final count = cart?.menu?.length ?? 0;
        if (count > 0) {
          return _CartButton(
            mode: _CartButtonMode.content,
            cart: cart,
            onTap: wm.openCartAction,
          );
        }

        return _CartButton(mode: _CartButtonMode.hidden);
      },
    );
  }
}

class _CartButton extends StatefulWidget {
  const _CartButton({
    Key key,
    @required this.mode,
    this.cart,
    this.onTap,
  })  : assert(mode != null),
        assert(mode == _CartButtonMode.hidden || cart != null),
        super(key: key);

  final _CartButtonMode mode;
  final Cart cart;
  final VoidCallback onTap;

  @override
  __CartButtonState createState() => __CartButtonState();
}

class __CartButtonState extends State<_CartButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  Cart _cart;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: verySlowAnimation,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );

    _cart = widget.cart;

    if (widget.mode != _CartButtonMode.hidden) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _CartButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.mode == _CartButtonMode.hidden &&
        widget.mode != _CartButtonMode.hidden) {
      _animationController.forward();
    } else if (oldWidget.mode != _CartButtonMode.hidden &&
        widget.mode == _CartButtonMode.hidden) {
      _animationController.reverse();
    }

    if (widget.mode != _CartButtonMode.hidden) {
      _cart = widget.cart;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        color: backgroundColor,
        child: _cart == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.fromLTRB(
                  20.0,
                  12.0,
                  20.0,
                  16.0,
                ),
                child: Column(
                  key: ObjectKey(_cart),
                  children: [
                    _Hint(cart: _cart),
                    _Button(
                      cart: _cart,
                      onTap: widget.onTap,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({
    Key key,
    @required this.cart,
  })  : assert(cart != null),
        super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final text = cart.promoname != null? '': cart.hintText;

    if (text == null || text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Text(
          text,
          style: textRegular12Secondary,
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.cart,
    this.onTap,
  })  : assert(cart != null),
        super(key: key);

  final Cart cart;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        primary: cartButtonBackgroundColor,
        elevation: 0,
      ),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(cart.countText, style: textRegular16White),
            Row(
              children: [
                if (cart.hasDiscount)
                  Text(
                    cart.totalPriceText,
                    style: textRegular16WhiteOpacityCross,
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    cart.discountPriceText,
                    style: textRegular16White,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum _CartButtonMode { hidden, loading, content }
