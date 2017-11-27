public class mswrapper
{
    public class saiwrapper
    {
        public string Accname    {get;set;}
        public string accnum     {get;set;}
        public string confstname {get;set;}
        public string conlstname {get;set;}
        public double oppamount  {get;set;}
        public string oppstgname {get;set;}
    }
    
    public list<saiwrapper> wrplst {get;set;}
    public Map<Integer,Saiwrapper> smap{get;set;}
    
    public mswrapper()
    {
        smap=new Map<Integer,Saiwrapper>();
        wrplst = new list<saiwrapper>();
        saiwrapper swrp;
        Integer counter=1;
        for(Account Acclst : [SELECT Name,AccountNumber FROM Account] )
        {
            swrp = new saiwrapper();
            swrp.Accname = Acclst.Name;
            swrp.accnum = Acclst.AccountNumber;
            //wrplst.add(swrp);
            smap.put(counter++,swrp);
        }
        counter=1;
        for(Contact conlst :[SELECT FirstName,LastName FROM Contact])
        { 
            //swrp = new saiwrapper();
            smap.get(counter).confstname = conlst.FirstName;
            smap.get(counter).conlstname = conlst.LastName;
            counter=counter+1;
            //wrplst.add(swrp);
        }
        counter=1;
        for(Opportunity opplst :[SELECT Amount,StageName FROM Opportunity WHERE Amount < 10000 LIMIT 10])
        {
            //swrp = new saiwrapper();
            smap.get(counter).oppamount = opplst.Amount;
            smap.get(counter).oppstgname = opplst.StageName;
            counter=counter+1;
            //wrplst.add(swrp);
        }
        for(Integer k:smap.keySet())
            wrplst.add(smap.get(k));
    }
}