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
      'zh_cn': '对我们有反馈或建议吗？',
      'ja_jp': 'ご意見やご提案はありますか？',
      'de_de': 'Haben Sie Feedback oder Vorschläge für uns?'
    },
    "What's new?": {
      'en_us': "What's new?",
      'vi_vi': 'Có gì mới?',
      'zh_cn': '有什么新内容？',
      'ja_jp': '新着情報',
      'de_de': 'Was gibt\'s Neues?'
    },
    'Feedback': {
      'en_us': 'Feedback',
      'vi_vi': 'Góp ý',
      'zh_cn': '反馈',
      'ja_jp': 'フィードバック',
      'de_de': 'Feedback'
    },
    'Type your report here': {
      'en_us': 'Type your report here',
      'vi_vi': 'Nhập phản hồi của bạn tại đây',
      'zh_cn': '在此输入您的报告',
      'ja_jp': 'ここにレポートを入力してください',
      'de_de': 'Geben Sie hier Ihren Bericht ein'
    },
    'Rate us': {
      'en_us': 'Rate us',
      'vi_vi': 'Đánh giá',
      'zh_cn': '给我们评分',
      'ja_jp': '評価する',
      'de_de': 'Bewerten Sie uns'
    },
    "We'd love to hear your feedback!": {
      'en_us': "We'd love to hear your feedback!",
      'vi_vi': 'Chúng tôi rất muốn nghe phản hồi của bạn!',
      'zh_cn': '我们很想听到您的反馈！',
      'ja_jp': 'フィードバックをお待ちしています！',
      'de_de': 'Wir würden uns über Ihr Feedback freuen!'
    },
    'All rights reserved.': {
      'en_us': 'All rights reserved.',
      'vi_vi': 'Mọi quyền được bảo lưu.',
      'zh_cn': '版权所有。',
      'ja_jp': '全著作権所有。',
      'de_de': 'Alle Rechte vorbehalten.'
    },
    'Available at': {
      'en_us': 'Available at',
      'vi_vi': 'Đã có mặt ở',
      'zh_cn': '可用于',
      'ja_jp': '利用可能',
      'de_de': 'Verfügbar bei'
    },
    'About': {
      'en_us': 'About',
      'vi_vi': 'Thông tin',
      'zh_cn': '关于',
      'ja_jp': '約',
      'de_de': 'Über'
    },
    'Restore the settings to their default as when the application was first installed.':
        {
      'en_us':
          'Restore the settings to their default as when the application was first installed.',
      'vi_vi':
          'Khôi phục các thiết lập về cài đặt mặc định như lúc ứng dụng mới được cài đặt lần đầu.',
      'zh_cn': '将设置恢复为应用程序首次安装时的默认值。',
      'ja_jp': 'アプリケーションが最初にインストールされたときのデフォルトに設定を復元します。',
      'de_de':
          'Stellen Sie die Einstellungen auf die Standardeinstellungen zurück, wie sie bei der ersten Installation der Anwendung waren.'
    },
    'Default settings are restored': {
      'en_us': 'Default settings are restored',
      'vi_vi': 'Đã khôi mục cài đặt về mặc định',
      'zh_cn': '默认设置已恢复',
      'ja_jp': 'デフォルト設定が復元されました',
      'de_de': 'Standardeinstellungen wurden wiederhergestellt'
    },
    'Reset to default settings': {
      'en_us': 'Reset to default settings',
      'vi_vi': 'Khôi phục cài đặt gốc',
      'zh_cn': '恢复默认设置',
      'ja_jp': 'デフォルト設定にリセット',
      'de_de': 'Auf Standardeinstellungen zurücksetzen'
    },
    'Copied to clipboard': {
      'en_us': 'Copied to clipboard',
      'vi_vi': 'Đã sao chép vào bộ nhớ tạm',
      'zh_cn': '已复制到剪贴板',
      'ja_jp': 'クリップボードにコピーされました',
      'de_de': 'In die Zwischenablage kopiert'
    },
    'Licenses': {
      'en_us': 'Licenses',
      'vi_vi': 'Giấy phép',
      'zh_cn': '许可证',
      'ja_jp': 'ライセンス',
      'de_de': 'Lizenzen'
    },
    'DescriptionTextForLicenses': {
      'en_us':
          'Our app utilizes various open-source libraries. Here, you can view the licenses and attributions for the third-party software integrated into our product.',
      'vi_vi':
          'Ứng dụng của chúng tôi sử dụng nhiều thư viện mã nguồn mở. Tại đây, bạn có thể xem các giấy phép và sự ghi nhận cho phần mềm của bên thứ ba được tích hợp vào sản phẩm của chúng tôi.',
      'zh_cn': '我们的应用程序使用了各种开源库。在这里，您可以查看集成到我们产品中的第三方软件的许可证和归属。',
      'ja_jp':
          '私たちのアプリはさまざまなオープンソースライブラリを利用しています。ここでは、製品に統合されたサードパーティソフトウェアのライセンスと帰属を表示できます。',
      'de_de':
          'Unsere App nutzt verschiedene Open-Source-Bibliotheken. Hier können Sie die Lizenzen und Zuschreibungen für die in unser Produkt integrierte Drittanbieter-Software einsehen.'
    },
    'Release notes': {
      'en_us': 'Release notes',
      'vi_vi': 'Thông tin phiên bản',
      'zh_cn': '发布说明',
      'ja_jp': 'リリースノート',
      'de_de': 'Versionshinweise'
    },
    'System default': {
      'en_us': 'System default',
      'vi_vi': 'Tự động',
      'zh_cn': '系统默认',
      'ja_jp': 'システムデフォルト',
      'de_de': 'Systemstandard'
    },
    'English': {
      'en_us': 'English',
      'vi_vi': 'English',
      'zh_cn': '英语',
      'ja_jp': '英語',
      'de_de': 'Englisch'
    },
    'Tiếng Việt': {
      'en_us': 'Tiếng Việt',
      'vi_vi': 'Tiếng Việt',
      'zh_cn': '越南语',
      'ja_jp': 'ベトナム語',
      'de_de': 'Vietnamesisch'
    },
    'Use System Theme': {
      'en_us': 'Use System Theme',
      'vi_vi': 'Sử dụng chủ đề hệ thống',
      'zh_cn': '使用系统主题',
      'ja_jp': 'システムテーマを使用',
      'de_de': 'Systemthema verwenden'
    },
    'Accent color': {
      'en_us': 'Accent color',
      'vi_vi': 'Tông màu',
      'zh_cn': '强调色',
      'ja_jp': 'アクセントカラー',
      'de_de': 'Akzentfarbe'
    },
    'DesciptionTextForPrivacyPolicy': {
      'en_us':
          'We hold your privacy in high regard and assure you that your personal data will not be disclosed to any third party.',
      'vi_vi':
          'Chúng tôi tôn trọng quyền riêng tư của bạn và cam kết dữ liệu cá nhân của bạn sẽ không được chia sẻ với bất cứ bên thứ ba nào cả.',
      'zh_cn': '我们高度重视您的隐私，并向您保证您的个人数据不会被透露给任何第三方。',
      'ja_jp': '私たちはあなたのプライバシーを重視し、あなたの個人データが第三者に開示されないことを保証します。',
      'de_de':
          'Wir achten Ihre Privatsphäre und versichern Ihnen, dass Ihre persönlichen Daten nicht an Dritte weitergegeben werden.'
    },
    'For more information about our privacy policy, please visit:': {
      'en_us': 'For more information about our privacy policy, please visit:',
      'vi_vi':
          'Để biết thêm chi tiết về điều khoản riêng tư, vui lòng truy cập:',
      'zh_cn': '有关隐私政策的更多信息，请访问：',
      'ja_jp': 'プライバシーポリシーの詳細については、こちらをご覧ください：',
      'de_de':
          'Weitere Informationen zu unserer Datenschutzrichtlinie finden Sie unter:'
    },
    'Privacy Policy': {
      'en_us': 'Privacy Policy',
      'vi_vi': 'Điều khoản',
      'zh_cn': '隐私政策',
      'ja_jp': 'プライバシーポリシー',
      'de_de': 'Datenschutzrichtlinie'
    },
    'Settings': {
      'en_us': 'Settings',
      'vi_vi': 'Cài đặt',
      'zh_cn': '设置',
      'ja_jp': '設定',
      'de_de': 'Einstellungen'
    },
    '* The changes will become effective the next time you open the app.': {
      'en_us':
          'Note: The changes will become effective the next time you open the app.',
      'vi_vi':
          'Ghi chú: Những thay đổi sẽ có hiệu lực vào lần tiếp theo bạn mở ứng dụng.',
      'zh_cn': '注意：更改将在您下次打开应用程序时生效。',
      'ja_jp': '注：変更は次回アプリを開いたときに有効になります。',
      'de_de':
          'Hinweis: Die Änderungen werden beim nächsten Öffnen der App wirksam.'
    },
    'Common': {
      'en_us': 'Common',
      'vi_vi': 'Cài đặt chung',
      'zh_cn': '通用',
      'ja_jp': '一般',
      'de_de': 'Allgemein'
    },
    'Language': {
      'en_us': 'Language',
      'vi_vi': 'Ngôn ngữ',
      'zh_cn': '语言',
      'ja_jp': '言語',
      'de_de': 'Sprache'
    },
    'Select a language': {
      'en_us': 'Select a language',
      'vi_vi': 'Chọn một ngôn ngữ',
      'zh_cn': '选择一种语言',
      'ja_jp': '言語を選択',
      'de_de': 'Wählen Sie eine Sprache'
    },
    'Light mode': {
      'en_us': 'Light',
      'vi_vi': 'Sáng',
      'zh_cn': '浅色模式',
      'ja_jp': 'ライトモード',
      'de_de': 'Hell'
    },
    'Dark mode': {
      'en_us': 'Dark',
      'vi_vi': 'Tối',
      'zh_cn': '深色模式',
      'ja_jp': 'ダークモード',
      'de_de': 'Dunkel'
    },
    'Adaptive': {
      'en_us': 'Adaptive',
      'vi_vi': 'Tự động',
      'zh_cn': '自适应',
      'ja_jp': '適応',
      'de_de': 'Adaptiv'
    },
    'Theme': {
      'en_us': 'Theme',
      'vi_vi': 'Giao diện',
      'zh_cn': '主题',
      'ja_jp': 'テーマ',
      'de_de': 'Thema'
    },
    'Customize': {
      'en_us': 'Customize',
      'vi_vi': 'Tùy chỉnh',
      'zh_cn': '自定义',
      'ja_jp': 'カスタマイズ',
      'de_de': 'Anpassen'
    },
    'Preferences': {
      'en_us': 'Preferences',
      'vi_vi': 'Tùy chỉnh',
      'zh_cn': '偏好设置',
      'ja_jp': '設定',
      'de_de': 'Einstellungen'
    },
    'Help Us Improve': {
      'en_us': 'Help Us Improve',
      'vi_vi': 'Phản hồi',
      'zh_cn': '帮助我们改进',
      'ja_jp': '改善にご協力ください',
      'de_de': 'Helfen Sie uns, uns zu verbessern'
    },
    'If something isn’t working as expected, we’d like to know. Share your feedback on how we can improve or let us know what you enjoy about our app.':
        {
      'en_us':
          "If something isn’t working as expected, we’d like to know. Share your feedback on how we can improve or let us know what you enjoy about our app.",
      'vi_vi':
          "Nếu có điều gì đó không hoạt động như mong đợi, chúng tôi muốn biết. Chia sẻ ý kiến của bạn về cách chúng tôi có thể cải thiện hoặc cho chúng tôi biết điều gì bạn yêu thích về ứng dụng của chúng tôi.",
      'zh_cn': "如果有任何问题未如预期般运作，我们希望了解您的反馈。请分享您的建议，让我们知道如何改进，或者告诉我们您喜欢的功能。",
      'ja_jp':
          "期待通りに動作しない場合は、お知らせください。改善方法についてのフィードバックを共有するか、アプリの気に入っている点を教えてください。",
      'de_de':
          "Wenn etwas nicht wie erwartet funktioniert, lassen Sie es uns wissen. Teilen Sie uns Ihr Feedback mit, wie wir uns verbessern können, oder lassen Sie uns wissen, was Ihnen an unserer App gefällt."
    },
    'Report Issues': {
      'en_us': 'Report Issues',
      'vi_vi': 'Báo cáo sự cố',
      'zh_cn': '报告问题',
      'ja_jp': '問題を報告する',
      'de_de': 'Probleme melden'
    },
    'Development Fund': {
      'en_us': 'Development Fund',
      'vi_vi': 'Quỹ phát triển',
      'zh_cn': '发展基金',
      'ja_jp': '開発基金',
      'de_de': 'Entwicklungsfonds'
    },
    'Join the 2%': {
      'en_us': 'Join the 2%',
      'vi_vi': 'Tham gia vào 2%',
      'zh_cn': '加入2%',
      'ja_jp': '2％に参加する',
      'de_de': 'Treten Sie den 2% bei'
    },
    'description-donation': {
      'en_us':
          'When 2% of users donate, I will have support to work, improve the interface, and develop more tools. This app can remain free forever and open-source for everyone.',
      'vi_vi':
          'Khi 2 phần trăm người dùng quyên góp, mình sẽ được hỗ trợ để làm việc, cải thiện giao diện và phát triển thêm công cụ. Ứng dụng này sẽ có thể miễn phí mãi mãi và mã nguồn mở dành cho tất cả mọi người.',
      'zh_cn': '当 2% 的用户捐款时，我将获得支持来工作、改进界面并开发更多工具。这个应用可以永远免费，并对所有人开源。',
      'ja_jp':
          'ユーザーの2％が寄付すると、作業をサポートし、インターフェースを改善し、さらに多くのツールを開発することができます。このアプリは永遠に無料で、すべての人にオープンソースのままでいられます。',
      'de_de':
          'Wenn 2% der Benutzer spenden, werde ich Unterstützung haben, um zu arbeiten, die Benutzeroberfläche zu verbessern und weitere Tools zu entwickeln. Diese App kann für immer kostenlos und Open-Source für alle bleiben.'
    },
    'or': {
      'en_us': 'or',
      'vi_vi': 'hoặc',
      'zh_cn': '或',
      'ja_jp': 'または',
      'de_de': 'oder'
    },
    'Donate': {
      'en_us': 'Donate',
      'vi_vi': 'Quyên góp',
      'zh_cn': '捐款',
      'ja_jp': '寄付する',
      'de_de': 'Spenden'
    },
    "Download": {
      "en_us": "Download",
      "vi_vi": "Tải xuống",
      "zh_cn": "下载",
      "ja_jp": "ダウンロード",
      "de_de": "Herunterladen"
    },
    "Select Flutter Version": {
      "en_us": "Select Flutter Version",
      "vi_vi": "Chọn phiên bản Flutter",
      "zh_cn": "选择 Flutter 版本",
      "ja_jp": "Flutterバージョンを選択",
      "de_de": "Flutter-Version auswählen"
    },
    "Flutter SDK releases": {
      "en_us": "Flutter SDK releases",
      "vi_vi": "Bản phát hành Flutter SDK",
      "zh_cn": "可用的 Flutter SDK 版本",
      "ja_jp": "Flutter SDK リリース",
      "de_de": "Flutter SDK-Versionen"
    },
    "Switch": {
      "en_us": "Switch",
      "vi_vi": "Chuyển đổi",
      "zh_cn": "切换",
      "ja_jp": "スイッチ",
      "de_de": "Wechseln"
    },
    "Select new Flutter version to switch:": {
      "en_us": "Select new Flutter version to switch:",
      "vi_vi": "Chọn phiên bản Flutter mới để chuyển:",
      "zh_cn": "选择要切换的新 Flutter 版本：",
      "ja_jp": "切り替える新しい Flutter バージョンを選択:",
      "de_de": "Flutter-Version zum Wechseln:"
    },
    "Selected Flutter Project Path": {
      "en_us": "Selected Flutter Project Path",
      "vi_vi": "Đường dẫn dự án Flutter đã chọn",
      "zh_cn": "已选择的 Flutter 项目路径",
      "ja_jp": "選択された Flutter プロジェクトパス",
      "de_de": "Ausgewählter Flutter-Projektpfad"
    },
    "Target Flutter Project:": {
      "en_us": "Target Flutter Project:",
      "vi_vi": "Dự án Flutter mục tiêu:",
      "zh_cn": "目标 Flutter 项目：",
      "ja_jp": "ターゲット Flutter プロジェクト:",
      "de_de": "Ziel Flutter-Projekt:"
    },
    "Select Platform": {
      "en_us": "Select Platform",
      "vi_vi": "Chọn nền tảng",
      "zh_cn": "选择平台",
      "ja_jp": "プラットフォームを選択",
      "de_de": "Plattform auswählen"
    },
    "No Devices Detected": {
      "en_us": "No Devices Detected",
      "vi_vi": "Không phát hiện thiết bị nào",
      "zh_cn": "未检测到设备",
      "ja_jp": "デバイスが検出されません",
      "de_de": "Keine Geräte erkannt"
    },
    "A user-friendly, robust, and adaptable tool for managing multiple Flutter SDK versions.":
        {
      "en_us":
          "A user-friendly, robust, and adaptable tool for managing multiple Flutter SDK versions.",
      "vi_vi":
          "Một công cụ thân thiện, mạnh mẽ và linh hoạt để quản lý nhiều phiên bản Flutter SDK.",
      "zh_cn": "一个用户友好、强大且灵活的工具，可管理多个 Flutter SDK 版本。",
      "ja_jp": "複数の Flutter SDK バージョンを管理するためのユーザーフレンドリーで堅牢かつ適応性のあるツール。",
      "de_de":
          "Ein benutzerfreundliches, robustes und anpassungsfähiges Werkzeug zur Verwaltung mehrerer Flutter SDK-Versionen."
    },
    "Flutter Version Manager for Desktop": {
      "en_us": "Flutter Version Manager for Desktop",
      "vi_vi": "Quản lý phiên bản Flutter cho máy tính",
      "zh_cn": "桌面版 Flutter 版本管理器",
      "ja_jp": "デスクトップ用 Flutter バージョンマネージャー",
      "de_de": "Flutter-Version-Manager für Desktop"
    },
    "Configure code editor": {
      'en_us': "Configure code editor",
      'vi_vi': 'Cấu hình trình soạn code',
      'zh_cn': '配置代码编辑器',
      'ja_jp': 'コードエディタを設定',
      'de_de': 'Code-Editor konfigurieren'
    },
    "Edit": {
      'en_us': "Edit",
      'vi_vi': 'Chỉnh sửa',
      'zh_cn': '编辑',
      'ja_jp': '編集',
      'de_de': 'Bearbeiten'
    },
    "I need your help": {
      'en_us': "I need your help",
      'vi_vi': "Mình cần sự giúp đỡ của bạn",
      'zh_cn': "我需要你的帮助",
      'ja_jp': "助けが必要です",
      'de_de': "Ich brauche deine Hilfe"
    },
    "Dashboard": {
      'en_us': "Dashboard",
      'vi_vi': "Điều khiển",
      'zh_cn': "仪表板",
      'ja_jp': "ダッシュボード",
      'de_de': "Armaturenbrett"
    },
    "or buy Parrot Pro at": {
      'en_us': "or buy Parrot Pro at",
      'vi_vi': "hoặc mua Parrot Pro tại",
      'zh_cn': "或在此购买 Parrot Pro",
      'ja_jp': "または Parrot Pro を購入",
      'de_de': "oder kaufen Sie Parrot Pro bei"
    },
    "Cache size": {
      'en_us': "Cache size",
      'vi_vi': "Kích thước bộ nhớ đệm",
      'zh_cn': "缓存大小",
      'ja_jp': "キャッシュサイズ",
      'de_de': "Cache-Größe"
    },
    "Available versions": {
      'en_us': "Available versions",
      'vi_vi': "Các phiên bản có sẵn",
      'zh_cn': "可用版本",
      'ja_jp': "利用可能なバージョン",
      'de_de': "Verfügbare Versionen"
    },
    "Channel": {
      'en_us': "Channel",
      'vi_vi': "Kênh",
      'zh_cn': "通道",
      'ja_jp': "チャネル",
      'de_de': "Kanal"
    },
    "Release date": {
      'en_us': "Release date",
      'vi_vi': "Ngày phát hành",
      'zh_cn': "发布日期",
      'ja_jp': "リリース日",
      'de_de': "Veröffentlichungsdatum"
    },
    "Fetching from server...": {
      'en_us': "Fetching from server...",
      'vi_vi': "Đang lấy dữ liệu từ máy chủ...",
      'zh_cn': "正在从服务器获取数据...",
      'ja_jp': "サーバーから取得中...",
      'de_de': "Vom Server abrufen..."
    },
    "Version:": {
      'en_us': "Version:",
      'vi_vi': "Phiên bản:",
      'zh_cn': "版本:",
      'ja_jp': "バージョン:",
      'de_de': "Version:"
    },
    "Dart SDK version:": {
      'en_us': "Dart SDK version:",
      'vi_vi': "Phiên bản Dart SDK:",
      'zh_cn': "Dart SDK 版本:",
      'ja_jp': "Dart SDK バージョン:",
      'de_de': "Dart SDK-Version:"
    },
    "Dart SDK architecture:": {
      'en_us': "Dart SDK architecture:",
      'vi_vi': "Kiến trúc Dart SDK:",
      'zh_cn': "Dart SDK 架构:",
      'ja_jp': "Dart SDK アーキテクチャ:",
      'de_de': "Dart SDK-Architektur:"
    },
    "Download:": {
      'en_us': "Download:",
      'vi_vi': "Tải xuống:",
      'zh_cn': "下载:",
      'ja_jp': "ダウンロード:",
      'de_de': "Herunterladen:"
    },
    "Download to Parrot": {
      'en_us': "Download to Parrot",
      'vi_vi': "Tải xuống trong Parrot",
      'zh_cn': "下载到 Parrot",
      'ja_jp': "Parrot にダウンロード",
      'de_de': "Zu Parrot herunterladen"
    },
    "Download zip": {
      'en_us': "Download zip",
      'vi_vi': "Tải xuống tệp zip",
      'zh_cn': "下载 zip 文件",
      'ja_jp': "zip をダウンロード",
      'de_de': "Zip herunterladen"
    },
    "Install Flutter": {
      "en_us": "Install Flutter",
      "vi_vi": "Cài đặt Flutter",
      "zh_cn": "安装 Flutter",
      "ja_jp": "Flutter をインストール",
      "de_de": "Flutter installieren"
    },
    "*You must have Flutter installed to use this app.": {
      "en_us": "*You must have Flutter installed to use this app.",
      "vi_vi": "*Bạn phải cài đặt Flutter để sử dụng ứng dụng này.",
      "zh_cn": "*您必须安装 Flutter 才能使用此应用。",
      "ja_jp": "*このアプリを使用するには Flutter をインストールする必要があります。",
      "de_de":
          "*Sie müssen Flutter installiert haben, um diese App zu verwenden."
    },
    "Select Project": {
      "en_us": "Select Project",
      "vi_vi": "Chọn dự án",
      "zh_cn": "选择项目",
      "ja_jp": "プロジェクトを選択",
      "de_de": "Projekt auswählen"
    },
    "Common Issues & Solutions": {
      "en_us": "Common Issues & Solutions",
      "vi_vi": "Các vấn đề thường gặp & Giải pháp",
      "zh_cn": "常见问题与解决方案",
      "ja_jp": "一般的な問題と解決策",
      "de_de": "Häufige Probleme & Lösungen"
    },
    "How to Configure FVM in Your Code Editor?": {
      "en_us": "How to Configure FVM in Your Code Editor?",
      "vi_vi": "Cách cấu hình FVM trong trình chỉnh sửa mã?",
      "zh_cn": "如何在代码编辑器中配置 FVM？",
      "ja_jp": "コードエディターで FVM を設定する方法は？",
      "de_de": "Wie konfiguriert man FVM in Ihrem Code-Editor?"
    },
    "Troubleshoot when Flutter SDK versions are not showing up": {
      "en_us": "Troubleshoot when Flutter SDK versions are not showing up",
      "vi_vi": "Khắc phục khi phiên bản Flutter SDK không hiển thị",
      "zh_cn": "解决 Flutter SDK 版本未显示的问题",
      "ja_jp": "Flutter SDK バージョンが表示されない場合のトラブルシューティング",
      "de_de": "Fehlersuche, wenn Flutter SDK-Versionen nicht angezeigt werden"
    },
    "Parrot Not Displaying Flutter SDKs": {
      "en_us": "Parrot Not Displaying Flutter SDKs",
      "vi_vi": "Parrot không hiển thị các phiên bản Flutter SDK",
      "zh_cn": "Parrot 未显示 Flutter SDK 版本",
      "ja_jp": "Parrot が Flutter SDK を表示しない",
      "de_de": "Parrot zeigt keine Flutter SDKs an"
    },
    "Project Not Running After Version Change": {
      "en_us": "Project Not Running After Version Change",
      "vi_vi": "Dự án không chạy sau khi thay đổi phiên bản",
      "zh_cn": "版本更改后项目无法运行",
      "ja_jp": "バージョン変更後にプロジェクトが実行されない",
      "de_de": "Projekt läuft nicht nach Versionsänderung"
    },
    "Learn how to set up FVM integration in VS Code and Android Studio": {
      "en_us":
          "Learn how to set up FVM integration in VS Code and Android Studio",
      "vi_vi":
          "Tìm hiểu cách thiết lập tích hợp FVM trong VS Code và Android Studio",
      "zh_cn": "了解如何在 VS Code 和 Android Studio 中设置 FVM 集成",
      "ja_jp": "VS Code と Android Studio で FVM の統合を設定する方法を学ぶ",
      "de_de":
          "Erfahren Sie, wie Sie die FVM-Integration in VS Code und Android Studio einrichten"
    },
    "Fix issues when project fails to run after switching Flutter versions": {
      "en_us":
          "Fix issues when project fails to run after switching Flutter versions",
      "vi_vi":
          "Khắc phục lỗi khi dự án không chạy sau khi đổi phiên bản Flutter",
      "zh_cn": "修复切换 Flutter 版本后项目无法运行的问题",
      "ja_jp": "Flutter バージョンを切り替えた後にプロジェクトが実行されない問題を修正する",
      "de_de":
          "Beheben Sie Probleme, wenn das Projekt nach einem Wechsel der Flutter-Version nicht ausgeführt wird"
    },
    "Troubleshooting": {
      "en_us": "Troubleshooting",
      "vi_vi": "Khắc phục sự cố",
      "zh_cn": "故障排除",
      "ja_jp": "トラブルシューティング",
      "de_de": "Fehlersuche"
    },
      "Device:": {
      "en_us": "Device:",
      "vi_vi": "Thiết bị:",
      "zh_cn": "设备：",
      "ja_jp": "デバイス：",
      "de_de": "Gerät:"
    },
    "Project Info": {
      "en_us": "Project Info",
      "vi_vi": "Thông tin dự án",
      "zh_cn": "项目信息",
      "ja_jp": "プロジェクト情報",
      "de_de": "Projekt-Info"
    },
    "project info": {
      "en_us": "project info",
      "vi_vi": "thông tin dự án",
      "zh_cn": "项目信息",
      "ja_jp": "プロジェクト情報",
      "de_de": "projekt-info"
    },
    "Pinned version:": {
      "en_us": "Pinned version:",
      "vi_vi": "Phiên bản ghim:",
      "zh_cn": "固定版本：",
      "ja_jp": "固定バージョン：",
      "de_de": "Fixierte Version:"
    },
    "SDK Constraint:": {
      "en_us": "SDK Constraint:",
      "vi_vi": "Ràng buộc SDK:",
      "zh_cn": "SDK 约束：",
      "ja_jp": "SDK 制約：",
      "de_de": "SDK-Einschränkung:"
    },
    "Dart Tool version:": {
      "en_us": "Dart Tool version:",
      "vi_vi": "Phiên bản Dart Tool:",
      "zh_cn": "Dart Tool 版本：",
      "ja_jp": "Dart Tool バージョン：",
      "de_de": "Dart Tool-Version:"
    },
    "Has an FVM config file:": {
      "en_us": "Has an FVM config file:",
      "vi_vi": "Có tệp cấu hình FVM:",
      "zh_cn": "有 FVM 配置文件：",
      "ja_jp": "FVM 設定ファイルあり：",
      "de_de": "Hat eine FVM-Konfigurationsdatei:"
    },
    "Is .gitignore updated:": {
      "en_us": "Is .gitignore updated:",
      "vi_vi": "Đã cập nhật .gitignore:",
      "zh_cn": ".gitignore 是否已更新：",
      "ja_jp": ".gitignore は更新済み：",
      "de_de": "Ist .gitignore aktualisiert:"
    },
    "Is VS Code Settings updated:": {
      "en_us": "Is VS Code Settings updated:",
      "vi_vi": "Đã cập nhật cài đặt VS Code:",
      "zh_cn": "VS Code 设置是否已更新：",
      "ja_jp": "VS Code 設定は更新済み：",
      "de_de": "Sind VS Code-Einstellungen aktualisiert:"
    }
  });

  String get i18n => localize(this, _t);
  String get i18nEnglish => localize(this, _t, locale: 'en_us');

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);
}
