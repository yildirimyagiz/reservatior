import fs from 'fs/promises';
import path from 'path';

const AR = path.resolve(__dirname, '../src/locales/ar.json');
const EN = path.resolve(__dirname, '../src/locales/en.json');

// Comprehensive English→Arabic word dictionary (350+ entries)
const D: Record<string, string> = {
  // --- Most frequently untranslated (from analysis) ---
  "neural":"عصبي","sync":"مزامنة","node":"عقدة","data":"البيانات","your":"الخاص بك",
  "found":"موجود","desc":"الوصف","global":"عالمي","real":"حقيقي","matrix":"مصفوفة",
  "load":"تحميل","hub":"مركز","entity":"الكيان","platform":"المنصة","protocol":"البروتوكول",
  "identity":"الهوية","powered":"مدعوم","generation":"التوليد","distribution":"التوزيع",
  "audit":"التدقيق","placeholder":"العنصر النائب","units":"الوحدات","records":"السجلات",
  "conversion":"التحويل","estate":"العقارات","asset":"الأصل","signal":"الإشارة",
  "tier":"المستوى","link":"الرابط","pulse":"النبض","across":"عبر","usage":"الاستخدام",
  "synchronization":"المزامنة","verification":"التحقق","parameters":"المعاملات",
  "project":"المشروع","agency":"الوكالة","subtitle":"العنوان الفرعي","intelligence":"الذكاء",
  "pricing":"التسعير","charge":"الرسم","cycle":"الدورة","fetch":"جلب","device":"الجهاز",
  "started":"بدأ","strategic":"استراتيجي","types":"الأنواع","core":"الأساسي",
  "record":"السجل","syncing":"قيد المزامنة","provider":"المزود","complete":"مكتمل",
  "membership":"العضوية","engine":"المحرك","live":"مباشر","progress":"التقدم",
  "exports":"التصدير","our":"لدينا","photos":"الصور","operational":"تشغيلي",
  "plans":"الخطط","cinematic":"سينمائي","map":"الخريطة","full":"كامل","studio":"الاستوديو",
  "information":"المعلومات","department":"القسم","viewing":"المشاهدة","insights":"الرؤى",
  "cloud":"السحابة","temporal":"زمني","job":"المهمة","velocity":"السرعة",
  "jobs":"المهام","rules":"القواعد","rule":"القاعدة","accounts":"الحسابات",
  "factors":"العوامل","factor":"العامل","entries":"الإدخالات","entry":"الإدخال",
  "conditions":"الشروط","condition":"الشرط","requirements":"المتطلبات",
  "requirement":"المتطلب","connections":"الاتصالات","resources":"الموارد",
  "resource":"المورد","policies":"السياسات","policy":"السياسة",
  "issues":"المشكلات","issue":"المشكلة","targets":"الأهداف",
  "functions":"الوظائف","function":"الوظيفة","fields":"الحقول","field":"الحقل",
  "items":"العناصر","item":"العنصر","changes":"التغييرات","change":"التغيير",
  "responses":"الاستجابات","features":"الميزات","zones":"المناطق","zone":"المنطقة",
  "layers":"الطبقات","layer":"الطبقة","profiles":"الملفات الشخصية",

  // --- Common UI words ---
  "Dashboard":"لوحة التحكم","Settings":"الإعدادات","Profile":"الملف الشخصي",
  "Search":"بحث","Filter":"تصفية","Save":"حفظ","Cancel":"إلغاء","Delete":"حذف",
  "Edit":"تعديل","Create":"إنشاء","Add":"إضافة","Remove":"إزالة","Update":"تحديث",
  "Close":"إغلاق","Open":"فتح","View":"عرض","Download":"تحميل","Upload":"رفع",
  "Export":"تصدير","Import":"استيراد","Submit":"إرسال","Confirm":"تأكيد",
  "Apply":"تطبيق","Reset":"إعادة تعيين","Refresh":"تحديث","Back":"رجوع",
  "Next":"التالي","Previous":"السابق","Loading":"جاري التحميل","Error":"خطأ",
  "Success":"نجاح","Warning":"تحذير","Yes":"نعم","No":"لا","OK":"حسناً","Done":"تم",
  "Pending":"قيد الانتظار","Active":"نشط","Inactive":"غير نشط","Enabled":"مُفعّل",
  "Disabled":"مُعطّل","Status":"الحالة","Name":"الاسم","Title":"العنوان",
  "Description":"الوصف","Type":"النوع","Category":"الفئة","Date":"التاريخ",
  "Time":"الوقت","Amount":"المبلغ","Price":"السعر","Total":"الإجمالي",
  "Actions":"الإجراءات","Action":"إجراء","Details":"التفاصيل","Overview":"نظرة عامة",
  "Summary":"ملخص","Report":"تقرير","Reports":"التقارير","Analytics":"التحليلات",
  "Statistics":"الإحصائيات","History":"السجل","Log":"السجل","Logs":"السجلات",
  "Notifications":"الإشعارات","Messages":"الرسائل","Message":"رسالة",
  "Email":"البريد الإلكتروني","Phone":"الهاتف","Address":"العنوان","Location":"الموقع",
  "Country":"البلد","City":"المدينة","Region":"المنطقة","Language":"اللغة",
  "Currency":"العملة","Organization":"المؤسسة","Company":"الشركة","Team":"الفريق",
  "User":"المستخدم","Users":"المستخدمون","Admin":"المسؤول","Manager":"المدير",
  "Agent":"الوكيل","Client":"العميل","Customer":"العميل","Guest":"الضيف",
  "Tenant":"المستأجر","Owner":"المالك","Buyer":"المشتري","Seller":"البائع",
  "Investor":"المستثمر","Member":"العضو","Members":"الأعضاء","Role":"الدور",
  "Roles":"الأدوار","Permission":"الصلاحية","Permissions":"الصلاحيات",
  "Access":"الوصول","Security":"الأمان","Login":"تسجيل الدخول",
  "Logout":"تسجيل الخروج","Password":"كلمة المرور",
  
  // --- Property & Real Estate ---
  "Property":"العقار","Properties":"العقارات","Listing":"الإعلان","Listings":"الإعلانات",
  "Booking":"الحجز","Bookings":"الحجوزات","Reservation":"الحجز","Apartment":"شقة",
  "House":"منزل","Villa":"فيلا","Condo":"شقة سكنية","Land":"أرض","Building":"مبنى",
  "Floor":"طابق","Room":"غرفة","Unit":"وحدة","Bedroom":"غرفة نوم","Bathroom":"حمام",
  "Kitchen":"مطبخ","Garden":"حديقة","Parking":"موقف سيارات","Pool":"مسبح",
  "Balcony":"شرفة","Amenities":"المرافق","Rent":"إيجار","Lease":"عقد إيجار",
  "Mortgage":"رهن عقاري","Sale":"بيع","Valuation":"تقييم","Inspection":"فحص",
  "Maintenance":"صيانة","Repair":"إصلاح","Renovation":"تجديد",
  
  // --- Financial ---
  "Payment":"الدفع","Payments":"المدفوعات","Invoice":"الفاتورة","Invoices":"الفواتير",
  "Transaction":"المعاملة","Transactions":"المعاملات","Revenue":"الإيرادات",
  "Income":"الدخل","Expense":"المصروف","Expenses":"المصروفات","Budget":"الميزانية",
  "Tax":"الضريبة","Taxes":"الضرائب","Fee":"الرسوم","Commission":"العمولة",
  "Deposit":"الإيداع","Refund":"استرداد","Balance":"الرصيد","Account":"الحساب",
  "Profit":"الربح","Loss":"الخسارة","Cost":"التكلفة","Rate":"المعدل",
  "Payout":"التحويل","Payouts":"التحويلات","Billing":"الفوترة","Escrow":"الضمان",
  
  // --- AI & Tech ---
  "AI":"الذكاء الاصطناعي","Model":"النموذج","Models":"النماذج",
  "Algorithm":"الخوارزمية","Training":"التدريب","Prediction":"التنبؤ",
  "Analysis":"التحليل","Sentiment":"المشاعر","Detection":"الكشف",
  "Automation":"الأتمتة","Workflow":"سير العمل","Workflows":"مهام العمل",
  "Configuration":"التكوين","Deploy":"نشر","Deployment":"النشر",
  "Performance":"الأداء","Accuracy":"الدقة","Latency":"زمن الاستجابة",
  "Optimization":"التحسين","Integration":"التكامل","Database":"قاعدة البيانات",
  "Server":"الخادم","System":"النظام","Service":"الخدمة","Services":"الخدمات",
  "Task":"المهمة","Tasks":"المهام","Score":"النقاط","Lead":"العميل المحتمل",
  "Leads":"العملاء المحتملون","Fraud":"الاحتيال","Risk":"المخاطر","Alert":"تنبيه",
  "Alerts":"التنبيهات","Monitor":"المراقبة","Monitoring":"المراقبة",
  "Health":"الصحة","Metrics":"المقاييس","Infrastructure":"البنية التحتية",
  "Cluster":"المجموعة","Pipeline":"خط المعالجة",
  
  // --- Documents ---
  "Document":"المستند","Documents":"المستندات","File":"الملف","Files":"الملفات",
  "Folder":"المجلد","Template":"القالب","Templates":"القوالب","Contract":"العقد",
  "Contracts":"العقود","Certificate":"الشهادة","License":"الترخيص",
  "Brochure":"الكتيب","Video":"الفيديو","Image":"الصورة","Media":"الوسائط",
  "Content":"المحتوى","Page":"الصفحة",
  
  // --- Status ---
  "Completed":"مكتمل","Confirmed":"مؤكد","Approved":"موافق عليه","Rejected":"مرفوض",
  "Cancelled":"ملغي","Expired":"منتهي الصلاحية","Failed":"فشل",
  "Processing":"قيد المعالجة","Scheduled":"مجدول","Draft":"مسودة",
  "Published":"منشور","Archived":"مؤرشف","Resolved":"تم الحل",
  "Critical":"حرج","High":"مرتفع","Medium":"متوسط","Low":"منخفض","Urgent":"عاجل",
  "Available":"متاح","Verified":"تم التحقق","Blocked":"محظور",
  
  // --- Time ---
  "Today":"اليوم","Yesterday":"أمس","Tomorrow":"غداً","Week":"أسبوع","Month":"شهر",
  "Year":"سنة","Daily":"يومي","Weekly":"أسبوعي","Monthly":"شهري","Annual":"سنوي",
  "Hours":"ساعات","Minutes":"دقائق","Days":"أيام",
  
  // --- Operations ---
  "Manage":"إدارة","Management":"الإدارة","Configure":"تكوين","Setup":"إعداد",
  "Initialize":"تهيئة","Start":"بدء","Stop":"إيقاف","Run":"تشغيل",
  "Assign":"تعيين","Transfer":"نقل","Copy":"نسخ","Share":"مشاركة","Send":"إرسال",
  "Accept":"قبول","Review":"مراجعة","Generate":"إنشاء","Analyze":"تحليل",
  "Calculate":"حساب","Schedule":"جدولة","Track":"تتبع",
  
  // --- Misc ---
  "All":"الكل","None":"لا شيء","Other":"أخرى","More":"المزيد","Show":"إظهار",
  "Hide":"إخفاء","Enable":"تفعيل","Select":"اختيار","Enter":"إدخال",
  "Required":"مطلوب","Optional":"اختياري","Default":"افتراضي","Custom":"مخصص",
  "General":"عام","Advanced":"متقدم","Basic":"أساسي","Premium":"متميز",
  "Standard":"قياسي","Professional":"احترافي","Free":"مجاني",
  "Feature":"ميزة","Features":"الميزات","Option":"خيار","Options":"الخيارات",
  "Support":"الدعم","Help":"المساعدة","Contact":"التواصل","Feedback":"التعليقات",
  "Rating":"التقييم","Comment":"التعليق","Note":"ملاحظة","Notes":"ملاحظات",
  "Tag":"علامة","Tags":"العلامات","Label":"التسمية","Color":"اللون","Size":"الحجم",
  "Count":"العدد","Number":"الرقم","Value":"القيمة","Key":"المفتاح",
  "Average":"المتوسط","Avg":"المتوسط","Min":"الحد الأدنى","Max":"الحد الأقصى",
  "Limit":"الحد","Threshold":"العتبة","Range":"النطاق","Level":"المستوى",
  "Priority":"الأولوية","Order":"الأمر","Group":"مجموعة","Batch":"دفعة",
  "Channel":"القناة","Source":"المصدر","Target":"الهدف","Input":"الإدخال",
  "Output":"الإخراج","Result":"النتيجة","Results":"النتائج","Response":"الاستجابة",
  "Request":"الطلب","Requests":"الطلبات","Session":"الجلسة","Sessions":"الجلسات",
  "Market":"السوق","Trend":"الاتجاه","Trends":"الاتجاهات","Demand":"الطلب",
  "Supply":"العرض","Portfolio":"المحفظة","Investment":"الاستثمار","Yield":"العائد",
  "Occupancy":"الإشغال","Offer":"العرض","Offers":"العروض","Deal":"الصفقة",
  "Deals":"الصفقات","Compliance":"الامتثال","Insurance":"التأمين",
  "Marketing":"التسويق","Campaign":"الحملة","Event":"الحدث","Events":"الأحداث",
  "Calendar":"التقويم","Successfully":"بنجاح","successfully":"بنجاح",
  
  // --- Additional missing words ---
  "private":"خاص","public":"عام","visible":"مرهئ","hidden":"مخفي",
  "registered":"مسجل","selected":"محدد","updated":"محدث","created":"تم الإنشاء",
  "deleted":"تم الحذف","removed":"تم الإزالة","uploaded":"تم الرفع",
  "downloaded":"تم التحميل","exported":"تم التصدير","imported":"تم الاستيراد",
  "sent":"تم الإرسال","received":"تم الاستلام","assigned":"تم التعيين",
  "transferred":"تم النقل","approved":"تمت الموافقة","rejected":"تم الرفض",
  "confirmed":"تم التأكيد","generated":"تم التوليد","analyzed":"تم التحليل",
  "processed":"تمت المعالجة","deployed":"تم النشر","resolved":"تم الحل",
  "from":"من","for":"لـ","with":"مع","without":"بدون","by":"بواسطة",
  "and":"و","or":"أو","has been":"تم","have been":"تم","will be":"سيتم",
  "new":"جديد","this":"هذا","that":"ذلك","these":"هذه","manage":"إدارة",
  "monitor":"مراقبة","configure":"تكوين","view":"عرض","create":"إنشاء",
  "delete":"حذف","edit":"تعديل","update":"تحديث","save":"حفظ","cancel":"إلغاء",
  "search":"بحث","filter":"تصفية","loading":"جاري التحميل",
  "processing":"جاري المعالجة","generating":"جاري الإنشاء",
  "failed":"فشل","error":"خطأ","not":"غير","no":"لا","or":"أو","total":"الإجمالي",

  // Commonly remaining in English
  "Governance":"الحوكمة","Operational":"تشغيلي","Operational Logic":"المنطق التشغيلي",
  "Recommendation":"التوصية","Recommended":"الموصى به","Routine":"روتيني",
  "Moderate":"معتدل","Unknown":"غير معروف","Stable":"مستقر","Immediate":"فوري",
  "Duration":"المدة","Component":"المكوّن","Environment":"البيئة","Endpoint":"نقطة النهاية",
  "Metadata":"البيانات الوصفية","Metrics":"المقاييس","Confidence":"الثقة",
  "Probability":"الاحتمال","Satisfaction":"الرضا","Declining":"متراجع",
  "Rising":"صاعد","Neutral":"محايد","Negative":"سلبي","Positive":"إيجابي",
  "Submitted":"تم الإرسال","Routine":"روتيني","Anomalies":"الشذوذ",
  "Staging":"التجهيز","Geofence":"السياج الجغرافي","Geolocation":"تحديد الموقع",
  "Geocoding":"الترميز الجغرافي","Opacity":"الشفافية","Preview":"معاينة",
  "Directions":"الاتجاهات","Provider":"المزود","Quota":"الحصة","Bandwidth":"عرض النطاق",
  "Compute":"الحوسبة","Storage":"التخزين","Memory":"الذاكرة","Networking":"الشبكات",
  "Deploying":"جاري النشر","Monthly":"شهري","Savings":"التوفير",
  "Certificates":"الشهادات","Ambassador":"السفير","Ambassadors":"السفراء",
  "Campaigns":"الحملات","Engagement":"التفاعل","Referrals":"الإحالات",
  "Earnings":"الأرباح","Objective":"الهدف","Paused":"متوقف مؤقتاً",
  "Impression":"مشاهدة","Reach":"الوصول","Budget":"الميزانية","Spent":"المنفق",
  "Renewal":"التجديد","Retention":"الاحتفاظ","Growth":"النمو","Churn":"المغادرة",
  "Enterprise":"المؤسسة","Custom":"مخصص","Branding":"العلامة التجارية",
  "Domain":"النطاق","Detailed":"مفصل","Reporting":"إعداد التقارير",
  "Policy":"السياسة","Policies":"السياسات","Compromised":"مخترق",
  "Battery":"البطارية","Network":"الشبكة","Permissions":"الصلاحيات",
  "Revoked":"تم الإلغاء","Trust":"الثقة","Enforce":"تطبيق",
  "Devices":"الأجهزة","Android":"أندرويد","Desktop":"سطح المكتب",
  "Platform":"المنصة","Online":"متصل","Offline":"غير متصل",
  "Currently":"حالياً","Requirements":"المتطلبات",
  "Authority":"السلطة","Regulatory":"التنظيمي","Violations":"المخالفات",
  "Inspector":"المفتش","Immigration":"الهجرة","Border":"الحدود",
  "Visa":"التأشيرة","Documents":"المستندات","Application":"التطبيق",
  "Registration":"التسجيل","Milestones":"المراحل","Achievement":"الإنجاز",
  "Progress":"التقدم","Investment":"الاستثمار","Projected":"المتوقع",
  "Operational":"تشغيلي","Banking":"المصرفية","Business":"الأعمال",
  "Terms":"الشروط","Conditions":"الأحكام","Privacy":"الخصوصية",
  "Onboarding":"الإعداد الأولي","Variables":"المتغيرات","Duplicate":"نسخ",
  "Template":"القالب","Subject":"الموضوع","Recipients":"المستلمون",
  "Categories":"الفئات","Folders":"المجلدات","Encrypt":"تشفير",
  "Organize":"تنظيم","Public":"عام","Private":"خاص","Visibility":"الرؤية",
  "Sort":"فرز","Filters":"المرشحات","Clear":"مسح","Selected":"محدد",
  "Queued":"في الانتظار","Running":"قيد التشغيل","Incremental":"تزايدي",
  "Frequency":"التكرار","Mapping":"التعيين","Field":"الحقل","Transform":"التحويل",
  "Connection":"الاتصال","Feed":"التغذية","Scraper":"المستخرج",
  "Homeowner":"صاحب المنزل","Invitation":"الدعوة","Credentials":"بيانات الاعتماد",
  "Extinction":"الانقراض","Dinosaur":"ديناصور","Legacy":"القديم","Modern":"حديث",
  "Virtual":"افتراضي","Furniture":"الأثاث","Cinematic":"سينمائي",
  "Reel":"فيديو قصير","Reels":"فيديوهات قصيرة","Tours":"جولات","Tour":"جولة",
  "Scene":"المشهد","Voiceover":"التعليق الصوتي","Parallax":"المنظر",
  "Transitions":"الانتقالات","Motion":"الحركة","Effects":"التأثيرات",
  "Photos":"الصور","Instant":"فوري","Automatic":"تلقائي",
  "within":"خلال","between":"بين","about":"حول","before":"قبل","after":"بعد",
  "into":"إلى","some":"بعض","each":"كل","every":"كل","any":"أي","been":"تم",
  "being":"يتم","using":"باستخدام","based":"بناءً على",
  "coming":"قادم","soon":"قريباً","Coming Soon":"قريباً",
  "need":"بحاجة","needs":"الاحتياجات","attention":"الانتباه",
  "release":"إصدار","releases":"الإصدارات","version":"الإصدار",
  "impact":"التأثير","improve":"تحسين","increase":"زيادة",
  "reduce":"تقليل","identify":"تحديد","specify":"تحديد",
};

function translateText(en: string): string {
  if (!en || en.trim().length === 0) return en;
  if (en.startsWith('{') || en.startsWith('http') || /^[\d.%:+\-\/smhMS]+$/.test(en.trim())) return en;
  if (/^[A-Z_]+$/.test(en.trim()) && en.includes('_')) return en;
  
  // Exact match
  if (D[en.trim()]) return D[en.trim()];
  
  // Word-by-word, longest first
  let result = en;
  const sorted = Object.keys(D).sort((a, b) => b.length - a.length);
  for (const eng of sorted) {
    const escaped = eng.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const regex = new RegExp(`\\b${escaped}\\b`, 'gi');
    result = result.replace(regex, D[eng]);
  }
  return result.replace(/\s+/g, ' ').trim();
}

async function main() {
  const enObj = JSON.parse(await fs.readFile(EN, 'utf-8'));
  const arObj = JSON.parse(await fs.readFile(AR, 'utf-8'));
  let translated = 0, kept = 0, skipped = 0;
  
  function processNode(enNode: any, arNode: any): any {
    if (typeof enNode === 'string') {
      const cur = typeof arNode === 'string' ? arNode : undefined;
      // If already pure Arabic (no Latin chars), keep it
      if (cur && /[\u0600-\u06FF]/.test(cur) && !/[a-zA-Z]/.test(cur)) { kept++; return cur; }
      // Re-translate from English source
      const r = translateText(enNode);
      if (r !== enNode) translated++; else skipped++;
      return r;
    }
    if (typeof enNode === 'object' && enNode !== null && !Array.isArray(enNode)) {
      const result: any = {};
      for (const key of Object.keys(enNode)) {
        result[key] = processNode(enNode[key], arNode?.[key]);
      }
      return result;
    }
    if (Array.isArray(enNode)) {
      return enNode.map((item: any, i: number) => processNode(item, arNode?.[i]));
    }
    return enNode;
  }
  
  const final = processNode(enObj, arObj);
  console.log(`Translated: ${translated}, Kept: ${kept}, Skipped: ${skipped}`);
  await fs.writeFile(AR, JSON.stringify(final, null, 2) + '\n');
  console.log("ar.json updated.");
}

main().catch(console.error);
