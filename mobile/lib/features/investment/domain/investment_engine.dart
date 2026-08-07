import 'dart:math' as math;

/// Port of client-seo investment-engine ROI core (simplified for mobile).
class RoiInput {
  final double purchasePrice;
  final double monthlyRent;
  final double downPaymentPercent;
  final double interestRate;
  final int holdingPeriodYears;
  final double vacancyRate;
  final double appreciationRate;
  final double annualMaintenance;
  final double serviceCharges;

  const RoiInput({
    required this.purchasePrice,
    required this.monthlyRent,
    this.downPaymentPercent = 25,
    this.interestRate = 5.5,
    this.holdingPeriodYears = 5,
    this.vacancyRate = 8,
    this.appreciationRate = 5,
    this.annualMaintenance = 2000,
    this.serviceCharges = 1500,
  });
}

class RoiOutput {
  final double monthlyCashFlow;
  final double annualCashFlow;
  final double grossRentalYield;
  final double netRentalYield;
  final double capRate;
  final double totalROI;
  final double annualROI;
  final double totalInvestment;
  final double finalPropertyValue;
  final double profitAfterHolding;
  final int breakEvenMonths;
  final double riskScore;

  const RoiOutput({
    required this.monthlyCashFlow,
    required this.annualCashFlow,
    required this.grossRentalYield,
    required this.netRentalYield,
    required this.capRate,
    required this.totalROI,
    required this.annualROI,
    required this.totalInvestment,
    required this.finalPropertyValue,
    required this.profitAfterHolding,
    required this.breakEvenMonths,
    required this.riskScore,
  });
}

class InvestmentEngine {
  InvestmentEngine._();

  static RoiOutput calculateROI(RoiInput input) {
    final downPayment =
        input.purchasePrice * (input.downPaymentPercent / 100);
    final mortgageAmount = input.purchasePrice - downPayment;
    final monthlyRate = input.interestRate / 100 / 12;
    final totalMonths = input.holdingPeriodYears * 12;

    final monthlyMortgagePayment = mortgageAmount > 0 && monthlyRate > 0
        ? (mortgageAmount *
                monthlyRate *
                math.pow(1 + monthlyRate, totalMonths)) /
            (math.pow(1 + monthlyRate, totalMonths) - 1)
        : (totalMonths > 0 ? mortgageAmount / totalMonths : 0.0);

    final annualMortgage = monthlyMortgagePayment * 12;
    final annualRent = input.monthlyRent * 12;
    final effectiveRent = annualRent * (1 - input.vacancyRate / 100);
    final operating = input.annualMaintenance + input.serviceCharges;
    final annualCashFlow = effectiveRent - annualMortgage - operating;
    final monthlyCashFlow = annualCashFlow / 12;

    final grossYield = (effectiveRent / input.purchasePrice) * 100;
    final noi = effectiveRent - operating;
    final netYield = (noi / input.purchasePrice) * 100;
    final capRate = netYield;

    final totalInvestment = downPayment +
        input.annualMaintenance * input.holdingPeriodYears +
        input.serviceCharges * input.holdingPeriodYears;

    var cumulative = 0.0;
    var mortgageBalance = mortgageAmount;
    for (var year = 1; year <= input.holdingPeriodYears; year++) {
      final yearRent =
          annualRent * math.pow(1.03, year - 1) * (1 - input.vacancyRate / 100);
      final yearNet = yearRent - annualMortgage - operating;
      cumulative += yearNet;
      for (var m = 0; m < 12; m++) {
        final interest = mortgageBalance * monthlyRate;
        final principal = monthlyMortgagePayment - interest;
        mortgageBalance = math.max(0, mortgageBalance - principal);
      }
    }

    final finalValue = input.purchasePrice *
        math.pow(1 + input.appreciationRate / 100, input.holdingPeriodYears);
    final totalReturn = cumulative + (finalValue - input.purchasePrice);
    final totalROI =
        totalInvestment > 0 ? (totalReturn / totalInvestment) * 100 : 0.0;
    final annualROI =
        input.holdingPeriodYears > 0 ? totalROI / input.holdingPeriodYears : 0.0;

    var breakEven = -1;
    if (annualCashFlow > 0) {
      breakEven = ((totalInvestment * 0.1) / (annualCashFlow / 12)).round();
    }

    final risk = _riskScore(
      vacancy: input.vacancyRate,
      interest: input.interestRate,
      appreciation: input.appreciationRate,
      netYield: netYield,
    );

    return RoiOutput(
      monthlyCashFlow: monthlyCashFlow,
      annualCashFlow: annualCashFlow,
      grossRentalYield: grossYield,
      netRentalYield: netYield,
      capRate: capRate,
      totalROI: totalROI,
      annualROI: annualROI,
      totalInvestment: totalInvestment,
      finalPropertyValue: finalValue.toDouble(),
      profitAfterHolding: totalReturn.toDouble(),
      breakEvenMonths: breakEven,
      riskScore: risk,
    );
  }

  static double _riskScore({
    required double vacancy,
    required double interest,
    required double appreciation,
    required double netYield,
  }) {
    var score = 50.0;
    score += (vacancy - 8) * 2;
    score += (interest - 5) * 3;
    score -= (appreciation - 5) * 2;
    score -= (netYield - 5) * 3;
    return score.clamp(0, 100);
  }
}
