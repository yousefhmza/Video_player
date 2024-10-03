class Utils {
  static String twoDigits(int number) => number.toString().padLeft(2, "0");

  static String getDurations(Duration duration) {
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
  }
}
