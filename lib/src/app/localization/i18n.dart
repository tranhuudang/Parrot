import 'package:i18n_extension/i18n_extension.dart';

extension Localization on Object {
  /// Step to localization using i18n_extension package:
  /// 1: install package i18n_extension and flutter_localization
  ///   # localization
  ///   flutter_localization: ^0.1.14
  ///   flutter_localizations:
  ///     sdk: flutter
  ///   i18n_extension: ^10.0.1
  /// 2: in main.dart, setup localizationDelegates and supportedLocales:
  /// MaterialApp(
  ///       localizationsDelegates: const [
  ///         GlobalMaterialLocalizations.delegate,
  ///         GlobalWidgetsLocalizations.delegate,
  ///         GlobalCupertinoLocalizations.delegate,
  ///       ],
  ///       supportedLocales: const [
  ///         Locale('en', "US"),
  ///         Locale('vi', "VI"),
  ///       ],
  /// 3: create a extension Localization on String like this file
  /// 4: import this localization file to the target .dart file and use .i18n after the text that you want to translate.
  // "": {
  // "en_us": "",
  // "vi_vi": "",
  // },

  static final _t = Translations.byId<Object>('en_us', {
    'Have feedback or suggestions for us?': {
      'en_us': 'Have feedback or suggestions for us?',
      'vi_vi': 'Bạn có góp ý hoặc đề xuất cho chúng tôi không?',
      'zh_cn': '对我们有反馈或建议吗？'
    },
    "What's new?": {
      'en_us': "What's new?",
      'vi_vi': 'Có gì mới?',
      'zh_cn': '有什么新内容？'
    },
    'Feedback': {'en_us': 'Feedback', 'vi_vi': 'Góp ý', 'zh_cn': '反馈'},
    'Type your report here': {
      'en_us': 'Type your report here',
      'vi_vi': 'Nhập phản hồi của bạn tại đây',
      'zh_cn': '在此输入您的报告'
    },
    'Rate us': {'en_us': 'Rate us', 'vi_vi': 'Đánh giá', 'zh_cn': '给我们评分'},
    "We'd love to hear your feedback!": {
      'en_us': "We'd love to hear your feedback!",
      'vi_vi': 'Chúng tôi rất muốn nghe phản hồi của bạn!',
      'zh_cn': '我们很想听到您的反馈！'
    },
    'All rights reserved.': {
      'en_us': 'All rights reserved.',
      'vi_vi': 'Mọi quyền được bảo lưu.',
      'zh_cn': '版权所有。'
    },
    'Available at': {
      'en_us': 'Available at',
      'vi_vi': 'Đã có mặt ở',
      'zh_cn': '可用于'
    },
    'About': {'en_us': 'About', 'vi_vi': 'Thông tin', 'zh_cn': '关于'},
    'Restore the settings to their default as when the application was first installed.':
        {
      'en_us':
          'Restore the settings to their default as when the application was first installed.',
      'vi_vi':
          'Khôi phục các thiết lập về cài đặt mặc định như lúc ứng dụng mới được cài đặt lần đầu.',
      'zh_cn': '将设置恢复为应用程序首次安装时的默认值。'
    },
    'Default settings are restored': {
      'en_us': 'Default settings are restored',
      'vi_vi': 'Đã khôi mục cài đặt về mặc định',
      'zh_cn': '默认设置已恢复'
    },
    'Reset to default settings': {
      'en_us': 'Reset to default settings',
      'vi_vi': 'Khôi phục cài đặt gốc',
      'zh_cn': '恢复默认设置'
    },
    'Copied to clipboard': {
      'en_us': 'Copied to clipboard',
      'vi_vi': 'Đã sao chép vào bộ nhớ tạm',
      'zh_cn': '已复制到剪贴板'
    },
    'Licenses': {'en_us': 'Licenses', 'vi_vi': 'Giấy phép', 'zh_cn': '许可证'},
    'DescriptionTextForLicenses': {
      'en_us':
          'Our app utilizes various open-source libraries. Here, you can view the licenses and attributions for the third-party software integrated into our product.',
      'vi_vi':
          'Ứng dụng của chúng tôi sử dụng nhiều thư viện mã nguồn mở. Tại đây, bạn có thể xem các giấy phép và sự ghi nhận cho phần mềm của bên thứ ba được tích hợp vào sản phẩm của chúng tôi.',
      'zh_cn': '我们的应用程序使用了各种开源库。在这里，您可以查看集成到我们产品中的第三方软件的许可证和归属。'
    },
    'Release notes': {
      'en_us': 'Release notes',
      'vi_vi': 'Thông tin phiên bản',
      'zh_cn': '发布说明'
    },
    'System default': {
      'en_us': 'System default',
      'vi_vi': 'Tự động',
      'zh_cn': '系统默认'
    },
    'English': {'en_us': 'English', 'vi_vi': 'English', 'zh_cn': '英语'},
    'Tiếng Việt': {
      'en_us': 'Tiếng Việt',
      'vi_vi': 'Tiếng Việt',
      'zh_cn': '越南语'
    },
    'Use System Theme': {
      'en_us': 'Use System Theme',
      'vi_vi': 'Sử dụng chủ đề hệ thống',
      'zh_cn': '使用系统主题'
    },
    'Accent color': {
      'en_us': 'Accent color',
      'vi_vi': 'Tông màu',
      'zh_cn': '强调色'
    },
    'DesciptionTextForPrivacyPolicy': {
      'en_us':
          'We hold your privacy in high regard and assure you that your personal data will not be disclosed to any third party.',
      'vi_vi':
          'Chúng tôi tôn trọng quyền riêng tư của bạn và cam kết dữ liệu cá nhân của bạn sẽ không được chia sẻ với bất cứ bên thứ ba nào cả.',
      'zh_cn': '我们高度重视您的隐私，并向您保证您的个人数据不会被透露给任何第三方。'
    },
    'For more information about our privacy policy, please visit:': {
      'en_us': 'For more information about our privacy policy, please visit:',
      'vi_vi':
          'Để biết thêm chi tiết về điều khoản riêng tư, vui lòng truy cập:',
      'zh_cn': '有关隐私政策的更多信息，请访问：'
    },
    'Privacy Policy': {
      'en_us': 'Privacy Policy',
      'vi_vi': 'Điều khoản',
      'zh_cn': '隐私政策'
    },
    'Settings': {'en_us': 'Settings', 'vi_vi': 'Cài đặt', 'zh_cn': '设置'},
    '* The changes will become effective the next time you open the app.': {
      'en_us':
          'Note: The changes will become effective the next time you open the app.',
      'vi_vi':
          'Ghi chú: Những thay đổi sẽ có hiệu lực vào lần tiếp theo bạn mở ứng dụng.',
      'zh_cn': '注意：更改将在您下次打开应用程序时生效。'
    },
    'Common': {'en_us': 'Common', 'vi_vi': 'Cài đặt chung', 'zh_cn': '通用'},
    'Language': {'en_us': 'Language', 'vi_vi': 'Ngôn ngữ', 'zh_cn': '语言'},
    'Select a language': {
      'en_us': 'Select a language',
      'vi_vi': 'Chọn một ngôn ngữ',
      'zh_cn': '选择一种语言'
    },
    'Light mode': {'en_us': 'Light', 'vi_vi': 'Sáng', 'zh_cn': '浅色模式'},
    'Dark mode': {'en_us': 'Dark', 'vi_vi': 'Tối', 'zh_cn': '深色模式'},
    'Adaptive': {'en_us': 'Adaptive', 'vi_vi': 'Tự động', 'zh_cn': '自适应'},
    'Theme': {'en_us': 'Theme', 'vi_vi': 'Giao diện', 'zh_cn': '主题'},
    'Customize': {'en_us': 'Customize', 'vi_vi': 'Tùy chỉnh', 'zh_cn': '自定义'},
    'Preferences': {
      'en_us': 'Preferences',
      'vi_vi': 'Tùy chỉnh',
      'zh_cn': '偏好设置'
    },
    'Help Us Improve': {
      'en_us': 'Help Us Improve',
      'vi_vi': 'Phản hồi',
      'zh_cn': '帮助我们改进'
    },
    'If something isn’t working as expected, we’d like to know. Share your feedback on how we can improve or let us know what you enjoy about our app.':
        {
      'en_us':
          "If something isn’t working as expected, we’d like to know. Share your feedback on how we can improve or let us know what you enjoy about our app.",
      'vi_vi':
          "Nếu có điều gì đó không hoạt động như mong đợi, chúng tôi muốn biết. Chia sẻ ý kiến của bạn về cách chúng tôi có thể cải thiện hoặc cho chúng tôi biết điều gì bạn yêu thích về ứng dụng của chúng tôi.",
      'zh_cn': "如果有任何问题未如预期般运作，我们希望了解您的反馈。请分享您的建议，让我们知道如何改进，或者告诉我们您喜欢的功能。"
    },
    'Report Issues': {
      'en_us': 'Report Issues',
      'vi_vi': 'Báo cáo sự cố',
      'zh_cn': '报告问题'
    },
    'Development Fund': {
      'en_us': 'Development Fund',
      'vi_vi': 'Quỹ phát triển',
      'zh_cn': '发展基金'
    },
    'Join the 2%': {
      'en_us': 'Join the 2%',
      'vi_vi': 'Tham gia vào 2%',
      'zh_cn': '加入2%'
    },
    'description-donation': {
      'en_us':
          'When 2% of users donate, I will have support to work, improve the interface, and develop more tools. This app can remain free forever and open-source for everyone.',
      'vi_vi':
          'Khi 2 phần trăm người dùng quyên góp, mình sẽ được hỗ trợ để làm việc, cải thiện giao diện và phát triển thêm công cụ. Ứng dụng này sẽ có thể miễn phí mãi mãi và mã nguồn mở dành cho tất cả mọi người.',
      'zh_cn': '当 2% 的用户捐款时，我将获得支持来工作、改进界面并开发更多工具。这个应用可以永远免费，并对所有人开源。'
    },
    'or': {'en_us': 'or', 'vi_vi': 'hoặc', 'zh_cn': '或'},
    'Donate': {'en_us': 'Donate', 'vi_vi': 'Quyên góp', 'zh_cn': '捐款'},
    "Download": {"en_us": "Download", "vi_vi": "Tải xuống", "zh_cn": "下载"},
    "Select Flutter Version": {
      "en_us": "Select Flutter Version",
      "vi_vi": "Chọn phiên bản Flutter",
      "zh_cn": "选择 Flutter 版本"
    },
    "Flutter SDK releases": {
      "en_us": "Flutter SDK releases",
      "vi_vi": "Bản phát hành Flutter SDK",
      "zh_cn": "可用的 Flutter SDK 版本"
    },
    "Switch": {"en_us": "Switch", "vi_vi": "Chuyển đổi", "zh_cn": "切换"},
    "Select new Flutter version to switch:": {
      "en_us": "Select new Flutter version to switch:",
      "vi_vi": "Chọn phiên bản Flutter mới để chuyển:",
      "zh_cn": "选择要切换的新 Flutter 版本："
    },
    "Selected Flutter Project Path": {
      "en_us": "Selected Flutter Project Path",
      "vi_vi": "Đường dẫn dự án Flutter đã chọn",
      "zh_cn": "已选择的 Flutter 项目路径"
    },
    "Target Flutter Project:": {
      "en_us": "Target Flutter Project:",
      "vi_vi": "Dự án Flutter mục tiêu:",
      "zh_cn": "目标 Flutter 项目："
    },
    "Select Platform": {
      "en_us": "Select Platform",
      "vi_vi": "Chọn nền tảng",
      "zh_cn": "选择平台"
    },
    "No Devices Detected": {
      "en_us": "No Devices Detected",
      "vi_vi": "Không phát hiện thiết bị nào",
      "zh_cn": "未检测到设备"
    },
    "A user-friendly, robust, and adaptable tool for managing multiple Flutter SDK versions.":
        {
      "en_us":
          "A user-friendly, robust, and adaptable tool for managing multiple Flutter SDK versions.",
      "vi_vi":
          "Một công cụ thân thiện, mạnh mẽ và linh hoạt để quản lý nhiều phiên bản Flutter SDK.",
      "zh_cn": "一个用户友好、强大且灵活的工具，可管理多个 Flutter SDK 版本。"
    },
    "Flutter Version Manager for Desktop": {
      "en_us": "Flutter Version Manager for Desktop",
      "vi_vi": "Quản lý phiên bản Flutter cho máy tính",
      "zh_cn": "桌面版 Flutter 版本管理器"
    },
    "Configure code editor": {
      'en_us': "Configure code editor",
      'vi_vi': 'Cấu hình trình soạn code',
      'zh_cn': '配置代码编辑器'
    },
    "Edit": {'en_us': "Edit", 'vi_vi': 'Chỉnh sửa', 'zh_cn': '编辑'},
    "I need your help": {
      'en_us': "I need your help",
      'vi_vi': "Mình cần sự giúp đỡ của bạn",
      'zh_cn': "我需要你的帮助"
    },
    "Dashboard": {'en_us': "Dashboard", 'vi_vi': "Điều khiển", 'zh_cn': "仪表板"},
    "or buy Parrot Pro at": {
      'en_us': "or buy Parrot Pro at",
      'vi_vi': "hoặc mua Parrot Pro tại",
      'zh_cn': "或在此购买 Parrot Pro"
    },
    "Cache size": {
      'en_us': "Cache size",
      'vi_vi': "Kích thước bộ nhớ đệm",
      'zh_cn': "缓存大小"
    },
    "Available versions": {
      'en_us': "Available versions",
      'vi_vi': "Các phiên bản có sẵn",
      'zh_cn': "可用版本"
    },
    "Channel": {'en_us': "Channel", 'vi_vi': "Kênh", 'zh_cn': "通道"},
    "Release date": {
      'en_us': "Release date",
      'vi_vi': "Ngày phát hành",
      'zh_cn': "发布日期"
    },
    "Fetching from server...": {
      'en_us': "Fetching from server...",
      'vi_vi': "Đang lấy dữ liệu từ máy chủ...",
      'zh_cn': "正在从服务器获取数据..."
    },
    "Version:": {'en_us': "Version:", 'vi_vi': "Phiên bản:", 'zh_cn': "版本:"},
    "Dart SDK version:": {
      'en_us': "Dart SDK version:",
      'vi_vi': "Phiên bản Dart SDK:",
      'zh_cn': "Dart SDK 版本:"
    },
    "Dart SDK architecture:": {
      'en_us': "Dart SDK architecture:",
      'vi_vi': "Kiến trúc Dart SDK:",
      'zh_cn': "Dart SDK 架构:"
    },
    "Download:": {'en_us': "Download:", 'vi_vi': "Tải xuống:", 'zh_cn': "下载:"},
    "Download to Parrot": {
      'en_us': "Download to Parrot",
      'vi_vi': "Tải xuống trong Parrot",
      'zh_cn': "下载到 Parrot"
    },
    "Download zip": {
      'en_us': "Download zip",
      'vi_vi': "Tải xuống tệp zip",
      'zh_cn': "下载 zip 文件"
    },
    "Install Flutter": {
      "en_us": "Install Flutter",
      "vi_vi": "Cài đặt Flutter",
      "zh_cn": "安装 Flutter"
    },
    "*You must have Flutter installed to use this app.": {
      "en_us": "*You must have Flutter installed to use this app.",
      "vi_vi": "*Bạn phải cài đặt Flutter để sử dụng ứng dụng này.",
      "zh_cn": "*您必须安装 Flutter 才能使用此应用。"
    },
    "Select Project": {
      "en_us": "Select Project",
      "vi_vi": "Chọn dự án",
      "zh_cn": "选择项目"
    }
  });

  String get i18n => localize(this, _t);
  String get i18nEnglish => localize(this, _t, locale: 'en_us');

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);
}
