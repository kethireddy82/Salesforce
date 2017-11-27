public class wrapperClassController {
    public List<cCOntact> contList {get;set;}
    
    public List<cContact> getContacts()
    {
        if (contList == null)
        {
           contList = new List<cContact>();
          List<COntact> contList1 = [select id,name from contact limit 10];
            for (Contact c : contList1)
            {
                contList.add(new cContact(c));
            }
        }
        return contList;
    }
    
    public class cCOntact{         
            public boolean selected{get;set;}
            public Contact cont{get;set;}
            public cContact(Contact c)
            {
                cont = c;            
            }
        } 
}