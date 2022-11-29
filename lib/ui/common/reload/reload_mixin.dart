import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// Миксин для [WidgetModel],
/// которая должна иметь возможность перезагружаться
mixin ReloadMixin on WidgetModel {
  /// состояние загрузки
  final reloadState = StreamedState<SwipeRefreshState>();

  /// событие загрузки
  final reloadAction = Action<void>();

  @override
  void onBind() {
    super.onBind();
    bind<void>(reloadAction, (_) {
      reloadState.accept(SwipeRefreshState.loading);
      reloadData();
    });
  }

  void reloadData();
}
