import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifiService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // Inisialisasi pengaturan untuk Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            'icon'); // Gunakan ikon yang ada di folder res/drawable

    // Inisialisasi pengaturan untuk iOS
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Gabungkan pengaturan untuk Android dan iOS
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Inisialisasi plugin dan menangani respon dari notifikasi
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // Menangani respon ketika pengguna mengklik notifikasi
        print('Notification clicked: ${notificationResponse.payload}');
      },
    );
  }

  // Fungsi untuk menampilkan notifikasi
  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    // Pengaturan untuk Android
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id', // ID channel
      'channel_name', // Nama channel
      channelDescription: 'Channel untuk notifikasi',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );

    // Pengaturan untuk iOS
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    // Gabungkan pengaturan platform Android dan iOS
    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Menampilkan notifikasi
    await flutterLocalNotificationsPlugin.show(
      id, // ID notifikasi
      title ?? 'Notifikasi', // Judul notifikasi
      body ?? 'Notifikasi Anda', // Isi notifikasi
      platformDetails, // Pengaturan untuk platform Android dan iOS
      payload: payload, // Data tambahan untuk payload
    );
  }
}
