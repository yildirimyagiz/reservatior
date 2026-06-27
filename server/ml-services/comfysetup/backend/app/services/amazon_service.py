from amazon_paapi import AmazonApi, SearchResult
import os
from typing import Any
from app.schemas.common import ShopifyProduct, ShopifyProductsResponse

class AmazonService:
    def __init__(self):
        self.client = AmazonApi(
            key=os.getenv('AMAZON_ACCESS_KEY'),
            secret=os.getenv('AMAZON_SECRET_KEY'),
            tag=os.getenv('AMAZON_PARTNER_TAG', 'your-tag-20'),
            country='US',
            throttling=0.9
        )

    def transform_product(self, item: Any) -> ShopifyProduct:
        price_info = item.offers.listings[0].price if item.offers and item.offers.listings else None
        price_amount = price_info.display_amount if price_info else '0'
        currency = price_info.currency if price_info else 'USD'

        image_info = item.images.primary.large if item.images and item.images.primary else None
        image_url = image_info.url if image_info else 'https://via.placeholder.com/500x500?text=No+Image'

        return ShopifyProduct(
            id=item.asin,
            title=item.item_info.title.display_value if item.item_info and item.item_info.title else 'Unknown Product',
            handle=item.asin,
            description=' '.join(item.item_info.features.display_values) if item.item_info and item.item_info.features else '',
            productType='Furniture',
            vendor='Amazon',
            tags=['amazon'],
            price={
                'amount': price_amount,
                'currencyCode': currency
            },
            image={
                'url': image_url,
                'altText': item.item_info.title.display_value if item.item_info and item.item_info.title else 'Product Image',
                'width': image_info.width if image_info else 500,
                'height': image_info.height if image_info else 500
            },
            images=[{
                'url': image_url,
                'altText': item.item_info.title.display_value if item.item_info and item.item_info.title else 'Product Image',
                'width': image_info.width if image_info else 500,
                'height': image_info.height if image_info else 500
            }],
            variants=[{
                'id': item.asin,
                'title': 'Default',
                'availableForSale': item.offers.listings[0].availability.type == 'Now' if item.offers and item.offers.listings else False,
                'price': {
                    'amount': price_amount,
                    'currencyCode': currency
                },
                'image': {
                    'url': image_url,
                    'altText': item.item_info.title.display_value if item.item_info and item.item_info.title else 'Product Image'
                }
            }]
        )

    async def search_products(self, category: str = 'furniture', search_term: str = '', limit: int = 20) -> ShopifyProductsResponse:
        try:
            keyword = search_term if search_term else f'{category} furniture'

            result: SearchResult = self.client.search_items(
                keywords=keyword,
                search_index='All',
                item_count=min(limit, 10)
            )

            products = []
            if result.items:
                products = [self.transform_product(item) for item in result.items]

            return ShopifyProductsResponse(
                products=products,
                pageInfo={
                    'hasNextPage': False,
                    'endCursor': None
                }
            )
        except Exception as e:
            print(f"Amazon API error: {e}")
            # Fallback mock data
            mock_products = []
            for i in range(8):
                mock_products.append(ShopifyProduct(
                    id=f'mock-paapi-{i}',
                    title=f'{keyword} - Amazon PA API (Mock)',
                    handle=f'mock-paapi-{i}',
                    description='This is a fallback mock product because the Amazon PA API failed.',
                    productType='Furniture',
                    vendor='Amazon',
                    tags=['amazon', 'mock'],
                    price={'amount': str(50 + i * 20), 'currencyCode': 'USD'},
                    image={
                        'url': f'https://images.unsplash.com/photo-{["1555041469-a586c61ea9bc", "1592078615290-033ee584e267", "1530018607912-eff2daa1bac4", "1594620302200-9a762244a156", "1505693516327-07aa252dd028", "1540932296-ac5af2100c15", "1513519245088-0e12902e5a38", "1532323544230-ac991c72dd58"][i % 8]}?auto=format&fit=crop&w=500&q=60',
                        'altText': 'Mock Amazon Product',
                        'width': 500,
                        'height': 500
                    },
                    images=[],
                    variants=[]
                ))

            return ShopifyProductsResponse(
                products=mock_products,
                pageInfo={'hasNextPage': False, 'endCursor': None}
            )

amazon_service = AmazonService()
