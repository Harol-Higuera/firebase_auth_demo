import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_link_state.freezed.dart';

@freezed
class EmailLinkState with _$EmailLinkState {
  factory EmailLinkState({
    @Default('') String description ,
    @Default('') String entryEmailAddress,
    @Default(false) bool isUserLoggedIn,
  }) = _EmailLinkState;
}
