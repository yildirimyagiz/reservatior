//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//
enum AIChatRole {
  USER,
  ASSISTANT,
  SYSTEM;

  String toJson() => toString().split('.').last;

  factory AIChatRole.fromJson(String name) => values.byName(name);
}
