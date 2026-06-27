"""
Real Estate AI Dashboard - Internal Tool
Streamlit dashboard for ML model monitoring and analytics
"""

import streamlit as st
import pandas as pd
import numpy as np
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import requests
import json
from datetime import datetime, timedelta

# Page Configuration
st.set_page_config(
    page_title="Real Estate AI Dashboard",
    page_icon="🏠",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Custom CSS
st.markdown("""
<style>
    .main-header {
        font-size: 2.5rem;
        font-weight: bold;
        color: #1f77b4;
        text-align: center;
        margin-bottom: 2rem;
    }
    .metric-card {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 1.5rem;
        border-radius: 10px;
        color: white;
        margin: 0.5rem 0;
    }
    .success-metric {
        background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
    }
    .warning-metric {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    }
</style>
""", unsafe_allow_html=True)

# API Configuration
API_BASE = "http://localhost:8000/api/v1"

def fetch_api_data(endpoint: str) -> dict:
    """Fetch data from ML services API"""
    try:
        response = requests.get(f"{API_BASE}{endpoint}")
        if response.status_code == 200:
            return response.json()
        return {}
    except:
        return {}

def main():
    # Header
    st.markdown('<h1 class="main-header">🏠 Real Estate AI Dashboard</h1>', unsafe_allow_html=True)
    
    # Sidebar Navigation
    st.sidebar.title("📊 Navigation")
    page = st.sidebar.selectbox(
        "Select Page",
        [
            "🎯 Overview",
            "💰 Price Prediction",
            "🗺️ Location Intelligence", 
            "📈 Investment Analysis",
            "🤖 Model Performance",
            "📊 Market Trends"
        ]
    )
    
    if page == "🎯 Overview":
        show_overview()
    elif page == "💰 Price Prediction":
        show_price_prediction()
    elif page == "🗺️ Location Intelligence":
        show_location_intelligence()
    elif page == "📈 Investment Analysis":
        show_investment_analysis()
    elif page == "🤖 Model Performance":
        show_model_performance()
    elif page == "📊 Market Trends":
        show_market_trends()

def show_overview():
    """Dashboard Overview"""
    st.header("🎯 System Overview")
    
    # Key Metrics
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        st.markdown("""
        <div class="metric-card success-metric">
            <h3>1,247</h3>
            <p>Properties Analyzed</p>
        </div>
        """, unsafe_allow_html=True)
    
    with col2:
        st.markdown("""
        <div class="metric-card">
            <h3>94.2%</h3>
            <p>Prediction Accuracy</p>
        </div>
        """, unsafe_allow_html=True)
    
    with col3:
        st.markdown("""
        <div class="metric-card warning-metric">
            <h3>$2.3M</h3>
            <p>Total Value Analyzed</p>
        </div>
        """, unsafe_allow_html=True)
    
    with col4:
        st.markdown("""
        <div class="metric-card">
            <h3>8.5%</h3>
            <p>Avg ROI</p>
        </div>
        """, unsafe_allow_html=True)
    
    # Recent Activity
    st.subheader("📈 Recent Activity")
    
    # Mock data for demonstration
    activities = pd.DataFrame({
        'timestamp': pd.date_range(start='2024-01-01', periods=10, freq='H'),
        'activity_type': np.random.choice(['Price Prediction', 'Location Analysis', 'Investment Analysis'], 10),
        'property_value': np.random.uniform(100000, 1000000, 10),
        'confidence': np.random.uniform(0.8, 0.99, 10)
    })
    
    fig = px.line(activities, x='timestamp', y='property_value', 
                  color='activity_type', title="Property Analysis Activity")
    st.plotly_chart(fig, use_container_width=True)
    
    # Service Status
    st.subheader("🔧 Service Status")
    
    services = pd.DataFrame({
        'service': ['Price Prediction', 'Location Intelligence', 'Investment Analysis', 'Virtual Staging', 'Video Tours'],
        'status': ['✅ Healthy', '✅ Healthy', '✅ Healthy', '✅ Healthy', '⚠️ Slow'],
        'uptime': ['99.9%', '99.8%', '99.7%', '98.5%', '95.2%'],
        'last_update': ['2 min ago', '5 min ago', '1 min ago', '10 min ago', '15 min ago']
    })
    
    st.dataframe(services, use_container_width=True)

def show_price_prediction():
    """Price Prediction Analytics"""
    st.header("💰 Price Prediction Analytics")
    
    # Model Performance
    col1, col2 = st.columns(2)
    
    with col1:
        st.subheader("📊 Model Accuracy")
        
        # Mock accuracy data
        accuracy_data = pd.DataFrame({
            'model': ['Random Forest', 'Gradient Boosting', 'Neural Network'],
            'mae': [35000, 32000, 28000],
            'r2_score': [0.89, 0.91, 0.93]
        })
        
        fig = go.Figure()
        fig.add_trace(go.Bar(
            x=accuracy_data['model'],
            y=accuracy_data['mae'],
            name='MAE ($)',
            marker_color='lightblue'
        ))
        fig.update_layout(title="Model Comparison - Mean Absolute Error")
        st.plotly_chart(fig, use_container_width=True)
    
    with col2:
        st.subheader("🎯 Prediction Distribution")
        
        # Mock prediction data
        predictions = np.random.normal(500000, 150000, 1000)
        
        fig = px.histogram(x=predictions, nbins=50, 
                          title="Price Prediction Distribution")
        fig.update_xaxes(title_text="Predicted Price ($)")
        fig.update_yaxes(title_text="Frequency")
        st.plotly_chart(fig, use_container_width=True)
    
    # Feature Importance
    st.subheader("🔍 Feature Importance")
    
    features = pd.DataFrame({
        'feature': ['Area (sqft)', 'Bedrooms', 'Bathrooms', 'Location Score', 'Age', 'School Rating'],
        'importance': [0.35, 0.15, 0.12, 0.25, 0.08, 0.05]
    })
    
    fig = px.bar(features, x='importance', y='feature', orientation='h',
                 title="Feature Importance in Price Prediction")
    st.plotly_chart(fig, use_container_width=True)
    
    # Recent Predictions
    st.subheader("📋 Recent Predictions")
    
    recent_predictions = pd.DataFrame({
        'property_id': [f'PROP_{i:04d}' for i in range(1, 11)],
        'predicted_price': np.random.uniform(200000, 800000, 10),
        'confidence': np.random.uniform(0.85, 0.99, 10),
        'actual_price': np.random.uniform(200000, 800000, 10),
        'error': np.random.uniform(-50000, 50000, 10)
    })
    
    recent_predictions['accuracy'] = (1 - abs(recent_predictions['error']) / recent_predictions['actual_price']) * 100
    
    st.dataframe(
        recent_predictions[['property_id', 'predicted_price', 'actual_price', 'accuracy']],
        use_container_width=True
    )

def show_location_intelligence():
    """Location Intelligence Dashboard"""
    st.header("🗺️ Location Intelligence")
    
    # Location Scores
    col1, col2, col3 = st.columns(3)
    
    with col1:
        st.metric("🏆 Top Location", "Tech Hub District", "Score: 92/100")
    
    with col2:
        st.metric("👨‍👩‍👧‍👦 Most Family-Friendly", "Riverside District", "Score: 88/100")
    
    with col3:
        st.metric("💰 Best Investment", "University Quarter", "ROI: 12.5%")
    
    # Location Comparison
    st.subheader("📍 Neighborhood Comparison")
    
    neighborhoods = pd.DataFrame({
        'neighborhood': ['Downtown Core', 'Riverside District', 'University Quarter', 'Tech Hub District', 'Historic District'],
        'livability': [85, 92, 78, 88, 83],
        'investment_potential': [78, 85, 82, 91, 79],
        'family_friendly': [72, 88, 75, 80, 85],
        'commute_score': [95, 82, 78, 90, 75]
    })
    
    fig = make_subplots(rows=2, cols=2, subplot_titles=('Livability', 'Investment', 'Family Friendly', 'Commute'))
    
    fig.add_trace(go.Bar(x=neighborhoods['neighborhood'], y=neighborhoods['livability'], name='Livability'), row=1, col=1)
    fig.add_trace(go.Bar(x=neighborhoods['neighborhood'], y=neighborhoods['investment_potential'], name='Investment'), row=1, col=2)
    fig.add_trace(go.Bar(x=neighborhoods['neighborhood'], y=neighborhoods['family_friendly'], name='Family'), row=2, col=1)
    fig.add_trace(go.Bar(x=neighborhoods['neighborhood'], y=neighborhoods['commute_score'], name='Commute'), row=2, col=2)
    
    fig.update_layout(height=600, showlegend=False)
    st.plotly_chart(fig, use_container_width=True)
    
    # Amenities Analysis
    st.subheader("🏪 Amenities Analysis")
    
    amenities = pd.DataFrame({
        'amenity': ['Schools', 'Transit Stations', 'Shopping Centers', 'Parks', 'Restaurants', 'Hospitals'],
        'downtown': [15, 12, 25, 8, 150, 5],
        'riverside': [8, 6, 15, 12, 80, 3],
        'university': [12, 8, 20, 6, 95, 2],
        'tech_hub': [10, 10, 18, 10, 110, 4],
        'historic': [6, 4, 12, 15, 60, 2]
    })
    
    fig = px.bar(amenities.melt(id_vars=['amenity'], var_name='neighborhood', value_name='count'),
                 x='amenity', y='count', color='neighborhood', barmode='group',
                 title="Amenities Comparison by Neighborhood")
    st.plotly_chart(fig, use_container_width=True)

def show_investment_analysis():
    """Investment Analysis Dashboard"""
    st.header("📈 Investment Analysis")
    
    # Investment Metrics
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        st.metric("💵 Avg Cap Rate", "7.8%", "↑ 0.3%")
    
    with col2:
        st.metric("🔄 Avg Cash-on-Cash", "12.4%", "↑ 1.2%")
    
    with col3:
        st.metric("⏱️ Avg Break-even", "8.2 years", "↓ 0.5 years")
    
    with col4:
        st.metric("🎯 Success Rate", "87%", "↑ 3%")
    
    # ROI Distribution
    st.subheader("📊 ROI Distribution")
    
    roi_data = np.random.normal(12, 4, 500)
    
    fig = px.histogram(x=roi_data, nbins=30, title="Investment ROI Distribution")
    fig.add_vline(x=roi_data.mean(), line_dash="dash", line_color="red", 
                  annotation_text=f"Mean: {roi_data.mean():.1f}%")
    st.plotly_chart(fig, use_container_width=True)
    
    # Risk vs Return
    st.subheader("⚖️ Risk vs Return Analysis")
    
    investments = pd.DataFrame({
        'property_id': [f'INV_{i:04d}' for i in range(1, 21)],
        'roi': np.random.uniform(5, 25, 20),
        'risk_score': np.random.uniform(20, 80, 20),
        'grade': np.random.choice(['A+', 'A', 'B+', 'B', 'C'], 20)
    })
    
    fig = px.scatter(investments, x='risk_score', y='roi', color='grade', 
                     size='roi', hover_data=['property_id'],
                     title="Risk vs Return Scatter Plot")
    fig.add_hline(y=10, line_dash="dash", line_color="green", annotation_text="Target ROI")
    st.plotly_chart(fig, use_container_width=True)
    
    # Investment Timeline
    st.subheader("📅 Investment Timeline Projections")
    
    years = list(range(1, 11))
    projections = pd.DataFrame({
        'year': years * 3,
        'scenario': ['Conservative'] * 10 + ['Moderate'] * 10 + ['Optimistic'] * 10,
        'value': [
            # Conservative
            100000 * (1 + 0.03) ** i for i in years
        ] + [
            # Moderate
            100000 * (1 + 0.05) ** i for i in years
        ] + [
            # Optimistic
            100000 * (1 + 0.08) ** i for i in years
        ]
    })
    
    fig = px.line(projections, x='year', y='value', color='scenario',
                  title="10-Year Investment Projections")
    st.plotly_chart(fig, use_container_width=True)

def show_model_performance():
    """ML Model Performance Monitoring"""
    st.header("🤖 Model Performance")
    
    # Model Metrics
    col1, col2 = st.columns(2)
    
    with col1:
        st.subheader("📈 Prediction Accuracy Over Time")
        
        dates = pd.date_range(start='2024-01-01', periods=30, freq='D')
        accuracy = np.random.normal(0.92, 0.02, 30)
        
        fig = px.line(x=dates, y=accuracy, title="Model Accuracy Trend")
        fig.add_hline(y=0.90, line_dash="dash", line_color="red", annotation_text="Target: 90%")
        st.plotly_chart(fig, use_container_width=True)
    
    with col2:
        st.subheader("⚡ Model Performance Metrics")
        
        metrics = pd.DataFrame({
            'metric': ['Accuracy', 'Precision', 'Recall', 'F1-Score', 'MAE', 'RMSE'],
            'value': [0.94, 0.92, 0.89, 0.90, 28000, 45000],
            'target': [0.90, 0.85, 0.85, 0.85, 30000, 50000]
        })
        
        fig = go.Figure()
        fig.add_trace(go.Bar(x=metrics['metric'], y=metrics['value'], name='Actual'))
        fig.add_trace(go.Bar(x=metrics['metric'], y=metrics['target'], name='Target'))
        fig.update_layout(title="Performance Metrics Comparison")
        st.plotly_chart(fig, use_container_width=True)
    
    # Feature Drift
    st.subheader("🔄 Feature Drift Detection")
    
    drift_data = pd.DataFrame({
        'feature': ['Area', 'Bedrooms', 'Bathrooms', 'Location', 'Age'],
        'drift_score': np.random.uniform(0, 0.3, 5),
        'threshold': [0.1, 0.1, 0.1, 0.15, 0.1]
    })
    
    fig = px.bar(drift_data, x='feature', y='drift_score', 
                 title="Feature Drift Scores")
    fig.add_hline(y=0.1, line_dash="dash", line_color="red", annotation_text="Alert Threshold")
    st.plotly_chart(fig, use_container_width=True)

def show_market_trends():
    """Market Trends Analysis"""
    st.header("📊 Market Trends")
    
    # Price Trends
    st.subheader("📈 Price Trends by Market")
    
    markets = ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix']
    dates = pd.date_range(start='2023-01-01', periods=24, freq='M')
    
    trend_data = []
    for market in markets:
        base_price = np.random.uniform(300000, 800000)
        for date in dates:
            price = base_price * (1 + np.random.uniform(-0.02, 0.04)) ** ((date - dates[0]).days / 30)
            trend_data.append({
                'date': date,
                'market': market,
                'price': price
            })
    
    trend_df = pd.DataFrame(trend_data)
    
    fig = px.line(trend_df, x='date', y='price', color='market',
                  title="Median Price Trends by Market")
    st.plotly_chart(fig, use_container_width=True)
    
    # Market Comparison
    st.subheader("🏙️ Market Comparison")
    
    market_stats = pd.DataFrame({
        'market': markets,
        'median_price': [650000, 750000, 350000, 320000, 420000],
        'price_per_sqft': [650, 480, 220, 180, 260],
        'days_on_market': [28, 35, 45, 38, 42],
        'inventory_level': ['Low', 'Medium', 'High', 'Medium', 'High']
    })
    
    col1, col2 = st.columns(2)
    
    with col1:
        fig = px.bar(market_stats, x='market', y='median_price',
                     title="Median Price by Market")
        st.plotly_chart(fig, use_container_width=True)
    
    with col2:
        fig = px.bar(market_stats, x='market', y='days_on_market',
                     title="Days on Market by Market")
        st.plotly_chart(fig, use_container_width=True)

if __name__ == "__main__":
    main()
