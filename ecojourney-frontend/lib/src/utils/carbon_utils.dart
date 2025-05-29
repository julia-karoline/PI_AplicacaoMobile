double calcularPegadaCarbono(List<Map<String, dynamic>> habits) {
  double total = 0.0;

  for (var habit in habits) {
    final title = habit['title'].toString().toLowerCase();
    final value = habit['value'] ?? 0.0;

    if (title.contains('carne')) {
      total += value * 27.0;
    } else if (title.contains('gasolina')) {
      total += value * 2.31;
    } else if (title.contains('energia')) {
      total += value * 0.5;
    }
  }

  return total;
}
