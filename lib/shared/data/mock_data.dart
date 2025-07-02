class MockData {
  // بيانات وهمية للمستخدمين
  static const Map<String, dynamic> mockUser = {
    'id': '1',
    'name': 'أحمد محمد',
    'email': 'ahmed@example.com',
    'phone': '+966501234567',
    'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
    'joinDate': '2024-01-15',
    'location': 'الرياض، المملكة العربية السعودية',
  };

  // بيانات وهمية للفئات
  static const List<Map<String, dynamic>> categories = [
    {
      'id': '1',
      'name': 'إلكترونيات',
      'icon': 'phone_android',
      'color': '0xFF2196F3',
      'itemCount': 245,
    },
    {
      'id': '2',
      'name': 'ملابس',
      'icon': 'checkroom',
      'color': '0xFFE91E63',
      'itemCount': 189,
    },
    {
      'id': '3',
      'name': 'طعام ومشروبات',
      'icon': 'restaurant',
      'color': '0xFFFF9800',
      'itemCount': 156,
    },
    {
      'id': '4',
      'name': 'منزل وحديقة',
      'icon': 'home',
      'color': '0xFF4CAF50',
      'itemCount': 98,
    },
    {
      'id': '5',
      'name': 'رياضة وترفيه',
      'icon': 'sports_soccer',
      'color': '0xFF9C27B0',
      'itemCount': 76,
    },
    {
      'id': '6',
      'name': 'كتب وقرطاسية',
      'icon': 'menu_book',
      'color': '0xFF795548',
      'itemCount': 54,
    },
  ];

  // بيانات وهمية للمحلات
  static const List<Map<String, dynamic>> stores = [
    {
      'id': '1',
      'name': 'متجر التقنية الحديثة',
      'description': 'أحدث الأجهزة الإلكترونية والتقنية',
      'logo': 'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=100&h=100&fit=crop',
      'cover': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400&h=200&fit=crop',
      'rating': 4.8,
      'reviewCount': 324,
      'categoryId': '1',
      'location': 'الرياض',
      'isOpen': true,
      'deliveryTime': '30-45 دقيقة',
      'deliveryFee': 15.0,
    },
    {
      'id': '2',
      'name': 'أزياء العصر',
      'description': 'أحدث صيحات الموضة والأزياء',
      'logo': 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=100&h=100&fit=crop',
      'cover': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&h=200&fit=crop',
      'rating': 4.6,
      'reviewCount': 198,
      'categoryId': '2',
      'location': 'جدة',
      'isOpen': true,
      'deliveryTime': '45-60 دقيقة',
      'deliveryFee': 20.0,
    },
    {
      'id': '3',
      'name': 'مطعم الذواقة',
      'description': 'أشهى الأطباق العربية والعالمية',
      'logo': 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=100&h=100&fit=crop',
      'cover': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&h=200&fit=crop',
      'rating': 4.9,
      'reviewCount': 567,
      'categoryId': '3',
      'location': 'الدمام',
      'isOpen': false,
      'deliveryTime': '20-35 دقيقة',
      'deliveryFee': 10.0,
    },
  ];

  // بيانات وهمية للمنتجات
  static const List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'name': 'آيفون 15 برو',
      'description': 'أحدث هاتف من آبل بتقنية متطورة وكاميرا احترافية',
      'price': 4999.0,
      'originalPrice': 5299.0,
      'discount': 6,
      'image': 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=300&h=300&fit=crop',
      'images': [
        'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=300&h=300&fit=crop',
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300&h=300&fit=crop',
        'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=300&h=300&fit=crop',
      ],
      'rating': 4.8,
      'reviewCount': 156,
      'storeId': '1',
      'categoryId': '1',
      'inStock': true,
      'stockCount': 25,
      'features': [
        'شاشة 6.1 بوصة Super Retina XDR',
        'معالج A17 Pro',
        'كاميرا ثلاثية 48 ميجابكسل',
        'مقاوم للماء IP68',
      ],
    },
    {
      'id': '2',
      'name': 'قميص قطني أنيق',
      'description': 'قميص قطني عالي الجودة مناسب للمناسبات الرسمية',
      'price': 149.0,
      'originalPrice': 199.0,
      'discount': 25,
      'image': 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=300&h=300&fit=crop',
      'images': [
        'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=300&h=300&fit=crop',
        'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=300&h=300&fit=crop',
      ],
      'rating': 4.5,
      'reviewCount': 89,
      'storeId': '2',
      'categoryId': '2',
      'inStock': true,
      'stockCount': 15,
      'sizes': ['S', 'M', 'L', 'XL'],
      'colors': ['أبيض', 'أزرق', 'أسود'],
    },
    {
      'id': '3',
      'name': 'وجبة برجر مميزة',
      'description': 'برجر لحم طازج مع البطاطس والمشروب',
      'price': 45.0,
      'originalPrice': 55.0,
      'discount': 18,
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&h=300&fit=crop',
      'images': [
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&h=300&fit=crop',
        'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=300&h=300&fit=crop',
      ],
      'rating': 4.7,
      'reviewCount': 234,
      'storeId': '3',
      'categoryId': '3',
      'inStock': true,
      'stockCount': 50,
      'ingredients': ['لحم طازج', 'خس', 'طماطم', 'جبن', 'صوص خاص'],
    },
  ];

  // بيانات وهمية للطلبات
  static const List<Map<String, dynamic>> orders = [
    {
      'id': 'ORD-001',
      'date': '2024-01-20',
      'status': 'delivered',
      'statusText': 'تم التسليم',
      'total': 234.50,
      'itemCount': 3,
      'storeId': '1',
      'storeName': 'متجر التقنية الحديثة',
      'items': [
        {
          'productId': '1',
          'name': 'آيفون 15 برو',
          'price': 4999.0,
          'quantity': 1,
          'image': 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=100&h=100&fit=crop',
        }
      ],
    },
    {
      'id': 'ORD-002',
      'date': '2024-01-18',
      'status': 'processing',
      'statusText': 'قيد التحضير',
      'total': 89.25,
      'itemCount': 2,
      'storeId': '2',
      'storeName': 'أزياء العصر',
      'items': [
        {
          'productId': '2',
          'name': 'قميص قطني أنيق',
          'price': 149.0,
          'quantity': 1,
          'image': 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=100&h=100&fit=crop',
        }
      ],
    },
  ];

  // بيانات وهمية لسلة التسوق
  static List<Map<String, dynamic>> cartItems = [
    {
      'productId': '1',
      'name': 'آيفون 15 برو',
      'price': 4999.0,
      'quantity': 1,
      'image': 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=100&h=100&fit=crop',
      'storeId': '1',
      'storeName': 'متجر التقنية الحديثة',
    },
    {
      'productId': '2',
      'name': 'قميص قطني أنيق',
      'price': 149.0,
      'quantity': 2,
      'image': 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=100&h=100&fit=crop',
      'storeId': '2',
      'storeName': 'أزياء العصر',
    },
  ];

  // بيانات وهمية للعروض والبانرات
  static const List<Map<String, dynamic>> banners = [
    {
      'id': '1',
      'title': 'عروض الجمعة البيضاء',
      'subtitle': 'خصومات تصل إلى 70%',
      'image': 'https://images.unsplash.com/photo-1607083206869-4c7672e72a8a?w=400&h=200&fit=crop',
      'color': '0xFFE91E63',
    },
    {
      'id': '2',
      'title': 'منتجات جديدة',
      'subtitle': 'اكتشف أحدث المنتجات',
      'image': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=200&fit=crop',
      'color': '0xFF2196F3',
    },
    {
      'id': '3',
      'title': 'توصيل مجاني',
      'subtitle': 'للطلبات أكثر من 200 ريال',
      'image': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=200&fit=crop',
      'color': '0xFF4CAF50',
    },
  ];

  // الدوال المساعدة تم إزالتها بناءً على تعليمات المستخدم لضمان بناء الواجهات المرئية الثابتة فقط.
}


