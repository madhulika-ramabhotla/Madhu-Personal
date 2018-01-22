@RestResource(urlMapping = '/Cases/*')
	global with sharing class CaseManager {
	@HttpGet
	global static Case getCaseById() {
		RestRequest request = RestContext.request;
		String caseId = request.requestURI.subString(request.requestURI.lastIndexOf('/') +1);
		Case result = [select CaseNumber,Subject,Status,Origin,Priority from Case WHERE Id=:caseId];
		return result;		
	}

	@HttpPost
	global static Id createCase(String subject, String status, String origin, String priority){
		Case thisCase = new Case();
		thisCase.Subject = subject;
		thisCase.Status = status;
		thisCase.Origin = origin;
		thisCase.Priority = priority;

		insert thisCase;
		return thisCase.Id;
	}

	@HttpDelete
	global static void deleteCase(){
		RestRequest request = RestContext.request;
		String caseId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);

		Case thisCase = [select Id from Case where Id =:caseId];

		delete thisCase;
	}
	@HttpPut
    global static ID upsertCase(String subject, String status,
        String origin, String priority, String id) {
        Case thisCase = new Case(
                Id=id,
                Subject=subject,
                Status=status,
                Origin=origin,
                Priority=priority);
        // Match case by Id, if present.
        // Otherwise, create new case.
        upsert thisCase;
        // Return the case ID.
        return thisCase.Id;
    }

	@HttpPatch
	global static Id updateCaseFields(){
		RestRequest request = RestContext.request;
		String caseId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);

		Case thisCase = [select Id from Case where Id =:caseId];
		Map<String,Object> params = (Map<String,Object> )JSON.deserializeUntyped(request.requestBody.toString());
		for(String fieldName :params.keySet()){
			thisCase.put(fieldName, params.get(fieldName));
		}

		update thisCase;
		return thisCase.Id;

	}


}