"""
Location Intelligence Service
Analyzes neighborhoods, schools, amenities, and investment potential
"""

import numpy as np
import pandas as pd
from typing import Dict, List, Any, Tuple
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
import math

class LocationAnalyzer:
    def __init__(self):
        self.is_initialized = False
        self.neighborhood_data = {}
        self.amenity_weights = {
            'schools': 0.25,
            'transit': 0.20,
            'shopping': 0.15,
            'parks': 0.10,
            'restaurants': 0.10,
            'healthcare': 0.10,
            'safety': 0.10
        }
        
    def initialize_mock_data(self):
        """Initialize with realistic mock location data"""
        neighborhoods = [
            {
                'name': 'Downtown Core',
                'lat': 40.7589,
                'lng': -73.9851,
                'walk_score': 98,
                'transit_score': 100,
                'school_district_rating': 6.5,
                'crime_rate': 45,
                'median_income': 95000,
                'population_density': 28000,
                'amenities': {
                    'schools': 15,
                    'transit_stations': 12,
                    'shopping_centers': 25,
                    'parks': 8,
                    'restaurants': 150,
                    'hospitals': 5,
                    'grocery_stores': 12
                },
                'property_types': {'condo': 0.8, 'apartment': 0.15, 'house': 0.05}
            },
            {
                'name': 'Riverside District',
                'lat': 40.7489,
                'lng': -74.0031,
                'walk_score': 92,
                'transit_score': 85,
                'school_district_rating': 8.2,
                'crime_rate': 15,
                'median_income': 145000,
                'population_density': 12000,
                'amenities': {
                    'schools': 8,
                    'transit_stations': 6,
                    'shopping_centers': 15,
                    'parks': 12,
                    'restaurants': 80,
                    'hospitals': 3,
                    'grocery_stores': 8
                },
                'property_types': {'condo': 0.6, 'apartment': 0.2, 'house': 0.2}
            },
            {
                'name': 'University Quarter',
                'lat': 40.7289,
                'lng': -73.9951,
                'walk_score': 88,
                'transit_score': 78,
                'school_district_rating': 7.8,
                'crime_rate': 25,
                'median_income': 75000,
                'population_density': 18000,
                'amenities': {
                    'schools': 12,
                    'transit_stations': 8,
                    'shopping_centers': 20,
                    'parks': 6,
                    'restaurants': 95,
                    'hospitals': 2,
                    'grocery_stores': 10
                },
                'property_types': {'apartment': 0.7, 'condo': 0.25, 'house': 0.05}
            },
            {
                'name': 'Tech Hub District',
                'lat': 40.7389,
                'lng': -74.0081,
                'walk_score': 95,
                'transit_score': 92,
                'school_district_rating': 9.1,
                'crime_rate': 12,
                'median_income': 165000,
                'population_density': 15000,
                'amenities': {
                    'schools': 10,
                    'transit_stations': 10,
                    'shopping_centers': 18,
                    'parks': 10,
                    'restaurants': 110,
                    'hospitals': 4,
                    'grocery_stores': 9
                },
                'property_types': {'condo': 0.55, 'apartment': 0.35, 'house': 0.1}
            },
            {
                'name': 'Historic District',
                'lat': 40.7189,
                'lng': -74.0051,
                'walk_score': 85,
                'transit_score': 72,
                'school_district_rating': 8.5,
                'crime_rate': 18,
                'median_income': 125000,
                'population_density': 10000,
                'amenities': {
                    'schools': 6,
                    'transit_stations': 4,
                    'shopping_centers': 12,
                    'parks': 15,
                    'restaurants': 60,
                    'hospitals': 2,
                    'grocery_stores': 6
                },
                'property_types': {'house': 0.6, 'condo': 0.3, 'apartment': 0.1}
            }
        ]
        
        for hood in neighborhoods:
            self.neighborhood_data[hood['name']] = hood
            
        self.is_initialized = True
        return True
    
    def calculate_distance(self, lat1: float, lng1: float, lat2: float, lng2: float) -> float:
        """Calculate distance between two points in miles"""
        R = 3959  # Earth's radius in miles
        
        lat1_rad = math.radians(lat1)
        lat2_rad = math.radians(lat2)
        delta_lat = math.radians(lat2 - lat1)
        delta_lng = math.radians(lng2 - lng1)
        
        a = (math.sin(delta_lat/2)**2 + 
             math.cos(lat1_rad) * math.cos(lat2_rad) * math.sin(delta_lng/2)**2)
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
        
        return R * c
    
    def find_nearest_neighborhoods(self, lat: float, lng: float, radius_miles: float = 2.0) -> List[Dict]:
        """Find neighborhoods within specified radius"""
        nearby = []
        
        for name, hood in self.neighborhood_data.items():
            distance = self.calculate_distance(lat, lng, hood['lat'], hood['lng'])
            if distance <= radius_miles:
                hood_copy = hood.copy()
                hood_copy['distance'] = distance
                nearby.append(hood_copy)
        
        return sorted(nearby, key=lambda x: x['distance'])
    
    def calculate_livability_score(self, neighborhood: Dict) -> float:
        """Calculate overall livability score (0-100)"""
        scores = {
            'walkability': neighborhood['walk_score'] * 0.3,
            'transit': neighborhood['transit_score'] * 0.2,
            'schools': neighborhood['school_district_rating'] * 10 * 0.25,
            'safety': (100 - neighborhood['crime_rate']) * 0.15,
            'amenities': min(100, sum(neighborhood['amenities'].values()) * 2) * 0.1
        }
        
        return min(100, sum(scores.values()))
    
    def calculate_investment_potential(self, neighborhood: Dict) -> float:
        """Calculate investment potential score (0-100)"""
        # Higher income, good schools, low crime = good investment
        income_score = min(100, neighborhood['median_income'] / 2000)
        school_score = neighborhood['school_district_rating'] * 10
        safety_score = 100 - neighborhood['crime_rate']
        growth_score = neighborhood['population_density'] / 500  # Density as growth indicator
        
        investment_score = (income_score * 0.4 + school_score * 0.3 + 
                          safety_score * 0.2 + growth_score * 0.1)
        
        return min(100, investment_score)
    
    def calculate_family_friendly_score(self, neighborhood: Dict) -> float:
        """Calculate family-friendly score (0-100)"""
        family_factors = {
            'schools': neighborhood['school_district_rating'] * 10,
            'safety': 100 - neighborhood['crime_rate'],
            'parks': min(100, neighborhood['amenities']['parks'] * 8),
            'space': max(0, 100 - neighborhood['population_density'] / 500),
            'healthcare': neighborhood['amenities']['hospitals'] * 15
        }
        
        return min(100, sum(family_factors.values()) / 5)
    
    def analyze_location(self, lat: float, lng: float, property_type: str = 'house') -> Dict[str, Any]:
        """Comprehensive location analysis"""
        if not self.is_initialized:
            self.initialize_mock_data()
        
        # Find nearby neighborhoods
        nearby_neighborhoods = self.find_nearest_neighborhoods(lat, lng)
        
        if not nearby_neighborhoods:
            return {
                'error': 'No neighborhoods found within 2 miles',
                'location': {'lat': lat, 'lng': lng}
            }
        
        # Weighted average based on distance
        total_weight = 0
        weighted_scores = {
            'livability': 0,
            'investment': 0,
            'family_friendly': 0,
            'commute': 0
        }
        
        for hood in nearby_neighborhoods:
            weight = 1 / (1 + hood['distance'])  # Closer = higher weight
            total_weight += weight
            
            weighted_scores['livability'] += self.calculate_livability_score(hood) * weight
            weighted_scores['investment'] += self.calculate_investment_potential(hood) * weight
            weighted_scores['family_friendly'] += self.calculate_family_friendly_score(hood) * weight
            weighted_scores['commute'] += hood['transit_score'] * weight
        
        # Normalize by total weight
        for key in weighted_scores:
            weighted_scores[key] /= total_weight
        
        # Overall score
        overall_score = sum(weighted_scores.values()) / len(weighted_scores)
        
        # Find best matching neighborhood
        best_neighborhood = nearby_neighborhoods[0]
        
        # Property type suitability
        suitability_scores = {}
        for hood in nearby_neighborhoods[:3]:  # Top 3 neighborhoods
            property_type_suitability = hood['property_types'].get(property_type, 0) * 100
            suitability_scores[hood['name']] = property_type_suitability
        
        avg_suitability = sum(suitability_scores.values()) / len(suitability_scores) if suitability_scores else 50
        
        return {
            'location': {
                'lat': lat,
                'lng': lng,
                'nearest_neighborhood': best_neighborhood['name'],
                'distance_to_center': best_neighborhood['distance']
            },
            'scores': {
                'overall': min(100, overall_score),
                'livability': weighted_scores['livability'],
                'investment_potential': weighted_scores['investment'],
                'family_friendly': weighted_scores['family_friendly'],
                'commute_score': weighted_scores['commute']
            },
            'nearby_neighborhoods': nearby_neighborhoods[:3],
            'property_analysis': {
                'suitability_score': avg_suitability,
                'recommended_property_types': [
                    pt for pt, score in best_neighborhood['property_types'].items() 
                    if score > 0.2
                ]
            },
            'amenities_summary': {
                'total_amenities': sum(best_neighborhood['amenities'].values()),
                'key_highlights': [
                    f"{best_neighborhood['amenities']['restaurants']} restaurants",
                    f"{best_neighborhood['amenities']['parks']} parks",
                    f"{best_neighborhood['amenities']['schools']} schools"
                ]
            },
            'market_insights': {
                'median_income': best_neighborhood['median_income'],
                'population_density': best_neighborhood['population_density'],
                'school_rating': best_neighborhood['school_district_rating'],
                'crime_index': best_neighborhood['crime_rate']
            }
        }
    
    def compare_locations(self, locations: List[Dict]) -> Dict[str, Any]:
        """Compare multiple locations"""
        comparisons = []
        
        for loc in locations:
            analysis = self.analyze_location(loc['lat'], loc['lng'], loc.get('property_type', 'house'))
            analysis['name'] = loc.get('name', f"Location {loc['lat']}, {loc['lng']}")
            comparisons.append(analysis)
        
        # Sort by overall score
        comparisons.sort(key=lambda x: x['scores']['overall'], reverse=True)
        
        # Create ranking
        rankings = []
        for i, comp in enumerate(comparisons):
            rankings.append({
                'rank': i + 1,
                'name': comp['name'],
                'overall_score': comp['scores']['overall'],
                'livability': comp['scores']['livability'],
                'investment': comp['scores']['investment_potential'],
                'family_friendly': comp['scores']['family_friendly'],
                'strengths': self._identify_strengths(comp['scores']),
                'weaknesses': self._identify_weaknesses(comp['scores'])
            })
        
        return {
            'comparisons': comparisons,
            'rankings': rankings,
            'best_location': comparisons[0]['name'] if comparisons else None,
            'recommendation': self._generate_recommendation(rankings[0]) if rankings else None
        }
    
    def _identify_strengths(self, scores: Dict) -> List[str]:
        """Identify location strengths"""
        strengths = []
        if scores['livability'] > 80:
            strengths.append("Excellent livability")
        if scores['investment_potential'] > 80:
            strengths.append("High investment potential")
        if scores['family_friendly'] > 80:
            strengths.append("Very family-friendly")
        if scores['commute'] > 85:
            strengths.append("Great transit access")
        return strengths
    
    def _identify_weaknesses(self, scores: Dict) -> List[str]:
        """Identify location weaknesses"""
        weaknesses = []
        if scores['livability'] < 60:
            weaknesses.append("Limited livability")
        if scores['investment_potential'] < 60:
            weaknesses.append("Lower investment potential")
        if scores['family_friendly'] < 60:
            weaknesses.append("Not ideal for families")
        if scores['commute'] < 60:
            weaknesses.append("Poor transit access")
        return weaknesses
    
    def _generate_recommendation(self, ranking: Dict) -> str:
        """Generate personalized recommendation"""
        if ranking['overall'] > 85:
            return f"Excellent choice! {ranking['name']} scores highly across all metrics."
        elif ranking['overall'] > 70:
            return f"Good option! {ranking['name']} offers solid value with notable strengths."
        else:
            return f"Consider carefully. {ranking['name']} may have some limitations."

# Initialize global analyzer
location_analyzer = LocationAnalyzer()

# Initialize on startup
def initialize_location_analyzer():
    """Initialize the location analyzer"""
    try:
        success = location_analyzer.initialize_mock_data()
        if success:
            print("✅ Location analyzer initialized with 5 neighborhoods")
        return success
    except Exception as e:
        print(f"❌ Failed to initialize location analyzer: {e}")
        return False
