import 'package:flutter/material.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../shared/styles/app_text_styles.dart';
import '../../../../shared/widgets/product_card.dart';
import '../../../../shared/widgets/store_card.dart';
import '../../../../shared/data/mock_data.dart';
import '../../../../config/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  int _currentBannerIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // شريط التطبيق المخصص
            _buildCustomAppBar(),
            
            // شريط البحث
            _buildSearchBar(),
            
            // البانرات الترويجية
            _buildPromoBanners(),
            
            // الفئات الرئيسية
            _buildCategoriesSection(),
            
            // المحلات المميزة
            _buildFeaturedStores(),
            
            // المنتجات الأكثر مبيعاً
            _buildBestSellingProducts(),
            
            // مساحة إضافية في النهاية
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCustomAppBar() {
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
                  // فتح القائمة الجانبية
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('القائمة الجانبية قريباً')),
                  );
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
                      // فتح الإشعارات
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('الإشعارات قريباً')),
                      );
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

  Widget _buildSearchBar() {
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
            controller: _searchController,
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
                  // فتح الفلاتر
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('الفلاتر قريباً')),
                  );
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
            onSubmitted: (value) {
              // تنفيذ البحث
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('البحث عن: $value')),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanners() {
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

  Widget _buildCategoriesSection() {
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
                    // عرض جميع الفئات
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('عرض جميع الفئات قريباً')),
                    );
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
          Container(
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

  Widget _buildFeaturedStores() {
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
                    // عرض جميع المحلات
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('عرض جميع المحلات قريباً')),
                    );
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
          Container(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
              itemCount: MockData.stores.length,
              itemBuilder: (context, index) {
                final store = MockData.stores[index];
                return Container(
                  width: 250,
                  margin: const EdgeInsets.only(right: AppConstants.smallPadding),
                  child: StoreCard(
                    store: store,
                    onTap: () {
                      // فتح صفحة المتجر
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('فتح متجر: ${store['name']}')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestSellingProducts() {
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
                  'الأكثر مبيعاً',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // عرض جميع المنتجات
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('عرض جميع المنتجات قريباً')),
                    );
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
          Container(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
              itemCount: MockData.products.length,
              itemBuilder: (context, index) {
                final product = MockData.products[index];
                return Container(
                  width: 180,
                  margin: const EdgeInsets.only(right: AppConstants.smallPadding),
                  child: ProductCard(
                    product: product,
                    onTap: () {
                      // فتح صفحة المنتج
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('فتح منتج: ${product['name']}')),
                      );
                    },
                    onAddToCart: () {
                      // إضافة للسلة
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم إضافة ${product['name']} للسلة')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.caption.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.caption,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'الفئات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'السلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'المفضلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الملف الشخصي',
          ),
        ],
        onTap: (index) {
          // التنقل بين الصفحات
          switch (index) {
            case 0:
              // الرئيسية (الصفحة الحالية)
              break;
            case 1:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('صفحة الفئات قريباً')),
              );
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('صفحة السلة قريباً')),
              );
              break;
            case 3:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('صفحة المفضلة قريباً')),
              );
              break;
            case 4:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('الملف الشخصي قريباً')),
              );
              break;
          }
        },
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'phone_android':
        return Icons.phone_android;
      case 'checkroom':
        return Icons.checkroom;
      case 'restaurant':
        return Icons.restaurant;
      case 'home':
        return Icons.home;
      case 'sports_soccer':
        return Icons.sports_soccer;
      case 'menu_book':
        return Icons.menu_book;
      default:
        return Icons.category;
    }
  }
}

