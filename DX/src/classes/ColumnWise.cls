public class ColumnWise {
    public List<Response__c> accs;
    public List<RowWrapper>  rows;
    public RowWrapper headings;
    public class RowWrapper
    {
        // the values (cells) making up this row
        public List<String> values {get; set;}
        
        // constructor
        public RowWrapper()
        {
            values=new List<String>();
        }
        
        // append a value (cell) to the row
        public void addValue(String value)
        {
            values.add(value);
        }
    }
    
     // retrieves the row wrapper containing the wrapped account headings
    public RowWrapper getHeadWrap()
    {
		// set up the headings
        if (null==headings)
        {
        	headings=new RowWrapper();
    		for (Integer idx=1; idx<=getAccounts().size(); idx++)
    		{
    			headings.addValue('Year ' + idx);
    		}
        }
                                  	 
        return headings;
    }
    
    public List<Response__c> getAccounts()
    {
        if (null==accs)
        {
            accs=[select name , State__c,Name1__c,Name2__c,Name3__c,Year__c from Response__c order by createddate  ];
        }
        
        return accs;
    }
    
    // retrieves the list of row wrappers
    public List<RowWrapper> getRowWrappers()
    {
        if (null==rows)
        {
            rows=new List<RowWrapper>();
            
            // create a row for each field - there are 4 of these, Name, Street, City and PostCode
            for (Integer idx=0; idx<4; idx++)
            {
                rows.add(new RowWrapper());
            }
            
            // iterate the accounts and populate the rows
            for (Integer idx=0; idx<getAccounts().size(); idx++)
            {
                rows[0].addValue(getAccounts()[idx].Name);
                rows[1].addValue(getAccounts()[idx].State__c);
                rows[2].addValue(getAccounts()[idx].Name1__c);
                rows[3].addValue(getAccounts()[idx].Name2__c);
            }
        }
        
        return rows;
    }
    
}