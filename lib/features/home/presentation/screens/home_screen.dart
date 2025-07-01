import 'package:flutter/material.dart';
import '../../../../config/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../routes/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  Future<void> _signOut() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService.signOut();
      if (mounted) {
        AppRouter.goToSignIn(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء تسجيل الخروج: $e'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(AppConstants.defaultPadding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.getCurrentUser();
    final userName = user?.userMetadata?['full_name'] ?? 'المستخدم';

    return Scaffold(
      appBar: AppBar(
        title: const Text('سوقنا'),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
            tooltip: 'تسجيل الخروج',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Section
              Container(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: AppColors.textOnPrimary,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: AppConstants.defaultPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'مرحباً، $userName',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.textOnPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'أهلاً بك في سوقنا',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.textOnPrimary.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.largePadding),
              
              // User Info Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'معلومات الحساب',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      _buildInfoRow(
                        context,
                        'البريد الإلكتروني',
                        user?.email ?? 'غير متوفر',
                        Icons.email_outlined,
                      ),
                      const Divider(height: AppConstants.largePadding),
                      _buildInfoRow(
                        context,
                        'الاسم الكامل',
                        userName,
                        Icons.person_outline,
                      ),
                      const Divider(height: AppConstants.largePadding),
                      _buildInfoRow(
                        context,
                        'تاريخ الانضمام',
                        user?.createdAt != null 
                            ? '${DateTime.parse(user!.createdAt).day}/${DateTime.parse(user.createdAt).month}/${DateTime.parse(user.createdAt).year}'
                            : 'غير متوفر',
                        Icons.calendar_today_outlined,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: AppConstants.largePadding),
              
              // Quick Actions
              Text(
                'الإجراءات السريعة',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
              
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      context,
                      'المتاجر',
                      Icons.store,
                      () {
                        // TODO: Navigate to stores
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('قريباً...')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppConstants.defaultPadding),
                  Expanded(
                    child: _buildActionCard(
                      context,
                      'المنتجات',
                      Icons.shopping_bag,
                      () {
                        // TODO: Navigate to products
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('قريباً...')),
                        );
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
              
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      context,
                      'الطلبات',
                      Icons.receipt_long,
                      () {
                        // TODO: Navigate to orders
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('قريباً...')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppConstants.defaultPadding),
                  Expanded(
                    child: _buildActionCard(
                      context,
                      'الملف الشخصي',
                      Icons.settings,
                      () {
                        // TODO: Navigate to profile
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('قريباً...')),
                        );
                      },
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Sign Out Button
              CustomButton(
                text: 'تسجيل الخروج',
                onPressed: _signOut,
                isLoading: _isLoading,
                type: ButtonType.outline,
                icon: const Icon(Icons.logout),
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: AppConstants.defaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(height: AppConstants.smallPadding),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

