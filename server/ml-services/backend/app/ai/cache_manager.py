"""
app/ai/cache_manager.py
AI inference result caching to reduce costs
"""

import json
import hashlib
from pathlib import Path
from typing import Any, Optional
import logging
from datetime import datetime, timedelta

logger = logging.getLogger(__name__)


class CacheManager:
    """
    Cache manager for AI inference results
    Prevents duplicate expensive API calls
    """
    
    def __init__(self, cache_dir: str = "./storage/cache"):
        self.cache_dir = Path(cache_dir)
        self.cache_dir.mkdir(parents=True, exist_ok=True)
        
        # Default TTL for different operations (in days)
        self.ttl = {
            "image_enhancement": 365,  # 1 year
            "scene_analysis": 365,
            "staging": 90,  # 3 months
            "video_generation": 30,  # 1 month
            "transcription": 365,
            "tts": 90,
        }
    
    def _generate_cache_key(self, operation: str, input_data: dict) -> str:
        """
        Generate unique cache key from operation and input
        
        Args:
            operation: Operation type (e.g., "image_enhancement")
            input_data: Input parameters
        
        Returns:
            Cache key string
        """
        # Sort dict keys for consistent hashing
        sorted_data = json.dumps(input_data, sort_keys=True)
        data_hash = hashlib.sha256(sorted_data.encode()).hexdigest()
        return f"{operation}_{data_hash}"
    
    def _get_cache_path(self, cache_key: str) -> Path:
        """Get file path for cache key"""
        return self.cache_dir / f"{cache_key}.json"
    
    def get(self, operation: str, input_data: dict) -> Optional[Any]:
        """
        Retrieve cached result
        
        Args:
            operation: Operation type
            input_data: Input parameters
        
        Returns:
            Cached result or None if not found/expired
        """
        cache_key = self._generate_cache_key(operation, input_data)
        cache_path = self._get_cache_path(cache_key)
        
        if not cache_path.exists():
            logger.debug(f"Cache miss: {cache_key}")
            return None
        
        try:
            with open(cache_path, 'r') as f:
                cache_data = json.load(f)
            
            # Check if expired
            cached_at = datetime.fromisoformat(cache_data["cached_at"])
            ttl_days = self.ttl.get(operation, 30)
            expiry = cached_at + timedelta(days=ttl_days)
            
            if datetime.utcnow() > expiry:
                logger.info(f"Cache expired: {cache_key}")
                cache_path.unlink()  # Delete expired cache
                return None
            
            logger.info(f"Cache hit: {cache_key}")
            return cache_data["result"]
            
        except Exception as e:
            logger.error(f"Cache read error: {e}")
            return None
    
    def set(self, operation: str, input_data: dict, result: Any) -> bool:
        """
        Store result in cache
        
        Args:
            operation: Operation type
            input_data: Input parameters
            result: Result to cache
        
        Returns:
            True if successful
        """
        cache_key = self._generate_cache_key(operation, input_data)
        cache_path = self._get_cache_path(cache_key)
        
        try:
            cache_data = {
                "operation": operation,
                "input": input_data,
                "result": result,
                "cached_at": datetime.utcnow().isoformat()
            }
            
            with open(cache_path, 'w') as f:
                json.dump(cache_data, f, indent=2)
            
            logger.info(f"Cached result: {cache_key}")
            return True
            
        except Exception as e:
            logger.error(f"Cache write error: {e}")
            return False
    
    def invalidate(self, operation: str, input_data: dict) -> bool:
        """
        Invalidate specific cache entry
        
        Args:
            operation: Operation type
            input_data: Input parameters
        
        Returns:
            True if invalidated
        """
        cache_key = self._generate_cache_key(operation, input_data)
        cache_path = self._get_cache_path(cache_key)
        
        if cache_path.exists():
            cache_path.unlink()
            logger.info(f"Invalidated cache: {cache_key}")
            return True
        
        return False
    
    def clear_expired(self) -> int:
        """
        Clear all expired cache entries
        
        Returns:
            Number of entries cleared
        """
        cleared = 0
        
        for cache_file in self.cache_dir.glob("*.json"):
            try:
                with open(cache_file, 'r') as f:
                    cache_data = json.load(f)
                
                operation = cache_data.get("operation", "unknown")
                cached_at = datetime.fromisoformat(cache_data["cached_at"])
                ttl_days = self.ttl.get(operation, 30)
                expiry = cached_at + timedelta(days=ttl_days)
                
                if datetime.utcnow() > expiry:
                    cache_file.unlink()
                    cleared += 1
                    
            except Exception as e:
                logger.error(f"Error processing cache file {cache_file}: {e}")
        
        logger.info(f"Cleared {cleared} expired cache entries")
        return cleared
    
    def clear_all(self) -> int:
        """
        Clear all cache entries
        
        Returns:
            Number of entries cleared
        """
        cleared = 0
        
        for cache_file in self.cache_dir.glob("*.json"):
            cache_file.unlink()
            cleared += 1
        
        logger.info(f"Cleared all cache: {cleared} entries")
        return cleared
    
    def get_cache_size(self) -> dict:
        """
        Get cache statistics
        
        Returns:
            Dictionary with cache stats
        """
        total_files = 0
        total_size = 0
        by_operation = {}
        
        for cache_file in self.cache_dir.glob("*.json"):
            total_files += 1
            total_size += cache_file.stat().st_size
            
            try:
                with open(cache_file, 'r') as f:
                    cache_data = json.load(f)
                    operation = cache_data.get("operation", "unknown")
                    
                    if operation not in by_operation:
                        by_operation[operation] = {"count": 0, "size": 0}
                    
                    by_operation[operation]["count"] += 1
                    by_operation[operation]["size"] += cache_file.stat().st_size
                    
            except Exception:
                pass
        
        return {
            "total_entries": total_files,
            "total_size_bytes": total_size,
            "total_size_mb": total_size / (1024 * 1024),
            "by_operation": by_operation
        }


# Global cache manager instance
cache_manager = CacheManager()