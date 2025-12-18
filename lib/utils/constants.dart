import 'package:flutter/material.dart';

class AppConstants {
  // ========== APP INFO ==========
  static const String appName = 'SpendList';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String appDescription = 'Aplikasi Catatan Keuangan Pribadi';
  static const String appDeveloper = 'Flutter UAS';

  // ========== API CONSTANTS ==========
  static const String apiBaseUrl = 'https://mocki.io/v1';
  static const String apiExpensesEndpoint = '/dummy/expenses';
  static const String apiCurrencyEndpoint =
      'https://api.exchangerate-api.com/v4/latest/IDR';
  static const int apiTimeoutSeconds = 30;
  static const int apiRetryAttempts = 3;

  // Mock API endpoints for testing
  static const Map<String, String> mockEndpoints = {
    'expenses': 'https://mocki.io/v1/dummy/expenses',
    'categories': 'https://mocki.io/v1/dummy/categories',
    'currency': 'https://api.exchangerate-api.com/v4/latest/IDR',
  };

  // ========== SHARED PREFERENCES KEYS ==========
  static const String prefExpensesKey = 'expenses';
  static const String prefBudgetKey = 'monthly_budget';
  static const String prefThemeKey = 'is_dark_mode';
  static const String prefCurrencyKey = 'currency';
  static const String prefCategoriesKey = 'categories';
  static const String prefUsernameKey = 'username';
  static const String prefEmailKey = 'email';
  static const String prefLoggedInKey = 'isLoggedIn';
  static const String prefOnboardingKey = 'onboarding_completed';
  static const String prefFirstLaunchKey = 'first_launch';
  static const String prefNotificationKey = 'notifications_enabled';
  static const String prefBiometricKey = 'biometric_enabled';
  static const String prefLanguageKey = 'language';

  // ========== CURRENCY OPTIONS ==========
  static const List<Map<String, dynamic>> currencyOptions = [
    {
      'code': 'IDR',
      'symbol': 'Rp',
      'name': 'Rupiah Indonesia',
      'locale': 'id_ID',
    },
    {
      'code': 'USD',
      'symbol': '\$',
      'name': 'US Dollar',
      'locale': 'en_US',
    },
    {
      'code': 'EUR',
      'symbol': '€',
      'name': 'Euro',
      'locale': 'de_DE',
    },
    {
      'code': 'JPY',
      'symbol': '¥',
      'name': 'Japanese Yen',
      'locale': 'ja_JP',
    },
    {
      'code': 'SGD',
      'symbol': 'S\$',
      'name': 'Singapore Dollar',
      'locale': 'en_SG',
    },
    {
      'code': 'MYR',
      'symbol': 'RM',
      'name': 'Malaysian Ringgit',
      'locale': 'ms_MY',
    },
    {
      'code': 'THB',
      'symbol': '฿',
      'name': 'Thai Baht',
      'locale': 'th_TH',
    },
  ];

  // ========== DEFAULT CATEGORIES ==========
  static List<Map<String, dynamic>> get defaultCategories => [
        {
          'id': '1',
          'name': 'Makanan',
          'icon': Icons.restaurant.codePoint,
          'color': Colors.orange.value,
          'type': 'expense',
          'budget': 0.0,
        },
        {
          'id': '2',
          'name': 'Transportasi',
          'icon': Icons.directions_car.codePoint,
          'color': Colors.blue.value,
          'type': 'expense',
          'budget': 0.0,
        },
        {
          'id': '3',
          'name': 'Belanja',
          'icon': Icons.shopping_cart.codePoint,
          'color': Colors.purple.value,
          'type': 'expense',
          'budget': 0.0,
        },
        {
          'id': '4',
          'name': 'Hiburan',
          'icon': Icons.movie.codePoint,
          'color': Colors.pink.value,
          'type': 'expense',
          'budget': 0.0,
        },
        {
          'id': '5',
          'name': 'Kesehatan',
          'icon': Icons.local_hospital.codePoint,
          'color': Colors.green.value,
          'type': 'expense',
          'budget': 0.0,
        },
        {
          'id': '6',
          'name': 'Pendidikan',
          'icon': Icons.school.codePoint,
          'color': Colors.teal.value,
          'type': 'expense',
          'budget': 0.0,
        },
        {
          'id': '7',
          'name': 'Tagihan',
          'icon': Icons.receipt.codePoint,
          'color': Colors.red.value,
          'type': 'expense',
          'budget': 0.0,
        },
        {
          'id': '8',
          'name': 'Gaji',
          'icon': Icons.attach_money.codePoint,
          'color': Colors.green.value,
          'type': 'income',
          'budget': 0.0,
        },
        {
          'id': '9',
          'name': 'Investasi',
          'icon': Icons.trending_up.codePoint,
          'color': Colors.blue.value,
          'type': 'income',
          'budget': 0.0,
        },
        {
          'id': '10',
          'name': 'Lainnya',
          'icon': Icons.more_horiz.codePoint,
          'color': Colors.grey.value,
          'type': 'both',
          'budget': 0.0,
        },
      ];

  // ========== DATE & TIME FORMATS ==========
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String monthYearFormat = 'MMMM yyyy';
  static const String dayMonthFormat = 'dd MMMM';
  static const String apiDateFormat = 'yyyy-MM-dd';
  static const String apiDateTimeFormat = 'yyyy-MM-ddTHH:mm:ssZ';

  // ========== DEFAULT VALUES ==========
  static const double defaultMonthlyBudget = 5000000.0;
  static const String defaultCurrency = 'IDR';
  static const String defaultLanguage = 'id';
  static const bool defaultDarkMode = false;
  static const bool defaultNotifications = true;
  static const bool defaultBiometric = false;

  // ========== LIMITS & VALIDATION ==========
  static const double minTransactionAmount = 100.0;
  static const double maxTransactionAmount = 1000000000.0;
  static const int maxTitleLength = 100;
  static const int maxNoteLength = 500;
  static const int maxCategoryNameLength = 30;
  static const int maxExpensesPerMonth = 1000;

  // ========== COLORS ==========
  static const Color primaryColor = Color(0xFF2196F3); // Blue
  static const Color secondaryColor = Color(0xFF03A9F4); // Light Blue
  static const Color accentColor = Color(0xFF00BCD4); // Cyan
  static const Color successColor = Color(0xFF4CAF50); // Green
  static const Color errorColor = Color(0xFFF44336); // Red
  static const Color warningColor = Color(0xFFFF9800); // Orange
  static const Color infoColor = Color(0xFF2196F3); // Blue
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light Grey

  // Category Colors
  static const List<Color> categoryColors = [
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.green,
    Colors.teal,
    Colors.red,
    Colors.blueGrey,
    Colors.deepPurple,
    Colors.cyan,
    Colors.lightGreen,
    Colors.amber,
    Colors.deepOrange,
    Colors.indigo,
    Colors.lightBlue,
    Colors.brown,
  ];

  // ========== DIMENSIONS ==========
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultRadius = 12.0;
  static const double smallRadius = 8.0;
  static const double largeRadius = 16.0;
  static const double buttonHeight = 48.0;
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 56.0;

  // ========== ANIMATION DURATIONS ==========
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration snackbarDuration = Duration(seconds: 3);
  static const Duration tooltipDuration = Duration(milliseconds: 1500);

  // ========== TEXT STYLES ==========
  static TextStyle heading1 = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static TextStyle heading2 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static TextStyle heading3 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle titleLarge = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle titleMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static TextStyle titleSmall = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static TextStyle bodyLarge = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle bodySmall = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle caption = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: Colors.grey,
  );

  static TextStyle button = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  // ========== ROUTES ==========
  static const String routeHome = '/';
  static const String routeSplash = '/splash';
  static const String routeExpenses = '/expenses';
  static const String routeExpenseDetail = '/expense-detail';
  static const String routeAddExpense = '/add-expense';
  static const String routeEditExpense = '/edit-expense';
  static const String routeSettings = '/settings';
  static const String routeCategories = '/categories';
  static const String routeStatistics = '/statistics';
  static const String routeReports = '/reports';
  static const String routeProfile = '/profile';

  // ========== ASSETS PATHS ==========
  static const String assetImages = 'assets/images/';
  static const String assetIcons = 'assets/icons/';
  static const String assetJson = 'assets/json/';
  static const String assetFonts = 'assets/fonts/';

  // ========== ERROR MESSAGES ==========
  static const String errorNetwork = 'Tidak ada koneksi internet';
  static const String errorServer = 'Terjadi kesalahan pada server';
  static const String errorTimeout = 'Koneksi timeout';
  static const String errorUnauthorized = 'Anda harus login terlebih dahulu';
  static const String errorNotFound = 'Data tidak ditemukan';
  static const String errorValidation = 'Data tidak valid';
  static const String errorUnknown = 'Terjadi kesalahan yang tidak diketahui';

  // ========== SUCCESS MESSAGES ==========
  static const String successSave = 'Data berhasil disimpan';
  static const String successUpdate = 'Data berhasil diperbarui';
  static const String successDelete = 'Data berhasil dihapus';
  static const String successLogin = 'Login berhasil';
  static const String successLogout = 'Logout berhasil';
  static const String successExport = 'Data berhasil diexport';

  // ========== OTHER CONSTANTS ==========
  static const List<String> monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  static const List<String> dayNames = [
    'Minggu',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu'
  ];

  static const List<int> years = [2023, 2024, 2025];

  // Database constants
  static const String dbName = 'spendlist.db';
  static const int dbVersion = 1;

  // Notification constants
  static const String notificationChannelId = 'spendlist_channel';
  static const String notificationChannelName = 'SpendList Notifications';
  static const String notificationChannelDescription =
      'Notifications for SpendList app';

  // Feature flags
  static const bool enableDarkMode = true;
  static const bool enableBiometric = false;
  static const bool enableCloudSync = false;
  static const bool enableBackup = true;
  static const bool enableStatistics = true;
  static const bool enableReports = true;
}
