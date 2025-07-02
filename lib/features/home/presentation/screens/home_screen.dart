import 'package:flutter/material.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../shared/styles/app_text_styles.dart';
import '../../../../shared/widgets/product_card.dart';
import '../../../../shared/widgets/store_card.dart';
import '../../../../shared/data/mock_data.dart';
import '../../../../config/app_constants.dart';
// import 'package:go_router/go_router.dart'; // تم التعليق بناءً على تعليمات المستخدم

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _searchController = TextEditingController(); // تم التعليق بناءً على تعليمات المستخدم
  // int _currentBannerIndex = 0; // تم التعليق بناءً على تعليمات المستخدم

  @override
  void dispose() {
    // _searchController.dispose(); // تم التعليق بناءً على تعليمات المستخدم
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const SafeArea(
        child: CustomScrollView(
          slivers: [
            // شريط التطبيق المخصص
            _CustomAppBar(),
            
            // شريط البحث
            _SearchBar(),
            
            // البانرات الترويجية
            _PromoBanners(),
            
            // الفئات الرئيسية
            _CategoriesSection(),
            
            // المحلات المميزة
            _FeaturedStores(),
            
            // المنتجات الأكثر مبيعاً
            _BestSellingProducts(),
            
            // مساحة إضافية في النهاية
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavigationBar(),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          children: [
            // أيقونة القائمة
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('القائمة الجانبية قريباً')),
                  // );
                  print('القائمة الجانبية قريباً');
                },
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // معلومات الموقع
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التوصيل إلى',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'الرياض، حي النخيل',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // أيقونة الإشعارات
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('الإشعارات قريباً')),
                      // );
                      print('الإشعارات قريباً');
                    },
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  // نقطة الإشعار
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: AppConstants.smallPadding,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            // controller: _searchController, // تم التعليق بناءً على تعليمات المستخدم
            decoration: InputDecoration(
              hintText: 'ابحث عن المنتجات والمحلات...',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('الفلاتر قريباً')),
                  // );
                  print('الفلاتر قريباً');
                },
                icon: const Icon(
                  Icons.tune,
                  color: AppColors.primary,
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            // onSubmitted: (value) { // تم التعليق بناءً على تعليمات المستخدم
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text('البحث عن: $value')),
            //   );
            // },
          ),
        ),
      ),
    );
  }
}

class _PromoBanners extends StatefulWidget {
  const _PromoBanners();

  @override
  State<_PromoBanners> createState() => _PromoBannersState();
}

class _PromoBannersState extends State<_PromoBanners> {
  int _currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: AppConstants.smallPadding),
        child: PageView.builder(
          itemCount: MockData.banners.length,
          onPageChanged: (index) {
            setState(() {
              _currentBannerIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final banner = MockData.banners[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                gradient: LinearGradient(
                  colors: [
                    Color(banner['color'] as int),
                    Color(banner['color'] as int).withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(banner['color'] as int).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // صورة الخلفية
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      child: Image.network(
                        banner['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(banner['color'] as int).withOpacity(0.3),
                          );
                        },
                      ),
                    ),
                  ),
                  // تدرج للنص
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  // النص
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner['title'],
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          banner['subtitle'],
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textOnPrimary.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان القسم
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
                Text(
                  'تسوق حسب الفئة',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('عرض جميع الفئات قريباً')),
                    // );
                    print('عرض جميع الفئات قريباً');
                  },
                  child: Text(
                    'عرض الكل',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // شبكة الفئات
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
              itemCount: MockData.categories.length,
              itemBuilder: (context, index) {
                final category = MockData.categories[index];
                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: AppConstants.smallPadding),
                  child: Column(
                    children: [
                      // أيقونة الفئة
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(category['color'] as int).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          _getIconData(category['icon']),
                          size: 28,
                          color: Color(category['color'] as int),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // اسم الفئة
                      Text(
                        category['name'],
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      // عدد العناصر
                      Text(
                        '${category['itemCount']} منتج',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'fastfood':
        return Icons.fastfood;
      case 'local_grocery_store':
        return Icons.local_grocery_store;
      case 'local_pharmacy':
        return Icons.local_pharmacy;
      case 'bakery_dining':
        return Icons.bakery_dining;
      case 'pets':
        return Icons.pets;
      case 'more_horiz':
        return Icons.more_horiz;
      default:
        return Icons.category;
    }
  }
}

class _FeaturedStores extends StatelessWidget {
  const _FeaturedStores();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان القسم
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
                Text(
                  'المحلات المميزة',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('عرض جميع المحلات قريباً')),
                    // );
                    print('عرض جميع المحلات قريباً');
                  },
                  child: Text(
                    'عرض الكل',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // قائمة المحلات
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
              itemCount: MockData.stores.length,
              itemBuilder: (context, index) {
                final store = MockData.stores[index];
                return StoreCard(
                  storeName: store['name'],
                  storeImage: store['image'],
                  rating: store['rating'].toDouble(),
                  deliveryTime: store['deliveryTime'],
                  onTap: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('الذهاب إلى ${store['name']} قريباً')),
                    // );
                    print('الذهاب إلى ${store['name']} قريباً');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BestSellingProducts extends StatelessWidget {
  const _BestSellingProducts();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان القسم
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
                Text(
                  'المنتجات الأكثر مبيعاً',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('عرض جميع المنتجات قريباً')),
                    // );
                    print('عرض جميع المنتجات قريباً');
                  },
                  child: Text(
                    'عرض الكل',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // شبكة المنتجات
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppConstants.defaultPadding,
              mainAxisSpacing: AppConstants.defaultPadding,
              childAspectRatio: 0.7,
            ),
            itemCount: MockData.products.length,
            itemBuilder: (context, index) {
              final product = MockData.products[index];
              return ProductCard(
                productName: product['name'],
                productImage: product['image'],
                price: product['price'].toDouble(),
                rating: product['rating'].toDouble(),
                onTap: () {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('الذهاب إلى ${product['name']} قريباً')),
                  // );
                  print('الذهاب إلى ${product['name']} قريباً');
                },
                onAddToCart: () {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('إضافة ${product['name']} إلى السلة (محاكاة)')),
                  // );
                  print('إضافة ${product['name']} إلى السلة (محاكاة)');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      selectedLabelStyle: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: AppTextStyles.caption,
      currentIndex: 0, // دائمًا 0 للشاشة الرئيسية الثابتة
      onTap: (index) {
        // String route = AppConstants.homeRoute; // تم التعليق بناءً على تعليمات المستخدم
        // switch (index) { // تم التعليق بناءً على تعليمات المستخدم
        //   case 0:
        //     route = AppConstants.homeRoute;
        //     break;
        //   case 1:
        //     route = AppConstants.categoriesRoute; // سيتم تعريف هذا المسار لاحقاً
        //     break;
        //   case 2:
        //     route = AppConstants.cartRoute; // سيتم تعريف هذا المسار لاحقاً
        //     break;
        //   case 3:
        //     route = AppConstants.profileRoute; // سيتم تعريف هذا المسار لاحقاً
        //     break;
        // }
        // GoRouter.of(context).go(route); // تم التعليق بناءً على تعليمات المستخدم
        print('تم النقر على عنصر التنقل رقم $index');
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          activeIcon: Icon(Icons.category),
          label: 'الفئات',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'السلة',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'الحساب',
        ),
      ],
    );
  }
}


