@isTest
private class CaseManagerTest {
	@isTest
	static void testGetcaseById() {
		Case testCase = new Case(Subject ='Test record',Status ='new', Origin ='phone',Priority = 'Medium');
		insert testCase;
		Id recordId = [Select Id from Case].Id;

		RestRequest request = new RestRequest();
		request.requestURI = 'https://yourInstance.salesforce.com/services/apexrest/Cases/'+ recordId;

		request.HttpMethod = 'GET';
		RestContext.request = request;
		Case thisCase = CaseManager.getCaseById();
		system.assert(thisCase != null);
		system.assertEquals('Test record', thisCase.Subject);	
	}
	@isTest static void testDeleteCase() {
        Case testCase = new Case(Subject ='Test record',Status ='new', Origin ='phone',Priority = 'Medium');
		insert testCase;
		Id recordId = [Select Id from Case].Id;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'Delete';
        RestContext.request = request;
        // Call the method to test
        CaseManager.deleteCase();
        // Verify record is deleted
        List<Case> cases = [SELECT Id FROM Case WHERE Id=:recordId];
        System.assert(cases.size() == 0);
    }

}