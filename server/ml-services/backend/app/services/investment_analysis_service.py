"""
Investment Analysis Service
Real estate investment calculations, ROI analysis, and risk assessment
"""

import numpy as np
import pandas as pd
from typing import Dict, List, Any, Optional
from datetime import datetime, timedelta
import math

class InvestmentAnalyzer:
    def __init__(self):
        self.market_data = {}
        self.risk_factors = {
            'market_volatility': 0.15,
            'interest_rate_risk': 0.20,
            'location_risk': 0.25,
            'property_condition_risk': 0.20,
            'liquidity_risk': 0.20
        }
        
    def initialize_market_data(self):
        """Initialize with realistic market data"""
        self.market_data = {
            'national_appreciation_rate': 0.032,  # 3.2% annually
            'inflation_rate': 0.025,  # 2.5% annually
            'average_cap_rate': 0.075,  # 7.5% cap rate
            'average_vacancy_rate': 0.05,  # 5% vacancy
            'average_maintenance_rate': 0.01,  # 1% of property value annually
            'average_property_tax_rate': 0.012,  # 1.2% of property value annually
            'average_insurance_rate': 0.003,  # 0.3% of property value annually
            'mortgage_rates': {
                '30_year_fixed': 0.068,
                '15_year_fixed': 0.062,
                '5_1_arm': 0.065
            }
        }
        return True
    
    def calculate_mortgage_payment(self, principal: float, annual_rate: float, years: int) -> float:
        """Calculate monthly mortgage payment"""
        monthly_rate = annual_rate / 12
        num_payments = years * 12
        
        if monthly_rate == 0:
            return principal / num_payments
        
        payment = principal * (monthly_rate * (1 + monthly_rate) ** num_payments) / \
                  ((1 + monthly_rate) ** num_payments - 1)
        
        return payment
    
    def analyze_cash_flow(self, property_data: Dict) -> Dict[str, Any]:
        """Detailed cash flow analysis"""
        purchase_price = property_data['purchase_price']
        monthly_rent = property_data['monthly_rent']
        down_payment_percent = property_data.get('down_payment_percent', 0.20)
        
        # Mortgage calculation
        down_payment = purchase_price * down_payment_percent
        loan_amount = purchase_price - down_payment
        mortgage_rate = property_data.get('mortgage_rate', self.market_data['mortgage_rates']['30_year_fixed'])
        mortgage_term = property_data.get('mortgage_term', 30)
        
        monthly_mortgage = self.calculate_mortgage_payment(loan_amount, mortgage_rate, mortgage_term)
        
        # Monthly expenses
        property_tax_monthly = purchase_price * self.market_data['average_property_tax_rate'] / 12
        insurance_monthly = purchase_price * self.market_data['average_insurance_rate'] / 12
        maintenance_monthly = purchase_price * self.market_data['average_maintenance_rate'] / 12
        vacancy_monthly = monthly_rent * property_data.get('vacancy_rate', self.market_data['average_vacancy_rate'])
        
        # Additional expenses
        hoa_fees = property_data.get('hoa_fees', 0)
        property_management = monthly_rent * property_data.get('management_rate', 0.08) if property_data.get('use_management', True) else 0
        utilities = property_data.get('utilities', 0)
        
        # Total monthly expenses
        total_monthly_expenses = (
            monthly_mortgage + property_tax_monthly + insurance_monthly + 
            maintenance_monthly + vacancy_monthly + hoa_fees + 
            property_management + utilities
        )
        
        # Monthly cash flow
        monthly_cash_flow = monthly_rent - total_monthly_expenses
        
        # Annual calculations
        annual_income = monthly_rent * 12 * (1 - property_data.get('vacancy_rate', self.market_data['average_vacancy_rate']))
        annual_expenses = total_monthly_expenses * 12
        annual_cash_flow = annual_income - annual_expenses
        
        return {
            'income': {
                'monthly_rent': monthly_rent,
                'annual_income': annual_income,
                'effective_monthly_income': monthly_rent * (1 - property_data.get('vacancy_rate', self.market_data['average_vacancy_rate']))
            },
            'expenses': {
                'monthly_mortgage': monthly_mortgage,
                'property_tax_monthly': property_tax_monthly,
                'insurance_monthly': insurance_monthly,
                'maintenance_monthly': maintenance_monthly,
                'vacancy_monthly': vacancy_monthly,
                'hoa_fees_monthly': hoa_fees,
                'management_monthly': property_management,
                'utilities_monthly': utilities,
                'total_monthly_expenses': total_monthly_expenses,
                'annual_expenses': annual_expenses
            },
            'cash_flow': {
                'monthly_cash_flow': monthly_cash_flow,
                'annual_cash_flow': annual_cash_flow,
                'monthly_cash_flow_per_sqft': monthly_cash_flow / property_data.get('area_sqft', 1000),
                'monthly_cash_flow_positive': monthly_cash_flow > 0
            },
            'mortgage': {
                'loan_amount': loan_amount,
                'down_payment': down_payment,
                'monthly_payment': monthly_mortgage,
                'total_interest_paid': (monthly_mortgage * mortgage_term * 12) - loan_amount
            }
        }
    
    def calculate_roi_metrics(self, property_data: Dict, cash_flow_data: Dict) -> Dict[str, Any]:
        """Calculate various ROI metrics"""
        purchase_price = property_data['purchase_price']
        annual_cash_flow = cash_flow_data['cash_flow']['annual_cash_flow']
        down_payment = purchase_price * property_data.get('down_payment_percent', 0.20)
        
        # Cash on Cash Return
        cash_on_cash_return = (annual_cash_flow / down_payment) * 100 if down_payment > 0 else 0
        
        # Cap Rate (Net Operating Income / Property Value)
        noi = cash_flow_data['income']['annual_income'] - (
            cash_flow_data['expenses']['annual_expenses'] - cash_flow_data['expenses']['monthly_mortgage'] * 12
        )
        cap_rate = (noi / purchase_price) * 100
        
        # Gross Rent Multiplier
        gross_rent_multiplier = purchase_price / (cash_flow_data['income']['annual_income'] / 12) if cash_flow_data['income']['annual_income'] > 0 else 0
        
        # Debt Service Coverage Ratio
        annual_debt_service = cash_flow_data['expenses']['monthly_mortgage'] * 12
        dscr = noi / annual_debt_service if annual_debt_service > 0 else 0
        
        # Total ROI (including appreciation)
        appreciation_rate = property_data.get('appreciation_rate', self.market_data['national_appreciation_rate'])
        annual_appreciation = purchase_price * appreciation_rate
        total_annual_return = annual_cash_flow + annual_appreciation
        total_roi = (total_annual_return / down_payment) * 100 if down_payment > 0 else 0
        
        return {
            'cash_on_cash_return': cash_on_cash_return,
            'cap_rate': cap_rate,
            'gross_rent_multiplier': gross_rent_multiplier,
            'debt_service_coverage_ratio': dscr,
            'total_roi': total_roi,
            'breakdown': {
                'cash_flow_return': (annual_cash_flow / down_payment) * 100 if down_payment > 0 else 0,
                'appreciation_return': (annual_appreciation / down_payment) * 100 if down_payment > 0 else 0,
                'total_return': total_roi
            }
        }
    
    def calculate_investment_timeline(self, property_data: Dict, cash_flow_data: Dict, roi_data: Dict) -> Dict[str, Any]:
        """Calculate investment timeline and projections"""
        purchase_price = property_data['purchase_price']
        annual_cash_flow = cash_flow_data['cash_flow']['annual_cash_flow']
        appreciation_rate = property_data.get('appreciation_rate', self.market_data['national_appreciation_rate'])
        
        # 5-year projection
        projections = []
        cumulative_cash_flow = 0
        current_value = purchase_price
        
        for year in range(1, 11):  # 10-year projection
            cumulative_cash_flow += annual_cash_flow
            current_value *= (1 + appreciation_rate)
            total_return = cumulative_cash_flow + (current_value - purchase_price)
            
            projections.append({
                'year': year,
                'property_value': current_value,
                'cumulative_cash_flow': cumulative_cash_flow,
                'total_return': total_return,
                'annual_return': total_return / year if year > 0 else 0
            })
        
        # Break-even analysis
        down_payment = purchase_price * property_data.get('down_payment_percent', 0.20)
        break_even_months = down_payment / max(0.01, annual_cash_flow / 12) if annual_cash_flow > 0 else 999
        break_even_years = break_even_months / 12
        
        return {
            'break_even': {
                'months': int(break_even_months),
                'years': round(break_even_years, 1),
                'break_even_positive': annual_cash_flow > 0
            },
            'projections': projections,
            'summary': {
                'value_5_years': projections[4]['property_value'] if len(projections) > 4 else purchase_price,
                'value_10_years': projections[9]['property_value'] if len(projections) > 9 else purchase_price,
                'total_cash_flow_5_years': projections[4]['cumulative_cash_flow'] if len(projections) > 4 else 0,
                'total_return_5_years': projections[4]['total_return'] if len(projections) > 4 else 0
            }
        }
    
    def assess_risk(self, property_data: Dict, cash_flow_data: Dict, roi_data: Dict) -> Dict[str, Any]:
        """Comprehensive risk assessment"""
        risk_score = 0
        risk_factors = []
        
        # Cash flow risk
        if cash_flow_data['cash_flow']['monthly_cash_flow'] < 0:
            risk_score += 30
            risk_factors.append("Negative monthly cash flow")
        elif cash_flow_data['cash_flow']['monthly_cash_flow'] < 100:
            risk_score += 15
            risk_factors.append("Low monthly cash flow buffer")
        
        # Debt service risk
        dscr = roi_data['debt_service_coverage_ratio']
        if dscr < 1.0:
            risk_score += 25
            risk_factors.append("Debt service coverage ratio below 1.0")
        elif dscr < 1.2:
            risk_score += 10
            risk_factors.append("Low debt service coverage")
        
        # Market risk
        vacancy_rate = property_data.get('vacancy_rate', self.market_data['average_vacancy_rate'])
        if vacancy_rate > 0.10:
            risk_score += 20
            risk_factors.append("High vacancy rate")
        elif vacancy_rate > 0.08:
            risk_score += 10
            risk_factors.append("Elevated vacancy rate")
        
        # Location risk (mock - would use real data)
        location_risk = np.random.uniform(0, 15)  # Placeholder
        risk_score += location_risk
        
        # Property condition risk
        age_risk = min(20, (2024 - property_data.get('year_built', 2020)) * 0.5)
        risk_score += age_risk
        if age_risk > 10:
            risk_factors.append("Older property - higher maintenance risk")
        
        # Determine risk grade
        if risk_score < 30:
            risk_grade = "A (Low Risk)"
            risk_description = "Conservative investment with stable returns"
        elif risk_score < 50:
            risk_grade = "B (Moderate Risk)"
            risk_description = "Balanced risk-reward profile"
        elif risk_score < 70:
            risk_grade = "C (High Risk)"
            risk_description = "Higher risk, requires careful management"
        else:
            risk_grade = "D (Very High Risk)"
            risk_description = "Speculative investment with significant risks"
        
        return {
            'risk_score': min(100, risk_score),
            'risk_grade': risk_grade,
            'risk_description': risk_description,
            'risk_factors': risk_factors,
            'mitigation_strategies': self._generate_risk_mitigation_strategies(risk_factors)
        }
    
    def _generate_risk_mitigation_strategies(self, risk_factors: List[str]) -> List[str]:
        """Generate risk mitigation strategies"""
        strategies = []
        
        if "Negative monthly cash flow" in risk_factors:
            strategies.append("Increase rent or reduce expenses")
            strategies.append("Consider larger down payment")
        
        if "High vacancy rate" in risk_factors:
            strategies.append("Improve property marketing")
            strategies.append("Offer competitive rental terms")
        
        if "Older property" in risk_factors:
            strategies.append("Budget for higher maintenance costs")
            strategies.append("Consider renovation to increase value")
        
        if "Low debt service coverage" in risk_factors:
            strategies.append("Refinance to lower interest rates")
            strategies.append("Increase down payment")
        
        return strategies
    
    def comprehensive_analysis(self, property_data: Dict) -> Dict[str, Any]:
        """Complete investment analysis"""
        if not self.market_data:
            self.initialize_market_data()
        
        # Step 1: Cash flow analysis
        cash_flow = self.analyze_cash_flow(property_data)
        
        # Step 2: ROI metrics
        roi_metrics = self.calculate_roi_metrics(property_data, cash_flow)
        
        # Step 3: Timeline projections
        timeline = self.calculate_investment_timeline(property_data, cash_flow, roi_metrics)
        
        # Step 4: Risk assessment
        risk_assessment = self.assess_risk(property_data, cash_flow, roi_metrics)
        
        # Step 5: Investment grade
        investment_grade = self._calculate_investment_grade(roi_metrics, risk_assessment)
        
        # Step 6: Recommendations
        recommendations = self._generate_recommendations(property_data, cash_flow, roi_metrics, risk_assessment)
        
        return {
            'property_summary': {
                'address': property_data.get('address', 'Unknown'),
                'purchase_price': property_data['purchase_price'],
                'monthly_rent': property_data['monthly_rent'],
                'area_sqft': property_data.get('area_sqft', 0)
            },
            'cash_flow_analysis': cash_flow,
            'roi_metrics': roi_metrics,
            'investment_timeline': timeline,
            'risk_assessment': risk_assessment,
            'investment_grade': investment_grade,
            'recommendations': recommendations,
            'market_comparison': self._compare_to_market_averages(roi_metrics)
        }
    
    def _calculate_investment_grade(self, roi_data: Dict, risk_data: Dict) -> Dict[str, Any]:
        """Calculate overall investment grade"""
        cash_on_cash = roi_data['cash_on_cash_return']
        cap_rate = roi_data['cap_rate']
        risk_score = risk_data['risk_score']
        
        # Scoring system
        score = 0
        
        # Cash on cash return (40% weight)
        if cash_on_cash > 12:
            score += 40
        elif cash_on_cash > 8:
            score += 30
        elif cash_on_cash > 5:
            score += 20
        elif cash_on_cash > 0:
            score += 10
        
        # Cap rate (30% weight)
        if cap_rate > 10:
            score += 30
        elif cap_rate > 8:
            score += 25
        elif cap_rate > 6:
            score += 20
        elif cap_rate > 4:
            score += 15
        elif cap_rate > 0:
            score += 10
        
        # Risk (30% weight, inverted)
        risk_score_normalized = max(0, 30 - (risk_score * 0.3))
        score += risk_score_normalized
        
        # Convert to letter grade
        if score >= 85:
            grade = "A+"
            description = "Exceptional investment opportunity"
        elif score >= 75:
            grade = "A"
            description = "Excellent investment with strong returns"
        elif score >= 65:
            grade = "B+"
            description = "Good investment with solid fundamentals"
        elif score >= 55:
            grade = "B"
            description = "Decent investment, monitor closely"
        elif score >= 45:
            grade = "C+"
            description = "Average investment, consider alternatives"
        elif score >= 35:
            grade = "C"
            description = "Below average investment"
        else:
            grade = "D"
            description = "Poor investment, avoid"
        
        return {
            'grade': grade,
            'score': score,
            'description': description,
            'components': {
                'cash_on_cash_score': min(40, max(0, cash_on_cash * 3.33)),
                'cap_rate_score': min(30, max(0, cap_rate * 3)),
                'risk_score': risk_score_normalized
            }
        }
    
    def _generate_recommendations(self, property_data: Dict, cash_flow: Dict, roi: Dict, risk: Dict) -> List[str]:
        """Generate personalized recommendations"""
        recommendations = []
        
        # Cash flow recommendations
        if cash_flow['cash_flow']['monthly_cash_flow'] < 0:
            recommendations.append("Increase rent by at least $" + str(abs(int(cash_flow['cash_flow']['monthly_cash_flow']))))
            recommendations.append("Reduce expenses through better management")
        
        # ROI recommendations
        if roi['cash_on_cash_return'] < 8:
            recommendations.append("Consider larger down payment to improve cash-on-cash return")
        
        if roi['cap_rate'] < 6:
            recommendations.append("Look for properties with higher cap rates in this market")
        
        # Risk recommendations
        if risk['risk_score'] > 50:
            recommendations.append("Build larger emergency fund for this investment")
            recommendations.append("Consider property insurance for additional protection")
        
        # General recommendations
        recommendations.append("Review comparable properties quarterly")
        recommendations.append("Plan for 3-5% annual maintenance budget")
        
        return recommendations
    
    def _compare_to_market_averages(self, roi_data: Dict) -> Dict[str, Any]:
        """Compare investment metrics to market averages"""
        return {
            'cash_on_cash_vs_market': {
                'property': roi_data['cash_on_cash_return'],
                'market_average': 8.5,
                'performance': 'Above' if roi_data['cash_on_cash_return'] > 8.5 else 'Below'
            },
            'cap_rate_vs_market': {
                'property': roi_data['cap_rate'],
                'market_average': self.market_data['average_cap_rate'] * 100,
                'performance': 'Above' if roi_data['cap_rate'] > (self.market_data['average_cap_rate'] * 100) else 'Below'
            }
        }

# Initialize global analyzer
investment_analyzer = InvestmentAnalyzer()

# Initialize on startup
def initialize_investment_analyzer():
    """Initialize the investment analyzer"""
    try:
        success = investment_analyzer.initialize_market_data()
        if success:
            print("✅ Investment analyzer initialized with market data")
        return success
    except Exception as e:
        print(f"❌ Failed to initialize investment analyzer: {e}")
        return False
