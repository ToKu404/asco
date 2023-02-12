class Course {
  final int number;
  final String topic;
  final String date;
  final bool? isLocked;

  const Course(this.number, this.topic, this.date, {this.isLocked = true});
}
