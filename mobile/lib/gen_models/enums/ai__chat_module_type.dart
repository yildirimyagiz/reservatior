//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//
enum AIChatModuleType {
  SALES_ASSISTANT,
  PAYMENT_NEGOTIATION,
  RESERVATION_APPROVAL,
  DISPUTE_RESOLUTION,
  CONTRACT_ASSISTANT,
  GENERAL;

  String toJson() => toString().split('.').last;

  factory AIChatModuleType.fromJson(String name) => values.byName(name);
}
