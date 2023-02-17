class AppRoute {
  static const welcomePage = '/welcome';
  static const homePage = '/home';
  static const wrapper = '/wrapper';

  // Student routes
  static const studentMainMenuPage = '/student/main-menu';
  static const studentLaboratoryCourseDetailPage =
      '/student/main-menu/laboratory-course-detail';
  static const studentAssistanceCourseDetailPage =
      '/student/main-menu/assistance-course-detail';
  static const valueRecapLeaderboardPage = '/student/main-menu/value-recap';

  // Assistant routes
  static const assistantLaboratoryCourseDetailPage =
      '/assistant/main-menu/laboratory-course-detail';
  static const assistantLaboratorySchedulePage =
      '/assistant/main-menu/laboratory-schedule';
  static const assistantLaboratoryQuizValueInputPage =
      '/assistant/main-menu/laboratory-quiz-value-input';
  static const assistantAssistanceCourseDetailPage =
      '/assistant/main-menu/assistance-course-detail';
  static const assistantAssistancePractitionerPage =
      '/assistant/main-menu/assistance-practitioner-detail';
  static const assistantValueRecapLeaderboardPage =
      '/assistant/main-menu/assistant-value-recap';

  // Admin routes
  static const adminHomePage = '/admin/home';
  static const adminUsersPage = '/admin/users';
  static const adminDetailUserPage = '/admin/users/user-detail';

  // Extras
  static const labExamPage = '/main-menu/lab-exam-page';
  static const inputValueExam = '/main-menu/input-value-exam';
  static const editInfoExam = '/main-menu/edit-info-exam';
}
