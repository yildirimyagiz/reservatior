import { prismaManager } from "../prisma";

const prisma = prismaManager.getDefault();

export class CategoryService {
  /**
   * Get all categories with hierarchical structure and translations
   */
  static async getCategories(lang: string = "en") {
    // We fetch root categories and include their children and translations for the given language
    const categories = await (prisma as any).category.findMany({
      where: { parentId: null, isActive: true },
      include: {
        translations: {
          where: { languageCode: lang }
        },
        children: {
          where: { isActive: true },
          include: {
            translations: {
              where: { languageCode: lang }
            }
          }
        }
      },
      orderBy: { order: "asc" }
    });

    return categories;
  }

  /**
   * Create a new category with translations
   */
  static async createCategory(data: {
    slug: string;
    parentId?: string;
    icon?: string;
    imageUrl?: string;
    translations: { languageCode: string; name: string; description?: string }[];
  }) {
    return (prisma as any).category.create({
      data: {
        slug: data.slug,
        parentId: data.parentId,
        icon: data.icon,
        imageUrl: data.imageUrl,
        translations: {
          create: data.translations
        }
      }
    });
  }

  /**
   * Assign a category to a listing
   */
  static async assignToListing(listingId: string, categoryId: string) {
    return (prisma as any).listing.update({
      where: { id: listingId },
      data: { categoryId }
    });
  }
}
