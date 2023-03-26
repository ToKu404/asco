class TimeHelper {
  int? startHour;
  int? startMinute;
  int? endHour;
  int? endMinute;

  TimeHelper({
    this.endHour,
    this.endMinute,
    this.startHour,
    this.startMinute,
  });

  void setStartTime({required int? startHour, required int? startMinute}) {
    this.startHour = startHour;
    this.startMinute = startMinute;
  }

  void setEndTime({required int? endHour, required int? endMinute}) {
    this.endHour = endHour;
    this.endMinute = endMinute;
  }
}
