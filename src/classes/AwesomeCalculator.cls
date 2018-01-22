public class AwesomeCalculator {
    public static Double add(double x,double y){
        calculatorservices.CalculatorImplPort calculator = new calculatorservices.CalculatorImplPort();
        return calculator.doAdd(x, y);
    }

}