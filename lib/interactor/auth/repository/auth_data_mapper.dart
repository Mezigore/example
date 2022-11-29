import 'package:uzhindoma/api/data/auth/next_time_otp_data.dart';
import 'package:uzhindoma/api/data/auth/public_key_data.dart';
import 'package:uzhindoma/api/data/auth/tokens_data.dart';
import 'package:uzhindoma/domain/auth/next_time_otp.dart';
import 'package:uzhindoma/domain/auth/public_key.dart';
import 'package:uzhindoma/domain/auth/tokens.dart';

/// Маппер [PublicKey] из [PublicKeyData]
PublicKey mapPublicKey(PublicKeyData data) {
  final time = int.tryParse(data.time) ?? 0;
  return PublicKey(
    publicKey: data.publicKey,
    endTime: DateTime.fromMillisecondsSinceEpoch(time * 1000),
  );
}

/// Маппер [Tokens] из [TokensData]
Tokens mapTokens(TokensData data) {
  return Tokens(
    accessToken: data.accessToken,
    tokenType: data.tokenType,
    issued: data.issued,
    expires: data.expires,
    refreshToken: data.refreshToken,
    userId: data.userId,
  );
}

/// Маппер [NextTimeOtp] из [NextTimeOtpData]
NextTimeOtp mapNextTimeOtp(NextTimeOtpData data) {
  return NextTimeOtp(
    nextOtp: data.nextOtp,
  );
}
