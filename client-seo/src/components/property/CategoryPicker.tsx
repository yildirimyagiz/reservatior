import { useTranslation } from "react-i18next";
import React, { useState, useEffect } from 'react';
interface CategoryTranslation {
  name: string;
}
interface Category {
  id: string;
  slug: string;
  icon?: string;
  translations: CategoryTranslation[];
  children?: Category[];
}
interface CategoryPickerProps {
  selectedCategoryId?: string;
  onChange: (categoryId: string) => void;
  lang?: string;
}
const CategoryPicker: React.FC<CategoryPickerProps> = ({
  selectedCategoryId,
  onChange,
  lang = 'en'
}) => {
  const {
    t
  } = useTranslation();
  const [categories, setCategories] = useState<Category[]>([]);
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const response = await fetch(`/api/v1/categories?lang=${lang}`);
        const json = await response.json();
        setCategories(json.data);
      } catch (error) {
        console.error('Failed to fetch categories', error);
      } finally {
        setLoading(false);
      }
    };
    fetchCategories();
  }, [lang]);
  if (loading) return <div className="p-4 text-slate-400">{t("client.src.loading_categories")}</div>;
  return <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
      {categories.map(category => <div key={category.id} onClick={() => onChange(category.id)} className={`
            cursor-pointer p-4 rounded-xl border-2 transition-all flex flex-col items-center justify-center gap-2
            ${selectedCategoryId === category.id ? 'border-indigo-500 bg-indigo-500/10' : 'border-slate-800 bg-slate-900/50 hover:border-slate-700'}
          `}>
          {category.icon && <span className="text-2xl">{category.icon}</span>}
          <span className="text-sm font-medium text-white truncate w-full text-center">
            {category.translations[0]?.name || category.slug}
          </span>
        </div>)}
    </div>;
};
export default CategoryPicker;