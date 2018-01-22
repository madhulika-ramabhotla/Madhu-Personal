@RestResource(urlMapping='/OyeCode/*')
global class OyeCodeRestAPI{
	global static Boolean isNotNullOrEmpty(String str){
		return str != null || !String.isBlank(str);

	}
	public static Contact createContact(String firstName, String lastName,String email, String phone){
		if(isNotNullOrEmpty(firstName) && isNotNullOrEmpty(lastName) && isNotNullOrEmpty(email) && isNotNullOrEmpty(phone)){
			Contact newContact = new Contact();
			newContact.FirstName = firstName;
			newContact.LastName = lastName;
			newContact.Email = email;
			newContact.Phone = phone;

			return newContact;
		}
		else{
			system.debug('Required fields are missing');
			return null;
		}
	}

	/*@HttpPost
	global static Responsehandler post(String firstName, String lastName,String email, String phone){
		Contact newContact = createContact(firstName,lastName,email,phone);
		Responsehandler response= new Responsehandler();
		try{
			insert newContact;
			List<SObject> theObjectList = new List<SObject>();
			theObjectList.add((Sobject)newContact);
			response.Data = theObjectList;
			response.Status = 'Success';
			response.ErrorCode = null;
			response.Message = null;
		}
		catch(DMLexception e){
			response.ErrorCode  = 'Oyecode -001';
			response.Status = 'error';
			response.Message = e.getMessage();
		}
		return response;
	}

	@HttpGet
	global static ResponseHandler GET()
	{
		Responsehandler response = new Responsehandler();
		Contact returnContact = getContact();

		if(returnContact != null){
			response.Status = 'Success';
			response.ErrorCode = '';
			List<SObject> theObjectList = new List<Sobject>();
			theObjectList.add((Sobject)returnContact);
			response.Data = theObjectList;
			response.Status = 'Success :Found Contact';
		}

		else{
			response.ErrorCode  = 'oyecode=0001';
			response.Status = 'error';
			response.Message ='Fail: AAH contact not Found';		
		}
		return response;
	}*/

	public class NoRecordMatchException extends Exception {}
    
    public static Contact getContact()
    {
        //Read the Request from the URL
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String ContactId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1); 
        Contact result;
        try{
            result = [SELECT Id, lastname, firstName, phone, email FROM Contact WHERE Id = :ContactId];
        }
        Catch(System.QueryException e)
        {
            //Add custom exception dynamically to the ErrorMap
            throw new NoRecordMatchException('Unable to find the record maching Id : '+ContactId);
        }
        return result;
    }
}