//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//
enum AccountType {
  OAUTH,
  EMAIL,
  OIDC,
  CREDENTIALS,
  GOOGLE,
  FACEBOOK;

  String toJson() => toString().split('.').last;

  factory AccountType.fromJson(String name) => values.byName(name);
}
