// import 'package:workmanager/workmanager.dart';
//
// import 'local_notifications_service.dart';
//
// class WorkManagerService {
//   void registerMyTask() async {
//     //register my task
//     await Workmanager().registerPeriodicTask(
//       'id1',
//       'show simple notification',
//       frequency: const Duration(minutes: 15),
//     );
//   }
//
//   //init work manager service
//   Future<void> init() async {
//     await Workmanager().initialize(actionTask, isInDebugMode: true);
//     registerMyTask();
//   }
//
//   void cancelTask(String id) {
//     Workmanager().cancelAll();
//   }
// }
//
// @pragma('vm-entry-point')
// void actionTask() {
//   //show notification
//   Workmanager().executeTask((taskName, inputData) {
//     LocalNotificationsService.instance.showScheduledNotification();
//     return Future.value(true);
//   });
// }
//
