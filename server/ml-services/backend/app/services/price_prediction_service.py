"""
Real Estate Price Prediction Service
Uses ensemble ML models for accurate property valuation
"""

import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_absolute_error, r2_score
import joblib
import os
from typing import Dict, List, Tuple, Any

class RealEstatePricePredictor:
    def __init__(self):
        self.models = {
            'rf': RandomForestRegressor(n_estimators=100, random_state=42),
            'gb': GradientBoostingRegressor(n_estimators=100, random_state=42)
        }
        self.scalers = {}
        self.encoders = {}
        self.feature_columns = []
        self.is_trained = False
        
    def prepare_features(self, data: List[Dict]) -> pd.DataFrame:
        """
        Prepare features for ML model
        """
        df = pd.DataFrame(data)
        
        # Handle missing values
        numeric_columns = df.select_dtypes(include=[np.number]).columns
        df[numeric_columns] = df[numeric_columns].fillna(df[numeric_columns].median())
        
        categorical_columns = df.select_dtypes(include=['object']).columns
        for col in categorical_columns:
            df[col] = df[col].fillna('Unknown')
            
        # Encode categorical variables
        for col in ['property_type', 'neighborhood', 'city']:
            if col in df.columns:
                if col not in self.encoders:
                    self.encoders[col] = LabelEncoder()
                    df[col + '_encoded'] = self.encoders[col].fit_transform(df[col])
                else:
                    df[col + '_encoded'] = self.encoders[col].transform(df[col])
        
        # Feature engineering
        df['age'] = 2024 - df['year_built']
        df['age'] = df['age'].clip(0, 100)  # Cap at 100 years
        
        df['price_per_sqft_base'] = df['price'] / df['area_sqft']
        
        # Room ratios
        df['bath_per_bed'] = df['bathrooms'] / df['bedrooms'].replace(0, 1)
        df['area_per_bed'] = df['area_sqft'] / df['bedrooms'].replace(0, 1)
        
        # Location features
        if 'latitude' in df.columns and 'longitude' in df.columns:
            df['distance_from_center'] = np.sqrt(
                (df['latitude'] - 40.7128)**2 + (df['longitude'] - -74.0060)**2
            )
        
        # Select features for model
        feature_cols = [
            'bedrooms', 'bathrooms', 'area_sqft', 'age',
            'property_type_encoded', 'neighborhood_encoded', 'city_encoded',
            'bath_per_bed', 'area_per_bed', 'school_rating', 'walk_score',
            'transit_score', 'crime_rate', 'distance_from_center'
        ]
        
        # Filter available columns
        self.feature_columns = [col for col in feature_cols if col in df.columns]
        
        return df[self.feature_columns]
    
    def train(self, training_data: List[Dict]) -> Dict[str, float]:
        """
        Train the price prediction models
        """
        # Prepare data
        df = pd.DataFrame(training_data)
        X = self.prepare_features(training_data)
        y = df['price']
        
        # Split data
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=0.2, random_state=42
        )
        
        # Scale features
        self.scalers['main'] = StandardScaler()
        X_train_scaled = self.scalers['main'].fit_transform(X_train)
        X_test_scaled = self.scalers['main'].transform(X_test)
        
        # Train models
        results = {}
        for name, model in self.models.items():
            model.fit(X_train_scaled, y_train)
            y_pred = model.predict(X_test_scaled)
            
            mae = mean_absolute_error(y_test, y_pred)
            r2 = r2_score(y_test, y_pred)
            
            results[name] = {
                'mae': mae,
                'r2': r2,
                'mape': np.mean(np.abs((y_test - y_pred) / y_test)) * 100
            }
        
        self.is_trained = True
        return results
    
    def predict(self, property_data: Dict) -> Dict[str, Any]:
        """
        Predict price for a single property
        """
        if not self.is_trained:
            raise ValueError("Model must be trained before making predictions")
        
        # Prepare features
        df = self.prepare_features([property_data])
        
        # Scale features
        X_scaled = self.scalers['main'].transform(df)
        
        # Make predictions with ensemble
        predictions = {}
        for name, model in self.models.items():
            pred = model.predict(X_scaled)[0]
            predictions[name] = pred
        
        # Ensemble prediction (average)
        ensemble_pred = np.mean(list(predictions.values()))
        
        # Calculate confidence interval
        std_pred = np.std(list(predictions.values()))
        confidence_interval = [
            ensemble_pred - 1.96 * std_pred,
            ensemble_pred + 1.96 * std_pred
        ]
        
        # Feature importance (from random forest)
        feature_importance = dict(zip(
            self.feature_columns,
            self.models['rf'].feature_importances_
        ))
        
        return {
            'predicted_price': ensemble_pred,
            'confidence_interval': confidence_interval,
            'model_predictions': predictions,
            'feature_importance': feature_importance,
            'price_per_sqft': ensemble_pred / property_data['area_sqft']
        }
    
    def batch_predict(self, properties: List[Dict]) -> List[Dict]:
        """
        Predict prices for multiple properties
        """
        results = []
        for prop in properties:
            try:
                result = self.predict(prop)
                result['property_id'] = prop.get('id', 'unknown')
                results.append(result)
            except Exception as e:
                results.append({
                    'property_id': prop.get('id', 'unknown'),
                    'error': str(e)
                })
        return results
    
    def save_model(self, path: str):
        """
        Save trained models
        """
        model_data = {
            'models': self.models,
            'scalers': self.scalers,
            'encoders': self.encoders,
            'feature_columns': self.feature_columns,
            'is_trained': self.is_trained
        }
        joblib.dump(model_data, path)
    
    def load_model(self, path: str):
        """
        Load trained models
        """
        model_data = joblib.load(path)
        self.models = model_data['models']
        self.scalers = model_data['scalers']
        self.encoders = model_data['encoders']
        self.feature_columns = model_data['feature_columns']
        self.is_trained = model_data['is_trained']

# Mock training data generator
def generate_mock_training_data(n_samples: int = 1000) -> List[Dict]:
    """
    Generate realistic mock training data for testing
    """
    np.random.seed(42)
    
    data = []
    property_types = ['apartment', 'house', 'condo', 'townhouse']
    neighborhoods = ['downtown', 'suburbs', 'waterfront', 'historic', 'university']
    cities = ['new_york', 'los_angeles', 'chicago', 'houston', 'phoenix']
    
    for i in range(n_samples):
        # Base price calculation
        base_area = np.random.uniform(500, 3000)
        base_price_per_sqft = np.random.uniform(150, 500)
        bedrooms = np.random.randint(1, 6)
        bathrooms = np.random.randint(1, 4)
        year_built = np.random.randint(1950, 2023)
        
        # Location adjustments
        neighborhood_factor = np.random.uniform(0.8, 2.5)
        school_rating = np.random.uniform(3, 10)
        walk_score = np.random.uniform(20, 100)
        crime_rate = np.random.uniform(0, 100)
        
        # Calculate final price
        price = (base_area * base_price_per_sqft * neighborhood_factor *
                (1 + (school_rating - 5) * 0.05) *
                (1 + (walk_score - 60) * 0.002) *
                (1 - crime_rate * 0.001))
        
        # Add some noise
        price += np.random.normal(0, price * 0.1)
        
        data.append({
            'id': f'prop_{i}',
            'price': max(50000, price),
            'area_sqft': base_area,
            'bedrooms': bedrooms,
            'bathrooms': bathrooms,
            'year_built': year_built,
            'property_type': np.random.choice(property_types),
            'neighborhood': np.random.choice(neighborhoods),
            'city': np.random.choice(cities),
            'latitude': 40.7128 + np.random.uniform(-0.5, 0.5),
            'longitude': -74.0060 + np.random.uniform(-0.5, 0.5),
            'school_rating': school_rating,
            'walk_score': walk_score,
            'transit_score': walk_score * np.random.uniform(0.8, 1.2),
            'crime_rate': crime_rate
        })
    
    return data

# Initialize global predictor
price_predictor = RealEstatePricePredictor()

# Train with mock data on startup
def initialize_price_predictor():
    """Initialize the price predictor with mock data"""
    try:
        training_data = generate_mock_training_data(1000)
        results = price_predictor.train(training_data)
        print(f"✅ Price predictor trained successfully:")
        print(f"   Random Forest MAE: ${results['rf']['mae']:,.0f}")
        print(f"   Gradient Boosting MAE: ${results['gb']['mae']:,.0f}")
        print(f"   Random Forest R²: {results['rf']['r2']:.3f}")
        print(f"   Gradient Boosting R²: {results['gb']['r2']:.3f}")
        return True
    except Exception as e:
        print(f"❌ Failed to train price predictor: {e}")
        return False
