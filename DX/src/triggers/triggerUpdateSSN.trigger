trigger triggerUpdateSSN on Account (before insert,before update) {    
    for (Account acc:trigger.new)
    {  
        if ((acc.SLASerialNumber__c == null) || (acc.SLASerialNumber__c ==''))
        {
            String hashString;
            if(trigger.isInsert){
                // soql : the record is not yet created before insert , so we cant get the createddate
                // because the record is not there we pass in now
                try{                    
                    hashString = CreateUniqueId.generateUniqueId(system.now());     
                     //hashString = CreateUniqueId.generateUniqueId((Sobject)acc,false); 
                }catch(exception e){
                      hashString = CreateUniqueId.generateUniqueId(system.now()); 
                    //hashString = CreateUniqueId.generateUniqueId((Sobject)acc,false); 
                }                
            }
            // the record is created , so we use sobject and retrieve the information 
            else if(trigger.isUpdate){
                try{                    
                    hashString = CreateUniqueId.generateUniqueId((Sobject)acc,true); 
                    //CreateUniqueId.generateUniqueId(acc.createdDate);
                }catch(exception e){
                    hashString = CreateUniqueId.generateUniqueId((Sobject)acc,true); 
                }    
            }            
            acc.SLASerialNumber__c = hashString;
            system.debug('##########' + hashString );
        }
    }
}