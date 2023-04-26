import '../../../../core/constants/constants.dart';
import '../../../presentations/features/menu/assistance/widgets/practicum_value_input_dialog.dart';

class ScoreScheme {
  static final valuesScheme = <ValueType>[
    ValueType(1, 'D', Palette.red, 30, "Sangat Rendah"),
    ValueType(2, 'C', Palette.red, 50, "Rendah"),
    ValueType(3, 'B-', Palette.purple60, 70, "Cukup"),
    ValueType(4, 'B', Palette.purple60, 80, "Sedang"),
    ValueType(5, 'B+', Palette.purple60, 82, "Lumayan"),
    ValueType(6, 'A-', Palette.purple80, 90, "Bagus"),
    ValueType(7, 'A', Palette.purple80, 98, "Sangat Bagus"),
  ];
}
