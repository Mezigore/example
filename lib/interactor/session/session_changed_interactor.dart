import 'package:rxdart/subjects.dart';
import 'package:uzhindoma/interactor/token/token_storage.dart';

/// Интерактор сессии пользователя
class SessionChangedInteractor {
  SessionChangedInteractor(this._ts);

  final AuthInfoStorage _ts;

  final PublishSubject<SessionState> sessionSubject = PublishSubject();

  void onSessionChanged() {
    sessionSubject.add(SessionState.loggedIn);
  }

  void forceLogout() {
    sessionSubject.add(SessionState.loggedOut);
    _ts.clearData();
  }
}

enum SessionState { loggedIn, loggedOut }
