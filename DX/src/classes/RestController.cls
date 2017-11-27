@RestResource(urlMapping='/RVPLog/')
global class RestController {
    
    @HttpGet
    global static List<RVP_Log__c> getLogs()
    {
        List<RVP_Log__c> logs = [select last_name__c, name__c from rvp_log__c];
        return logs;
    }

}