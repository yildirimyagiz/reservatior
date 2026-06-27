#!/usr/bin/env python3
"""
Python Translation API Test Suite
Tests the FastAPI translation service directly

Run: python test_api.py
"""

import requests
import json
import time
import sys
from typing import Dict, Any

# Configuration
API_BASE_URL = "http://localhost:8002"
TEST_AGENCY_ID = "test-agency-123"

# Test data
TEST_TEXTS = {
    "english": "Hello, how are you today?",
    "spanish": "Hola, ¿cómo estás hoy?", 
    "arabic": "مرحبا، كيف حالك اليوم؟",
    "chinese": "你好，你今天好吗？",
    "emoji": "Hello! 👋 🌍 ✨",
    "mixed": "Hello مرحبا 你好"
}

class Colors:
    GREEN = '\033[92m'
    RED = '\033[91m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    BOLD = '\033[1m'
    RESET = '\033[0m'

def log(message: str, color: str = Colors.RESET):
    print(f"{color}{message}{Colors.RESET}")

def log_section(title: str):
    print('\n' + '=' * 60)
    log(f"🧪 {title}", Colors.BOLD)
    print('=' * 60)

def log_test(test_name: str):
    log(f"\n🔬 Testing: {test_name}", Colors.CYAN)

def log_success(message: str):
    log(f"✅ {message}", Colors.GREEN)

def log_error(message: str):
    log(f"❌ {message}", Colors.RED)

def log_warning(message: str):
    log(f"⚠️  {message}", Colors.YELLOW)

def make_request(endpoint: str, method: str = "GET", data: Dict[Any, Any] = None) -> Dict[Any, Any]:
    """Make HTTP request to the API"""
    url = f"{API_BASE_URL}{endpoint}"
    
    try:
        if method == "GET":
            response = requests.get(url)
        elif method == "POST":
            response = requests.post(url, json=data, headers={"Content-Type": "application/json"})
        else:
            raise ValueError(f"Unsupported method: {method}")
        
        response.raise_for_status()
        return response.json()
    
    except requests.exceptions.ConnectionError:
        raise Exception(f"Cannot connect to API at {url}. Is the service running?")
    except requests.exceptions.HTTPError as e:
        try:
            error_detail = response.json().get('detail', str(e))
        except:
            error_detail = str(e)
        raise Exception(f"HTTP {response.status_code}: {error_detail}")
    except requests.exceptions.RequestException as e:
        raise Exception(f"Request failed: {str(e)}")

def test_health_check():
    """Test API health check"""
    log_test("Health Check")
    
    try:
        # Test root endpoint
        root = make_request("/")
        assert root["service"] == "Translation API"
        assert root["status"] == "healthy"
        log_success(f"Root endpoint OK - Version {root['version']}")
        
        # Test detailed health
        health = make_request("/health")
        assert health["status"] in ["healthy", "degraded"]
        log_success(f"Health check OK - Translation service: {health['translation_service']}")
        
        return True
        
    except Exception as e:
        log_error(f"Health check failed: {str(e)}")
        return False

def test_supported_languages():
    """Test getting supported languages"""
    log_test("Get Supported Languages")
    
    try:
        languages = make_request("/languages")
        assert languages["success"] is True
        assert isinstance(languages["languages"], list)
        assert len(languages["languages"]) > 0
        
        log_success(f"Found {languages['total']} supported languages")
        
        # Show first few languages
        for lang in languages["languages"][:5]:
            log(f"  📍 {lang['name']} ({lang['code']}) - {lang['native_name']}", Colors.BLUE)
        
        return True
        
    except Exception as e:
        log_error(f"Languages test failed: {str(e)}")
        return False

def test_language_detection():
    """Test language detection"""
    log_test("Language Detection")
    
    try:
        # Test Spanish detection
        detection = make_request("/detect", "POST", {
            "text": TEST_TEXTS["spanish"],
            "agency_id": TEST_AGENCY_ID
        })
        
        assert detection["success"] is True
        assert detection["detected_language"] == "es"
        assert detection["confidence"] > 0.7
        
        log_success(f"Detected Spanish with {detection['confidence']:.1%} confidence")
        
        # Test English detection
        detection_en = make_request("/detect", "POST", {
            "text": TEST_TEXTS["english"]
        })
        
        assert detection_en["detected_language"] == "en"
        log_success(f"Detected English: '{detection_en['text'][:30]}...'")
        
        return True
        
    except Exception as e:
        log_error(f"Language detection failed: {str(e)}")
        return False

def test_basic_translation():
    """Test basic text translation"""
    log_test("Basic Translation (English → Spanish)")
    
    try:
        translation = make_request("/translate", "POST", {
            "text": TEST_TEXTS["english"],
            "source_lang": "en",
            "target_lang": "es",
            "agency_id": TEST_AGENCY_ID
        })
        
        assert translation["success"] is True
        assert len(translation["translated_text"]) > 0
        assert translation["original_text"] == TEST_TEXTS["english"]
        assert translation["target_language"] == "es"
        
        log_success(f"'{TEST_TEXTS['english']}'")
        log_success(f"→ '{translation['translated_text']}'")
        
        return True
        
    except Exception as e:
        log_error(f"Basic translation failed: {str(e)}")
        return False

def test_auto_detect_translation():
    """Test auto-detect translation"""
    log_test("Auto-Detect Translation (Spanish → English)")
    
    try:
        translation = make_request("/translate", "POST", {
            "text": TEST_TEXTS["spanish"],
            "source_lang": "auto",
            "target_lang": "en",
            "agency_id": TEST_AGENCY_ID
        })
        
        assert translation["success"] is True
        assert translation["detected_source_language"] == "es"
        assert translation["target_language"] == "en"
        
        log_success(f"Auto-detected Spanish:")
        log_success(f"'{TEST_TEXTS['spanish']}'")
        log_success(f"→ '{translation['translated_text']}'")
        
        return True
        
    except Exception as e:
        log_error(f"Auto-detect translation failed: {str(e)}")
        return False

def test_batch_translation():
    """Test batch translation"""
    log_test("Batch Translation")
    
    try:
        texts = [
            "Hello world",
            "Good morning", 
            "Thank you very much",
            "How are you?",
            "See you later"
        ]
        
        batch = make_request("/translate/batch", "POST", {
            "texts": texts,
            "source_lang": "en",
            "target_lang": "es",
            "agency_id": TEST_AGENCY_ID
        })
        
        assert batch["success"] is True
        assert len(batch["results"]) == len(texts)
        assert batch["target_language"] == "es"
        
        successful = sum(1 for r in batch["results"] if r["success"])
        log_success(f"Batch translated {successful}/{len(texts)} texts:")
        
        for i, result in enumerate(batch["results"]):
            if result["success"]:
                log(f"  {i+1}. '{result['original_text']}' → '{result['translated_text']}'", Colors.BLUE)
        
        return True
        
    except Exception as e:
        log_error(f"Batch translation failed: {str(e)}")
        return False

def test_rtl_languages():
    """Test Right-to-Left language support"""
    log_test("RTL Language Support (Arabic)")
    
    try:
        # English to Arabic
        translation = make_request("/translate", "POST", {
            "text": TEST_TEXTS["english"],
            "source_lang": "en", 
            "target_lang": "ar"
        })
        
        assert translation["success"] is True
        assert translation["target_language"] == "ar"
        
        log_success(f"English → Arabic:")
        log_success(f"'{TEST_TEXTS['english']}'")
        log_success(f"→ '{translation['translated_text']}'")
        
        # Test Arabic detection
        detection = make_request("/detect", "POST", {
            "text": TEST_TEXTS["arabic"]
        })
        
        assert detection["detected_language"] == "ar"
        log_success(f"Arabic detection: {detection['confidence']:.1%} confidence")
        
        return True
        
    except Exception as e:
        log_error(f"RTL language test failed: {str(e)}")
        return False

def test_error_handling():
    """Test error handling"""
    log_test("Error Handling")
    
    # Test empty text
    try:
        make_request("/translate", "POST", {
            "text": "",
            "target_lang": "es"
        })
        log_error("Should have failed with empty text")
        return False
    except Exception:
        log_success("Properly handled empty text")
    
    # Test invalid language
    try:
        make_request("/translate", "POST", {
            "text": "Hello",
            "source_lang": "invalid",
            "target_lang": "also-invalid"
        })
        log_error("Should have failed with invalid languages")
        return False
    except Exception:
        log_success("Properly handled invalid languages")
    
    # Test oversized batch
    try:
        large_batch = ["Hello"] * 150
        make_request("/translate/batch", "POST", {
            "texts": large_batch,
            "target_lang": "es"
        })
        log_error("Should have failed with oversized batch")
        return False
    except Exception:
        log_success("Properly handled oversized batch (>100 limit)")
    
    return True

def test_special_characters():
    """Test special characters and emoji"""
    log_test("Special Characters and Emoji")
    
    try:
        translation = make_request("/translate", "POST", {
            "text": TEST_TEXTS["emoji"],
            "source_lang": "en",
            "target_lang": "es"
        })
        
        assert translation["success"] is True
        log_success(f"Emoji translation:")
        log_success(f"'{TEST_TEXTS['emoji']}'")
        log_success(f"→ '{translation['translated_text']}'")
        
        return True
        
    except Exception as e:
        log_error(f"Special characters test failed: {str(e)}")
        return False

def test_performance():
    """Test translation performance"""
    log_test("Performance Test (10 concurrent translations)")
    
    try:
        import threading
        import queue
        
        results = queue.Queue()
        start_time = time.time()
        
        def translate_worker(text_num):
            try:
                result = make_request("/translate", "POST", {
                    "text": f"Performance test message {text_num}: {TEST_TEXTS['english']}",
                    "source_lang": "en",
                    "target_lang": "es"
                })
                results.put(("success", text_num, result))
            except Exception as e:
                results.put(("error", text_num, str(e)))
        
        # Start 10 concurrent translations
        threads = []
        for i in range(10):
            thread = threading.Thread(target=translate_worker, args=(i+1,))
            thread.start()
            threads.append(thread)
        
        # Wait for all to complete
        for thread in threads:
            thread.join()
        
        end_time = time.time()
        duration = end_time - start_time
        
        # Count results
        successful = 0
        errors = 0
        while not results.empty():
            result_type, _, _ = results.get()
            if result_type == "success":
                successful += 1
            else:
                errors += 1
        
        log_success(f"Completed {successful}/10 translations in {duration:.2f}s")
        log_success(f"Average: {(duration/10)*1000:.1f}ms per translation")
        
        if errors > 0:
            log_warning(f"{errors} translations failed")
        
        return True
        
    except Exception as e:
        log_error(f"Performance test failed: {str(e)}")
        return False

def run_all_tests():
    """Run all translation API tests"""
    log("🚀 Starting Python Translation API Test Suite", Colors.BOLD)
    log(f"Testing API at: {API_BASE_URL}", Colors.YELLOW)
    
    tests = [
        ("Health Check", test_health_check),
        ("Supported Languages", test_supported_languages),
        ("Language Detection", test_language_detection),
        ("Basic Translation", test_basic_translation),
        ("Auto-Detect Translation", test_auto_detect_translation),
        ("Batch Translation", test_batch_translation),
        ("RTL Languages", test_rtl_languages),
        ("Error Handling", test_error_handling),
        ("Special Characters", test_special_characters),
        ("Performance", test_performance),
    ]
    
    passed = 0
    failed = 0
    
    for test_name, test_func in tests:
        log_section(test_name)
        try:
            if test_func():
                passed += 1
            else:
                failed += 1
        except Exception as e:
            log_error(f"Test failed with exception: {str(e)}")
            failed += 1
    
    # Summary
    log_section("Test Results Summary")
    log(f"📊 Tests Passed: {passed}", Colors.GREEN)
    log(f"📊 Tests Failed: {failed}", Colors.RED if failed > 0 else Colors.GREEN)
    log(f"📊 Success Rate: {(passed/(passed+failed)*100):.1f}%", Colors.GREEN if failed == 0 else Colors.YELLOW)
    
    if failed == 0:
        log("\n🎉 All tests passed! Translation API is working correctly.", Colors.GREEN)
    else:
        log(f"\n⚠️  {failed} tests failed. Check the errors above.", Colors.RED)
    
    return failed == 0

if __name__ == "__main__":
    try:
        success = run_all_tests()
        sys.exit(0 if success else 1)
    except KeyboardInterrupt:
        log("\n🛑 Tests interrupted by user", Colors.YELLOW)
        sys.exit(1)
    except Exception as e:
        log_error(f"Test suite failed: {str(e)}")
        sys.exit(1)