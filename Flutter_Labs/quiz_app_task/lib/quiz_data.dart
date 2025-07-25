import '../models/question.dart';

class QuizData {
  static final List<Question> _questions = [
    // أسئلة القرآن الكريم
    Question(
      id: 'quran_1',
      question: 'ما هي السورة التي تعدل ثلث القرآن؟',
      options: ['الفاتحة', 'الناس', 'الإخلاص', 'الفلق'],
      correctAnswerIndex: 2,
      category: 'القرآن الكريم',
      difficulty: 'سهل',
    ),
    Question(
      id: 'quran_2',
      question: 'ما هي السورة التي نقرأها يوم الجمعة؟',
      options: ['الكهف', 'البقرة', 'الناس', 'الفاتحة'],
      correctAnswerIndex: 0,
      category: 'القرآن الكريم',
      difficulty: 'سهل',
    ),
    Question(
      id: 'islam_1',
      question: 'عدد أركان الإسلام؟',
      options: ['4', '5', '6', '7'],
      correctAnswerIndex: 1,
      category: 'الإسلام',
      difficulty: 'سهل',
    ),
    Question(
      id: 'quran_3',
      question: 'عدد سور القرآن؟',
      options: ['114', '113', '112', '111'],
      correctAnswerIndex: 0,
      category: 'القرآن الكريم',
      difficulty: 'سهل',
    ),
    Question(
      id: 'quran_4',
      question: 'ما هي السورة التي تبدأ بـ: المر؟',
      options: ['الرعد', 'مريم', 'المرسلات', 'الأنبياء'],
      correctAnswerIndex: 0,
      category: 'القرآن الكريم',
      difficulty: 'متوسط',
    ),
    Question(
      id: 'quran_5',
      question: 'عدد السور التي تبدأ بـ: حـم؟',
      options: ['5', '6', '7', '8'],
      correctAnswerIndex: 2,
      category: 'القرآن الكريم',
      difficulty: 'متوسط',
    ),
    Question(
      id: 'quran_6',
      question: 'في أي سورة هذه الآية: وَقَاسَمَهُمَا إِنِّي لَكُمَا لَمِنَ النَّاصِحِينَ؟',
      options: ['طه', 'الأنعام', 'الأعراف', 'الأنفال'],
      correctAnswerIndex: 2,
      category: 'القرآن الكريم',
      difficulty: 'صعب',
    ),
    Question(
      id: 'prophet_1',
      question: 'كم مرة ذكرت كلمة محمد في القرآن؟',
      options: ['4', '5', '6', '7'],
      correctAnswerIndex: 0,
      category: 'السيرة النبوية',
      difficulty: 'متوسط',
    ),
    Question(
      id: 'quran_7',
      question: 'ما هي السورة التي نقرأها قبل النوم؟',
      options: ['الملك', 'الإنسان', 'نوح', 'الجن'],
      correctAnswerIndex: 0,
      category: 'القرآن الكريم',
      difficulty: 'سهل',
    ),
    Question(
      id: 'quran_8',
      question: 'عدد السجدات في المصحف الشريف؟',
      options: ['14', '15', '16', '17'],
      correctAnswerIndex: 1,
      category: 'القرآن الكريم',
      difficulty: 'متوسط',
    ),

    // أسئلة إضافية في الإسلام
    Question(
      id: 'islam_2',
      question: 'ما هو الركن الأول من أركان الإسلام؟',
      options: ['الصلاة', 'الشهادتان', 'الزكاة', 'الحج'],
      correctAnswerIndex: 1,
      category: 'الإسلام',
      difficulty: 'سهل',
    ),
    Question(
      id: 'islam_3',
      question: 'كم عدد الصلوات المفروضة في اليوم؟',
      options: ['3', '4', '5', '6'],
      correctAnswerIndex: 2,
      category: 'الإسلام',
      difficulty: 'سهل',
    ),
    Question(
      id: 'islam_4',
      question: 'في أي شهر فرض الصيام؟',
      options: ['شعبان', 'رمضان', 'شوال', 'ذو القعدة'],
      correctAnswerIndex: 1,
      category: 'الإسلام',
      difficulty: 'سهل',
    ),
    Question(
      id: 'prophet_2',
      question: 'كم كان عمر النبي محمد صلى الله عليه وسلم عند البعثة؟',
      options: ['35 سنة', '40 سنة', '45 سنة', '50 سنة'],
      correctAnswerIndex: 1,
      category: 'السيرة النبوية',
      difficulty: 'متوسط',
    ),
    Question(
      id: 'prophet_3',
      question: 'ما اسم زوجة النبي الأولى؟',
      options: ['عائشة', 'حفصة', 'خديجة', 'سودة'],
      correctAnswerIndex: 2,
      category: 'السيرة النبوية',
      difficulty: 'سهل',
    ),
    Question(
      id: 'quran_9',
      question: 'ما هي أول سورة نزلت من القرآن؟',
      options: ['الفاتحة', 'العلق', 'المدثر', 'المزمل'],
      correctAnswerIndex: 1,
      category: 'القرآن الكريم',
      difficulty: 'متوسط',
    ),
    Question(
      id: 'quran_10',
      question: 'ما هي أطول سورة في القرآن؟',
      options: ['آل عمران', 'البقرة', 'النساء', 'الأنعام'],
      correctAnswerIndex: 1,
      category: 'القرآن الكريم',
      difficulty: 'سهل',
    ),
    Question(
      id: 'islam_5',
      question: 'كم عدد أركان الوضوء؟',
      options: ['4', '5', '6', '7'],
      correctAnswerIndex: 0,
      category: 'الإسلام',
      difficulty: 'متوسط',
    ),
    Question(
      id: 'prophet_4',
      question: 'في أي عام هاجر النبي من مكة إلى المدينة؟',
      options: ['621 م', '622 م', '623 م', '624 م'],
      correctAnswerIndex: 1,
      category: 'السيرة النبوية',
      difficulty: 'صعب',
    ),
    Question(
      id: 'islam_6',
      question: 'ما هي القبلة الأولى للمسلمين؟',
      options: ['الكعبة', 'المسجد الأقصى', 'المسجد النبوي', 'جبل الطور'],
      correctAnswerIndex: 1,
      category: 'الإسلام',
      difficulty: 'متوسط',
    ),
  ];

  // الحصول على جميع الأسئلة
  static List<Question> getAllQuestions() {
    return List.from(_questions);
  }

  // الحصول على الأسئلة حسب الفئة
  static List<Question> getQuestionsByCategory(String category) {
    if (category == 'الكل') {
      return List.from(_questions);
    }
    return _questions.where((q) => q.category == category).toList();
  }

  // الحصول على الفئات المتاحة
  static List<String> getCategories() {
    final categories = _questions.map((q) => q.category).toSet().toList();
    categories.insert(0, 'الكل'); // إضافة خيار "الكل"
    return categories;
  }

  // الحصول على الأسئلة حسب المستوى
  static List<Question> getQuestionsByDifficulty(String difficulty) {
    return _questions.where((q) => q.difficulty == difficulty).toList();
  }

  // الحصول على مستويات الصعوبة
  static List<String> getDifficulties() {
    return _questions.map((q) => q.difficulty).toSet().toList();
  }
}