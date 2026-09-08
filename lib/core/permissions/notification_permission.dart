import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_permission.g.dart';

enum NotificationPermissionStatus { granted, denied, permanentlyDenied }

abstract interface class NotificationPermission {
  /// Chiede il permesso se non e ancora stato concesso e restituisce l'esito.
  Future<NotificationPermissionStatus> ensure();

  Future<void> openSettings();
}

@Riverpod(keepAlive: true)
NotificationPermission notificationPermission(Ref ref) =>
    const SystemNotificationPermission();

class SystemNotificationPermission implements NotificationPermission {
  const SystemNotificationPermission();

  @override
  Future<NotificationPermissionStatus> ensure() async {
    final current = await Permission.notification.status;
    if (current.isGranted) return NotificationPermissionStatus.granted;
    if (current.isPermanentlyDenied) {
      return NotificationPermissionStatus.permanentlyDenied;
    }
    return _toStatus(await Permission.notification.request());
  }

  @override
  Future<void> openSettings() => openAppSettings();

  NotificationPermissionStatus _toStatus(PermissionStatus status) {
    if (status.isGranted) return NotificationPermissionStatus.granted;
    if (status.isPermanentlyDenied) {
      return NotificationPermissionStatus.permanentlyDenied;
    }
    return NotificationPermissionStatus.denied;
  }
}
