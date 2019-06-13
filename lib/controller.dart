/// The controller library is responsible for the user interaction respectively
/// the listeners for device sensors and buttons and for the time control with
/// timers so the game entities are moved over time.
/// The AppController is the main controller and the starting point within the
/// app. The LevelController is the controller only used for controlling a
/// specific level.
library dozer_controller;

export 'package:dozergame/src/controller/AppController.dart';
export 'package:dozergame/src/controller/LevelController.dart';