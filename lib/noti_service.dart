import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initNotification() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(settings);

    // Tambahkan Notification Channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id', // ID channel
      'General Notifications', // Nama channel
      description: 'Notifikasi dari aplikasi ini', // Deskripsi
      importance: Importance.high,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id', // ID channel harus sama dengan yang dibuat di atas
      'General Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, // ID notifikasi
      title,
      body,
      notificationDetails,
    );
  }
}
