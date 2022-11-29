import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:uzhindoma/ui/base/owners/snackbar_owner.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/util/enum.dart';

///Стандартная реализация [MessageController]
class MaterialMessageController extends MessageController {
  MaterialMessageController(this._scaffoldState, {this.snackOwner})
      : _context = null;

  MaterialMessageController.from(this._context, {this.snackOwner})
      : _scaffoldState = null;

  final GlobalKey<ScaffoldState> _scaffoldState;
  final BuildContext _context;
  final CustomSnackBarOwner snackOwner;

  /// Дефолтные снеки, используются если виджет не определил свои
  final Map<MsgType, SnackBar Function(String text)> defaultSnackBarBuilder = {
    MsgType.commonError: (text) => SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black87,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
    MsgType.common: (text) => SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black87,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
  };

  void showBaseSnackBar({
    @required String text,
    String pathAssetsIcon,
    VoidCallback callback,
    Function afterClose,
  }) {
    ScaffoldMessenger.of(_context).showSnackBar(
          _baseSnackBar(
            text: text,
            callback: callback,
            pathAssetsIcon: pathAssetsIcon,
          ),
        )
        .closed
        .whenComplete(() => afterClose?.call());
  }

  ScaffoldState get _state =>
      _scaffoldState?.currentState ?? Scaffold.of(_context);

  @override
  void show({String msg, Object msgType = MsgType.common}) {
    assert(msg != null || msgType != null);

    final owner = snackOwner;
    Logger.d(' SnackBar owner is nul? ${owner == null}');
    SnackBar snack;
    if (owner != null) {
      snack = owner.registeredSnackBarsBuilder[msgType](msg);
    }
    Logger.d(' SnackBar is nul? ${snack == null} by type = $msgType');

    Future.delayed(const Duration(milliseconds: 10), () {
      ScaffoldMessenger.of(_context).showSnackBar(
        snack ?? defaultSnackBarBuilder[msgType](msg),
      );
    });
  }
}

/// Типы сообщений
class MsgType extends Enum<String> {
  const MsgType(String value) : super(value);

  static const commonError = MsgType('commonError');
  static const common = MsgType('common');
}

/// Стандартный снек бар для приложения
SnackBar _baseSnackBar({
  @required String text,
  String pathAssetsIcon,
  VoidCallback callback,
}) {
  assert(text != null);
  return SnackBar(
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.black87,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
    padding: const EdgeInsets.symmetric(vertical: 12),
    content: Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Text(
            text,
            style: textRegular14White,
          ),
        ),
        if (pathAssetsIcon != null)
          GestureDetector(
            onTap: callback,
            child: SvgPicture.asset(pathAssetsIcon),
          ),
        const SizedBox(width: 16),
      ],
    ),
  );
}
