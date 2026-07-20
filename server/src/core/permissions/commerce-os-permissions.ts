export const CommerceOSPermissions = {
  PRODUCT_CREATE: 'product.create',
  PRODUCT_READ: 'product.read',
  PRODUCT_UPDATE: 'product.update',
  PRODUCT_DELETE: 'product.delete',
  ORDER_CREATE: 'order.create',
  ORDER_READ: 'order.read',
  ORDER_UPDATE: 'order.update',
  ORDER_FULFILL: 'order.fulfill',
  CART_UPDATE: 'cart.update',
  COMMERCE_ADMIN_ALL: 'commerce.admin.all',
} as const;

export type CommerceOSPermission = typeof CommerceOSPermissions[keyof typeof CommerceOSPermissions];

export const CommerceOSRolePermissions: Record<string, CommerceOSPermission[]> = {
  user: [CommerceOSPermissions.PRODUCT_READ, CommerceOSPermissions.ORDER_READ, CommerceOSPermissions.CART_UPDATE],
  merchant: [CommerceOSPermissions.PRODUCT_CREATE, CommerceOSPermissions.PRODUCT_READ, CommerceOSPermissions.PRODUCT_UPDATE, CommerceOSPermissions.ORDER_READ, CommerceOSPermissions.ORDER_FULFILL],
  admin: [CommerceOSPermissions.COMMERCE_ADMIN_ALL],
};

export function hasCommercePermission(userPermissions: string[], requiredPermission: CommerceOSPermission): boolean {
  return userPermissions.includes(CommerceOSPermissions.COMMERCE_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
