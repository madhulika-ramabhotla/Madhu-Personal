@isTest
global class CalculatorCalloutMock  implements WebserviceMock{
    global void doInvoke(
        	Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType){
    CalculatorServices.doAddResponse response_x = new CalculatorServices.doAddResponse();
    response_x.return_x = 5.0;
    response.put('response_x', response_x);

	}
}