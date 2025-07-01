# تطبيق سوقنا (Souqna App)

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)

تطبيق سوقنا هو منصة تسوق محلية مطورة باستخدام Flutter تهدف إلى ربط المستهلكين بالمتاجر المحلية في منطقتهم. يوفر التطبيق تجربة تسوق سلسة ومريحة مع واجهات مصادقة متكاملة وتصميم احترافي.

## 📱 المميزات الرئيسية

### 🔐 نظام المصادقة المتكامل
- **تسجيل الدخول**: واجهة بسيطة وآمنة لتسجيل الدخول
- **إنشاء حساب جديد**: عملية تسجيل سهلة مع التحقق من البيانات
- **استعادة كلمة المرور**: نظام آمن لإعادة تعيين كلمة المرور
- **التحقق من البريد الإلكتروني**: تأكيد الهوية عبر البريد الإلكتروني
- **التحقق من رقم الهاتف**: تأكيد رقم الهاتف عبر رسائل SMS
- **إعادة تعيين كلمة المرور**: واجهة آمنة لتغيير كلمة المرور

### 🎨 التصميم والواجهة
- **تصميم عربي**: واجهة مصممة خصيصاً للمستخدمين العرب
- **تجربة مستخدم ممتازة**: تصميم بديهي وسهل الاستخدام
- **ألوان متناسقة**: نظام ألوان احترافي ومريح للعين
- **خطوط عربية**: استخدام خط Cairo الجميل والواضح
- **تصميم متجاوب**: يعمل بشكل مثالي على جميع أحجام الشاشات

### 🛡️ الأمان والحماية
- **تشفير البيانات**: جميع البيانات محمية ومشفرة
- **التحقق من صحة البيانات**: فحص شامل لجميع المدخلات
- **حماية كلمات المرور**: متطلبات قوية لكلمات المرور
- **جلسات آمنة**: إدارة آمنة لجلسات المستخدمين

## 🏗️ البنية التقنية

### التقنيات المستخدمة
- **Flutter 3.6+**: إطار العمل الرئيسي للتطبيق
- **Dart**: لغة البرمجة
- **Supabase**: قاعدة البيانات والخدمات الخلفية
- **Go Router**: نظام التوجيه والملاحة
- **Provider**: إدارة الحالة
- **Google Fonts**: الخطوط العربية

### المكتبات والحزم
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  supabase_flutter: ^2.5.6
  provider: ^6.1.2
  go_router: ^14.2.7
  form_field_validator: ^1.1.0
  google_fonts: ^6.2.1
  flutter_svg: ^2.0.10+1
  shared_preferences: ^2.2.3
  intl: ^0.19.0
```

## 📁 هيكل المشروع

```
lib/
├── main.dart                 # نقطة الدخول الرئيسية
├── config/                   # إعدادات التطبيق
│   ├── app_constants.dart
│   └── supabase_config.dart
├── core/                     # المنطق الأساسي
│   ├── services/
│   │   └── auth_service.dart
│   └── utils/
│       └── validators.dart
├── data/                     # طبقة البيانات
│   ├── models/
│   └── repositories/
├── features/                 # ميزات التطبيق
│   ├── authentication/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── sign_in_screen.dart
│   │   │   │   ├── sign_up_screen.dart
│   │   │   │   ├── forgot_password_screen.dart
│   │   │   │   ├── email_verification_screen.dart
│   │   │   │   ├── phone_verification_screen.dart
│   │   │   │   └── reset_password_screen.dart
│   │   │   └── widgets/
│   │   └── data/
│   └── home/
│       ├── presentation/
│       │   └── screens/
│       │       └── home_screen.dart
│       └── data/
├── shared/                   # المكونات المشتركة
│   ├── widgets/
│   │   ├── custom_text_field.dart
│   │   └── custom_button.dart
│   ├── styles/
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   └── themes/
│       └── app_theme.dart
└── routes/                   # نظام التوجيه
    └── app_router.dart
```

## 🚀 البدء السريع

### المتطلبات الأساسية
- Flutter SDK 3.6.0 أو أحدث
- Dart SDK 3.0.0 أو أحدث
- Android Studio أو VS Code
- حساب Supabase

### خطوات التثبيت

1. **استنساخ المشروع**
```bash
git clone https://github.com/amnassar86/souqna_app.git
cd souqna_app
```

2. **تثبيت التبعيات**
```bash
flutter pub get
```

3. **إعداد Supabase**
   - أنشئ مشروع جديد في [Supabase](https://supabase.com)
   - احصل على URL و Anon Key
   - حدث الملف `lib/config/app_constants.dart`:
```dart
static const String supabaseUrl = 'YOUR_SUPABASE_URL';
static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

4. **تشغيل التطبيق**
```bash
flutter run
```

## 🔧 الإعداد والتكوين

### إعداد Supabase

1. **إنشاء الجداول**
```sql
-- جدول المستخدمين
CREATE TABLE users (
  id UUID REFERENCES auth.users ON DELETE CASCADE,
  full_name TEXT,
  phone TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  PRIMARY KEY (id)
);

-- تفعيل RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- سياسة الأمان
CREATE POLICY "Users can view own profile" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON users
  FOR UPDATE USING (auth.uid() = id);
```

2. **إعداد المصادقة**
   - فعل مقدمي الخدمة المطلوبين
   - اضبط إعدادات البريد الإلكتروني
   - اضبط قوالب الرسائل

### متغيرات البيئة

أنشئ ملف `.env` في جذر المشروع:
```env
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

## 📱 الشاشات والواجهات

### شاشات المصادقة

#### 1. شاشة تسجيل الدخول
- حقول البريد الإلكتروني وكلمة المرور
- التحقق من صحة البيانات
- رابط نسيان كلمة المرور
- رابط إنشاء حساب جديد

#### 2. شاشة إنشاء الحساب
- حقول الاسم الكامل والبريد الإلكتروني وكلمة المرور
- تأكيد كلمة المرور
- الموافقة على الشروط والأحكام
- التحقق من قوة كلمة المرور

#### 3. شاشة استعادة كلمة المرور
- إدخال البريد الإلكتروني
- إرسال رابط إعادة التعيين
- تأكيد الإرسال

#### 4. شاشة التحقق من البريد الإلكتروني
- عرض حالة الإرسال
- إعادة إرسال الرسالة
- تحديث حالة التحقق

#### 5. شاشة التحقق من رقم الهاتف
- إدخال رقم الهاتف
- إرسال رمز التحقق
- إدخال الرمز المستلم
- إعادة الإرسال مع عداد تنازلي

#### 6. شاشة إعادة تعيين كلمة المرور
- إدخال كلمة المرور الجديدة
- تأكيد كلمة المرور
- عرض متطلبات كلمة المرور
- مؤشر قوة كلمة المرور

### شاشة الرئيسية
- ترحيب شخصي بالمستخدم
- عرض معلومات الحساب
- إجراءات سريعة
- زر تسجيل الخروج

## 🎨 دليل التصميم

### نظام الألوان
```dart
// الألوان الأساسية
static const Color primary = Color(0xFF2E7D32);      // أخضر
static const Color primaryLight = Color(0xFF4CAF50);
static const Color primaryDark = Color(0xFF1B5E20);

// الألوان الثانوية
static const Color secondary = Color(0xFFFF9800);    // برتقالي
static const Color secondaryLight = Color(0xFFFFB74D);
static const Color secondaryDark = Color(0xFFE65100);

// ألوان الحالة
static const Color success = Color(0xFF4CAF50);      // نجاح
static const Color error = Color(0xFFE53935);        // خطأ
static const Color warning = Color(0xFFFF9800);      // تحذير
static const Color info = Color(0xFF2196F3);         // معلومات
```

### الخطوط والنصوص
- **الخط الأساسي**: Cairo (Google Fonts)
- **أحجام العناوين**: 32px, 28px, 24px, 20px, 18px, 16px
- **النصوص العادية**: 16px, 14px, 12px
- **ارتفاع السطر**: 1.2 - 1.5 حسب النوع

### المسافات والأبعاد
```dart
static const double defaultPadding = 16.0;
static const double smallPadding = 8.0;
static const double largePadding = 24.0;
static const double borderRadius = 12.0;
static const double buttonHeight = 56.0;
```

## 🔒 الأمان والحماية

### حماية كلمات المرور
- الحد الأدنى: 8 أحرف
- يجب أن تحتوي على:
  - حرف كبير واحد على الأقل
  - حرف صغير واحد على الأقل
  - رقم واحد على الأقل

### التحقق من البيانات
- فحص صيغة البريد الإلكتروني
- التحقق من أرقام الهواتف السعودية
- فحص الأسماء (أحرف عربية وإنجليزية فقط)
- منع الحقول الفارغة

### الجلسات والمصادقة
- استخدام JWT tokens آمنة
- انتهاء صلاحية الجلسات
- تسجيل خروج تلقائي عند انتهاء الصلاحية

## 🧪 الاختبار

### اختبار الوحدة
```bash
flutter test
```

### اختبار التكامل
```bash
flutter test integration_test/
```

### اختبار الواجهة
- اختبار جميع شاشات المصادقة
- التحقق من التوجيه الصحيح
- اختبار التحقق من البيانات

## 📦 البناء والنشر

### بناء التطبيق للأندرويد
```bash
flutter build apk --release
```

### بناء التطبيق لـ iOS
```bash
flutter build ios --release
```

### إعداد التوقيع
1. **أندرويد**: إعداد keystore
2. **iOS**: إعداد certificates و provisioning profiles

## 🤝 المساهمة

نرحب بمساهماتكم! يرجى اتباع الخطوات التالية:

1. Fork المشروع
2. أنشئ branch جديد (`git checkout -b feature/amazing-feature`)
3. Commit التغييرات (`git commit -m 'Add amazing feature'`)
4. Push إلى البranch (`git push origin feature/amazing-feature`)
5. افتح Pull Request

### معايير الكود
- اتبع [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- استخدم أسماء متغيرات واضحة
- اكتب تعليقات للكود المعقد
- اختبر الكود قبل الإرسال

## 📄 الترخيص

هذا المشروع مرخص تحت رخصة MIT - راجع ملف [LICENSE](LICENSE) للتفاصيل.

## 📞 التواصل والدعم

- **المطور**: فريق سوقنا
- **البريد الإلكتروني**: support@souqna.app
- **الموقع**: [www.souqna.app](https://www.souqna.app)

## 🙏 شكر وتقدير

- فريق Flutter لإطار العمل الرائع
- فريق Supabase للخدمات الخلفية
- مجتمع المطورين العرب للدعم والمساعدة

---

**ملاحظة**: هذا المشروع في مرحلة التطوير النشط. قد تتغير بعض الميزات أو تتم إضافة ميزات جديدة.

## 📋 قائمة المهام

- [x] إعداد البنية الأساسية
- [x] تطوير شاشات المصادقة
- [x] تكامل Supabase
- [x] تصميم الواجهات
- [ ] إضافة شاشات المتاجر
- [ ] تطوير نظام الطلبات
- [ ] إضافة نظام الدفع
- [ ] تطوير لوحة التحكم للتجار
- [ ] إضافة الإشعارات
- [ ] تطوير API للتطبيق

## 🔄 سجل التحديثات

### الإصدار 1.0.0 (قيد التطوير)
- ✅ نظام المصادقة الكامل
- ✅ واجهات المستخدم الأساسية
- ✅ تكامل قاعدة البيانات
- ✅ نظام التوجيه
- ✅ التحقق من البيانات

### الإصدارات القادمة
- 🔄 نظام المتاجر والمنتجات
- 🔄 نظام الطلبات والدفع
- 🔄 لوحة تحكم التجار
- 🔄 نظام التقييمات والمراجعات

