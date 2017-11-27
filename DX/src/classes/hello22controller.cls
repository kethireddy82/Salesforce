public class hello22controller 
{
    public List <responseInfo> lresponseInfo{get;set;}
    public List<Response__c> response {get;set;}
    //Constructor
	public hello22controller(ApexPages.StandardController controller) 
    {
        lresponseInfo = new list <responseInfo>();
          response = [select name , State__c,Name1__c,Name2__c,Name3__c,Year__c from Response__c];
        for (Response__c res : response)
        {
            responseInfo ainfo = new responseInfo();
            ainfo.name1 =  res.name1__c;
            ainfo.name2=res.name2__c;
            ainfo.name3=res.name3__c;
            ainfo.name=res.name;
            ainfo.year=res.Year__c; 
            lresponseInfo.add(ainfo);
        }
		/*for(integer i=0;i<System.now().month();i++)
		{
			accountInfo ainfo = new accountInfo();
			ainfo.month = datetime.newinstance(2013,1,1).addmonths(i).format('MMM');
			ainfo.count = 0;
			laccountInfo.add(ainfo);
		}
		AggregateResult[] groupedResults  = [SELECT Count(id)monthCount,CALENDAR_MONTH(createdDate)   monthNo FROM Account WHERE createdDate = THIS_YEAR GROUP BY CALENDAR_MONTH(createdDate)];
        
        for (AggregateResult ag : groupedResults)  
        {
            Integer MonthNo = integer.valueof(ag.get('monthNo'));
			Integer MonthCount = integer.valueOf(ag.get('monthCount'));
			laccountInfo.get(MonthNo-1).count = MonthCount;
        }      */           
    }
    //Wrapper Class
    public class responseInfo
    {
        public String name1{get;set;}
        public String name2{get;set;}
        public String name3{get;set;}
        public String year{get;set;}
        public String name{get;set;}        
    }
}