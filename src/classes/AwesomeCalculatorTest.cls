@isTest
private class AwesomeCalculatorTest {
    @isTest static void testCallout(){
        Test.setMock(WebserviceMock.class, new CalculatorCalloutMock());
        Double x= 2.0;
        double y= 3.0;
        Double result = AwesomeCalculator.add(x,y);
        system.assertEquals(5.0, result);
    }

}