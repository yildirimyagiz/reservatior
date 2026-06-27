"""
ML Services Initializer
Initialize all ML services on startup
"""

def initialize_all_services():
    """Initialize all ML services"""
    print("🚀 Initializing ML Services...")
    
    # Initialize price prediction
    try:
        from app.services.price_prediction_service import initialize_price_predictor
        price_success = initialize_price_predictor()
        print(f"{'✅' if price_success else '❌'} Price Prediction Service")
    except Exception as e:
        print(f"❌ Price Prediction Service: {e}")
    
    # Initialize location intelligence
    try:
        from app.services.location_intelligence_service import initialize_location_analyzer
        location_success = initialize_location_analyzer()
        print(f"{'✅' if location_success else '❌'} Location Intelligence Service")
    except Exception as e:
        print(f"❌ Location Intelligence Service: {e}")
    
    # Initialize investment analysis
    try:
        from app.services.investment_analysis_service import initialize_investment_analyzer
        investment_success = initialize_investment_analyzer()
        print(f"{'✅' if investment_success else '❌'} Investment Analysis Service")
    except Exception as e:
        print(f"❌ Investment Analysis Service: {e}")
    
    # Check existing services
    try:
        from app.ai.staging_pipeline import staging_pipeline
        print("✅ Staging Pipeline")
    except Exception as e:
        print(f"❌ Staging Pipeline: {e}")
    
    try:
        from app.ai.walkthrough_pipeline import walkthrough_selector
        print("✅ Walkthrough Pipeline")
    except Exception as e:
        print(f"❌ Walkthrough Pipeline: {e}")
    
    try:
        from app.ai.ngp_pipeline import ngp_pipeline
        print("✅ NGP Pipeline")
    except Exception as e:
        print(f"❌ NGP Pipeline: {e}")
    
    try:
        from app.ai.gaussian_splatting_pipeline import gaussian_splatting_pipeline
        print("✅ Gaussian Splatting Pipeline")
    except Exception as e:
        print(f"❌ Gaussian Splatting Pipeline: {e}")
    
    print("🎯 ML Services initialization complete!")

if __name__ == "__main__":
    initialize_all_services()
