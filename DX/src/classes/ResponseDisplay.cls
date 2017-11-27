public class ResponseDisplay {
    public List<Response__c> response {get;set;}
	public ResponseDisplay()
    {
        response = [select name , State__c,Name1__c,Name2__c,Name3__c,Year__c from Response__c];
    }
}