export interface CommerceOSAPIContract {
  createProduct(params: any): Promise<any>;
  getProduct(productId: string): Promise<any>;
  updateProduct(productId: string, params: any): Promise<any>;
  deleteProduct(productId: string): Promise<any>;
  createOrder(params: any): Promise<any>;
  getOrder(orderId: string): Promise<any>;
  fulfillOrder(orderId: string): Promise<any>;
  updateCart(userId: string, params: any): Promise<any>;
}
