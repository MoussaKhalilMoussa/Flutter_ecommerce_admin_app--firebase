import 'package:e_seller_appl/constants/constants.dart';
import 'package:e_seller_appl/views/widgets/text_style.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: color,
          padding: const EdgeInsets.all(12.0)),
      onPressed: onPress,
      child: normalText(text: title, size: 16.0));
}
