/// Функция конвертящая цвета из RGBA формата в ARGB
String rgbaToArgb(String color) {
  final aLen = color.length > 4 ? 2 : 1;
  final a = color.substring(color.length - aLen);
  final rgb = color.substring(0, color.length - aLen);
  return '$a$rgb';
}
