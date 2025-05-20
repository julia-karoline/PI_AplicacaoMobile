class CarbonCalculator {
  static const double meatEmissionPerKg = 27.0;      
  static const double electricityEmissionPerKWh = 0.233; 
  static const double fuelEmissionPerLiter = 2.31;    


  static double calculateCarbonFootprint({
    required double meatKgPerMonth,
    required double electricityKwhPerMonth,
    required double fuelLitersPerMonth,
  }) {
    double totalKgCO2 = (meatKgPerMonth * meatEmissionPerKg) +
        (electricityKwhPerMonth * electricityEmissionPerKWh) +
        (fuelLitersPerMonth * fuelEmissionPerLiter);

    return totalKgCO2 / 1000; 
  }

  static double calculateReductionPercentage({
    required double previousFootprint,
    required double currentFootprint,
  }) {
    if (previousFootprint <= 0) return 0;
    double reduction = previousFootprint - currentFootprint;
    return (reduction / previousFootprint) * 100;
  }
}
