import fs from 'fs/promises';
import path from 'path';

const AR_PATH = path.resolve('src/locales/ar.json');
const EN_PATH = path.resolve('src/locales/en.json');
const TR_PATH = path.resolve('src/locales/tr.json');

// Word-level English→Arabic dictionary
const W: Record<string, string> = {
  // Common UI
  "Dashboard":"لوحة التحكم","Settings":"الإعدادات","Profile":"الملف الشخصي","Search":"بحث","Filter":"تصفية","Save":"حفظ",
  "Cancel":"إلغاء","Delete":"حذف","Edit":"تعديل","Create":"إنشاء","Add":"إضافة","Remove":"إزالة","Update":"تحديث",
  "Close":"إغلاق","Open":"فتح","View":"عرض","Download":"تحميل","Upload":"رفع","Export":"تصدير","Import":"استيراد",
  "Submit":"إرسال","Confirm":"تأكيد","Apply":"تطبيق","Reset":"إعادة تعيين","Refresh":"تحديث","Back":"رجوع","Next":"التالي",
  "Previous":"السابق","Loading":"جاري التحميل","Error":"خطأ","Success":"نجاح","Warning":"تحذير","Info":"معلومات",
  "Yes":"نعم","No":"لا","OK":"حسناً","Done":"تم","Pending":"معلق","Active":"نشط","Inactive":"غير نشط",
  "Enabled":"مفعّل","Disabled":"معطّل","Status":"الحالة","Name":"الاسم","Title":"العنوان","Description":"الوصف",
  "Type":"النوع","Category":"الفئة","Date":"التاريخ","Time":"الوقت","Amount":"المبلغ","Price":"السعر","Total":"الإجمالي",
  "Actions":"الإجراءات","Action":"إجراء","Details":"التفاصيل","Overview":"نظرة عامة","Summary":"ملخص","Report":"تقرير",
  "Reports":"التقارير","Analytics":"التحليلات","Statistics":"الإحصائيات","History":"السجل","Log":"السجل","Logs":"السجلات",
  "List":"القائمة","Table":"الجدول","Grid":"الشبكة","Chart":"الرسم البياني","Graph":"الرسم البياني",
  "Notifications":"الإشعارات","Notification":"إشعار","Messages":"الرسائل","Message":"رسالة","Email":"البريد الإلكتروني",
  "Phone":"الهاتف","Address":"العنوان","Location":"الموقع","Country":"البلد","City":"المدينة","Region":"المنطقة",
  "Language":"اللغة","Currency":"العملة","Organization":"المؤسسة","Company":"الشركة","Team":"الفريق",
  "User":"المستخدم","Users":"المستخدمون","Admin":"المسؤول","Manager":"المدير","Agent":"الوكيل","Client":"العميل",
  "Customer":"العميل","Guest":"الضيف","Tenant":"المستأجر","Owner":"المالك","Landlord":"المالك","Buyer":"المشتري",
  "Seller":"البائع","Investor":"المستثمر","Member":"العضو","Members":"الأعضاء","Role":"الدور","Roles":"الأدوار",
  "Permission":"الصلاحية","Permissions":"الصلاحيات","Access":"الوصول","Security":"الأمان","Authentication":"المصادقة",
  "Login":"تسجيل الدخول","Logout":"تسجيل الخروج","Register":"تسجيل","Password":"كلمة المرور","Token":"الرمز",
  // Property & Real Estate
  "Property":"العقار","Properties":"العقارات","Listing":"القائمة","Listings":"القوائم","Booking":"الحجز","Bookings":"الحجوزات",
  "Reservation":"الحجز","Reservations":"الحجوزات","Apartment":"شقة","House":"منزل","Villa":"فيلا","Condo":"شقة سكنية",
  "Land":"أرض","Building":"مبنى","Floor":"طابق","Room":"غرفة","Unit":"وحدة","Bedroom":"غرفة نوم","Bathroom":"حمام",
  "Kitchen":"مطبخ","Garden":"حديقة","Parking":"موقف سيارات","Pool":"مسبح","Balcony":"شرفة","Terrace":"تراس",
  "Amenity":"مرفق","Amenities":"المرافق","Facility":"المنشأة","Facilities":"المنشآت",
  "Rent":"إيجار","Rental":"إيجار","Lease":"عقد إيجار","Mortgage":"رهن عقاري","Sale":"بيع","Purchase":"شراء",
  "Valuation":"تقييم","Appraisal":"تقييم","Inspection":"فحص","Maintenance":"صيانة","Repair":"إصلاح",
  "Renovation":"تجديد","Construction":"بناء","Development":"تطوير",
  // Financial
  "Payment":"الدفع","Payments":"المدفوعات","Invoice":"الفاتورة","Invoices":"الفواتير","Transaction":"المعاملة",
  "Transactions":"المعاملات","Revenue":"الإيرادات","Income":"الدخل","Expense":"المصروف","Expenses":"المصروفات",
  "Budget":"الميزانية","Budgets":"الميزانيات","Tax":"الضريبة","Taxes":"الضرائب","Fee":"الرسوم","Fees":"الرسوم",
  "Commission":"العمولة","Discount":"الخصم","Deposit":"الإيداع","Refund":"استرداد","Balance":"الرصيد",
  "Account":"الحساب","Bank":"البنك","Credit":"ائتمان","Debit":"مدين","Profit":"الربح","Loss":"الخسارة",
  "Cost":"التكلفة","Rate":"المعدل","Percentage":"النسبة المئوية","Interest":"الفائدة",
  "Financial":"المالية","Payout":"التحويل","Payouts":"التحويلات","Billing":"الفوترة",
  // AI & Tech
  "AI":"الذكاء الاصطناعي","Model":"النموذج","Models":"النماذج","Algorithm":"الخوارزمية","Training":"التدريب",
  "Prediction":"التنبؤ","Predictions":"التنبؤات","Analysis":"التحليل","Sentiment":"المشاعر","Detection":"الكشف",
  "Automation":"الأتمتة","Workflow":"سير العمل","Workflows":"سير العمل","Configuration":"الإعدادات","Config":"الإعدادات",
  "Deploy":"نشر","Deployment":"النشر","Performance":"الأداء","Accuracy":"الدقة","Latency":"زمن الاستجابة",
  "Optimization":"التحسين","Integration":"التكامل","API":"واجهة برمجة التطبيقات","Webhook":"خطاف الويب",
  "Database":"قاعدة البيانات","Server":"الخادم","System":"النظام","Service":"الخدمة","Services":"الخدمات",
  "Task":"المهمة","Tasks":"المهام","Queue":"قائمة الانتظار","Process":"العملية","Thread":"الخيط",
  "Score":"النقاط","Scoring":"التقييم","Lead":"العميل المحتمل","Leads":"العملاء المحتملين",
  "Fraud":"الاحتيال","Risk":"المخاطر","Alert":"تنبيه","Alerts":"التنبيهات","Monitor":"المراقبة","Monitoring":"المراقبة",
  "Health":"الصحة","Metrics":"المقاييس","Infrastructure":"البنية التحتية","Cluster":"المجموعة",
  // Documents & Content
  "Document":"المستند","Documents":"المستندات","File":"الملف","Files":"الملفات","Folder":"المجلد","Template":"القالب",
  "Templates":"القوالب","Contract":"العقد","Contracts":"العقود","Agreement":"الاتفاقية","Signature":"التوقيع",
  "Certificate":"الشهادة","License":"الترخيص","Report":"التقرير","Brochure":"الكتيب","Video":"الفيديو",
  "Image":"الصورة","Photo":"الصورة","Media":"الوسائط","Content":"المحتوى","Page":"الصفحة",
  // Status & State
  "Completed":"مكتمل","Confirmed":"مؤكد","Approved":"موافق عليه","Rejected":"مرفوض","Cancelled":"ملغي",
  "Expired":"منتهي الصلاحية","Failed":"فشل","Processing":"قيد المعالجة","Scheduled":"مجدول","Draft":"مسودة",
  "Published":"منشور","Archived":"مؤرشف","Resolved":"تم الحل","Unresolved":"لم يتم الحل",
  "Critical":"حرج","High":"مرتفع","Medium":"متوسط","Low":"منخفض","Urgent":"عاجل",
  "Available":"متاح","Unavailable":"غير متاح","Online":"متصل","Offline":"غير متصل",
  "Verified":"موثق","Unverified":"غير موثق","Blocked":"محظور","Suspended":"معلق",
  // Time & Date
  "Today":"اليوم","Yesterday":"أمس","Tomorrow":"غداً","Week":"أسبوع","Month":"شهر","Year":"سنة",
  "Daily":"يومي","Weekly":"أسبوعي","Monthly":"شهري","Annual":"سنوي","Yearly":"سنوي",
  "Hours":"ساعات","Minutes":"دقائق","Seconds":"ثوان","Days":"أيام","Months":"أشهر","Years":"سنوات",
  "Last":"الأخير","Recent":"الأخيرة","Current":"الحالي","New":"جديد","Old":"قديم",
  // Operations
  "Manage":"إدارة","Management":"الإدارة","Configure":"إعداد","Install":"تثبيت","Setup":"إعداد",
  "Initialize":"تهيئة","Start":"بدء","Stop":"إيقاف","Pause":"إيقاف مؤقت","Resume":"استئناف",
  "Run":"تشغيل","Execute":"تنفيذ","Assign":"تعيين","Transfer":"نقل","Move":"نقل","Copy":"نسخ",
  "Share":"مشاركة","Send":"إرسال","Receive":"استلام","Accept":"قبول","Reject":"رفض","Approve":"موافقة",
  "Review":"مراجعة","Verify":"تحقق","Validate":"التحقق","Check":"فحص","Test":"اختبار",
  "Generate":"إنشاء","Analyze":"تحليل","Calculate":"حساب","Estimate":"تقدير","Predict":"تنبؤ",
  "Schedule":"جدولة","Plan":"خطة","Track":"تتبع","Follow":"متابعة","Subscribe":"اشتراك",
  // Misc common
  "All":"الكل","None":"لا شيء","Other":"أخرى","More":"المزيد","Less":"أقل","Show":"إظهار","Hide":"إخفاء",
  "Enable":"تفعيل","Disable":"تعطيل","Select":"اختيار","Choose":"اختيار","Enter":"إدخال",
  "Required":"مطلوب","Optional":"اختياري","Default":"افتراضي","Custom":"مخصص","General":"عام",
  "Advanced":"متقدم","Basic":"أساسي","Premium":"متميز","Standard":"قياسي","Professional":"احترافي",
  "Free":"مجاني","Paid":"مدفوع","Trial":"تجريبي","Subscription":"اشتراك","Plan":"خطة",
  "Feature":"ميزة","Features":"الميزات","Option":"خيار","Options":"الخيارات","Preference":"تفضيل",
  "Preferences":"التفضيلات","Theme":"السمة","Mode":"الوضع","Version":"الإصدار","Release":"الإصدار",
  "Support":"الدعم","Help":"المساعدة","Contact":"التواصل","Feedback":"التعليقات","Rating":"التقييم",
  "Comment":"التعليق","Comments":"التعليقات","Note":"ملاحظة","Notes":"ملاحظات","Tag":"علامة","Tags":"العلامات",
  "Label":"التسمية","Badge":"الشارة","Icon":"الأيقونة","Color":"اللون","Size":"الحجم",
  "Width":"العرض","Height":"الارتفاع","Length":"الطول","Area":"المساحة","Volume":"الحجم",
  "Count":"العدد","Number":"الرقم","ID":"المعرف","Code":"الرمز","Key":"المفتاح","Value":"القيمة",
  "Min":"الحد الأدنى","Max":"الحد الأقصى","Average":"المتوسط","Avg":"المتوسط","Sum":"المجموع",
  "Percentage":"النسبة","Ratio":"النسبة","Index":"المؤشر","Score":"النقاط","Points":"النقاط",
  "Limit":"الحد","Threshold":"العتبة","Range":"النطاق","Scope":"النطاق","Level":"المستوى",
  "Priority":"الأولوية","Order":"الترتيب","Sort":"فرز","Group":"مجموعة","Batch":"دفعة",
  "Queue":"الطابور","Pipeline":"خط المعالجة","Channel":"القناة","Source":"المصدر","Target":"الهدف",
  "Input":"الإدخال","Output":"الإخراج","Result":"النتيجة","Results":"النتائج","Response":"الاستجابة",
  "Request":"الطلب","Requests":"الطلبات","Connection":"الاتتصال","Session":"الجلسة","Sessions":"الجلسات",
  // Real estate specific
  "Market":"السوق","Trend":"الاتجاه","Trends":"الاتجاهات","Demand":"الطلب","Supply":"العرض",
  "Comparable":"مقارن","Comparables":"المقارنات","Portfolio":"المحفظة","Investment":"الاستثمار",
  "Return":"العائد","Yield":"العائد","ROI":"عائد الاستثمار","Occupancy":"الإشغال",
  "Vacancy":"الشاغر","Turnover":"الدوران","Appreciation":"الارتفاع","Depreciation":"الانخفاض",
  "Equity":"حقوق الملكية","Escrow":"الضمان","Closing":"الإغلاق","Offer":"العرض","Offers":"العروض",
  "Deal":"الصفقة","Deals":"الصفقات","Negotiation":"المفاوضة","Contract":"العقد",
  "Compliance":"الامتثال","Regulation":"التنظيم","Legal":"القانونية","Insurance":"التأمين",
  "Cleaning":"التنظيف","Marketing":"التسويق","Advertising":"الإعلان","Campaign":"الحملة",
  "Promotion":"الترويج","Event":"الحدث","Events":"الأحداث","Calendar":"التقويم","Appointment":"الموعد",
  // Verbs/phrases
  "Created":"تم الإنشاء","Updated":"تم التحديث","Deleted":"تم الحذف","Saved":"تم الحفظ",
  "Uploaded":"تم الرفع","Downloaded":"تم التحميل","Exported":"تم التصدير","Imported":"تم الاستيراد",
  "Sent":"تم الإرسال","Received":"تم الاستلام","Assigned":"تم التعيين","Transferred":"تم النقل",
  "Approved":"تمت الموافقة","Rejected":"تم الرفض","Confirmed":"تم التأكيد",
  "Generated":"تم الإنشاء","Analyzed":"تم التحليل","Processed":"تمت المعالجة","Deployed":"تم النشر",
  "Resolved":"تم الحل","Escalated":"تم التصعيد",
  "successfully":"بنجاح","failed":"فشل","error":"خطأ","not found":"غير موجود",
  "has been":"تم","have been":"تم","will be":"سيتم","can be":"يمكن",
  "from":"من","to":"إلى","for":"لـ","with":"مع","without":"بدون","by":"بواسطة","in":"في","on":"في","at":"في",
  "and":"و","or":"أو","the":"","a":"","an":"","is":"","are":"","was":"","were":"","be":"",
  "this":"هذا","that":"ذلك","these":"هذه","those":"تلك","all":"الكل","no":"لا","not":"لا",
  "new":"جديد","old":"قديم","first":"الأول","last":"الأخير","next":"التالي","previous":"السابق",
  "total":"الإجمالي","average":"المتوسط","maximum":"الحد الأقصى","minimum":"الحد الأدنى",
  "manage":"إدارة","monitor":"مراقبة","configure":"إعداد","view":"عرض","create":"إنشاء",
  "delete":"حذف","edit":"تعديل","update":"تحديث","save":"حفظ","cancel":"إلغاء",
  "search":"بحث","filter":"تصفية","sort":"فرز","export":"تصدير","import":"استيراد",
  "loading":"جاري التحميل","processing":"جاري المعالجة","generating":"جاري الإنشاء",
};

function translateText(en: string): string {
  if (!en || en.trim().length === 0) return en;
  // Don't translate JSON-like values, URLs, technical identifiers
  if (en.startsWith('{') || en.startsWith('http') || en.startsWith('e.g.') || /^[\d.%]+$/.test(en.trim())) return en;
  if (/^[A-Z_]+$/.test(en.trim()) && en.includes('_')) return en; // SNAKE_CASE identifiers
  if (/^[\d.:smhMS%+\-\/]+$/.test(en.trim())) return en; // numeric/time values
  
  // Try exact match first (case insensitive)
  const exactKey = Object.keys(W).find(k => k.toLowerCase() === en.trim().toLowerCase());
  if (exactKey) return W[exactKey];
  
  // Word-by-word translation
  let result = en;
  // Sort by length descending to match longer phrases first
  const sortedKeys = Object.keys(W).sort((a, b) => b.length - a.length);
  
  for (const eng of sortedKeys) {
    const regex = new RegExp(`\\b${eng.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\b`, 'gi');
    result = result.replace(regex, W[eng]);
  }
  
  // Clean up articles and extra spaces
  result = result.replace(/\s+/g, ' ').trim();
  return result;
}

async function main() {
  console.log("Loading files...");
  const enObj = JSON.parse(await fs.readFile(EN_PATH, 'utf-8'));
  const arObj = JSON.parse(await fs.readFile(AR_PATH, 'utf-8'));
  
  let translated = 0, kept = 0, skipped = 0;
  
  function processNode(enNode: any, arNode: any): any {
    if (typeof enNode === 'string') {
      const currentAr = typeof arNode === 'string' ? arNode : undefined;
      const hasArabic = currentAr ? /[\u0600-\u06FF]/.test(currentAr) : false;
      
      if (hasArabic) { kept++; return currentAr; }
      
      const result = translateText(enNode);
      if (result !== enNode) { translated++; } else { skipped++; }
      return result;
    }
    if (typeof enNode === 'object' && enNode !== null && !Array.isArray(enNode)) {
      const result: any = {};
      for (const key of Object.keys(enNode)) {
        result[key] = processNode(enNode[key], arNode?.[key]);
      }
      return result;
    }
    return enNode;
  }
  
  const finalObj = processNode(enObj, arObj);
  
  console.log(`Translated: ${translated}, Kept Arabic: ${kept}, Skipped (technical): ${skipped}`);
  await fs.writeFile(AR_PATH, JSON.stringify(finalObj, null, 2) + '\n');
  console.log("Done! ar.json updated.");
}

main().catch(console.error);
