public class Lookup {
    // ApexPages.StandardSetController must be instantiated
    // for standard list controllers
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Name FROM user]));
            }
            return setCon;
        }
        set;
    }

    // Initialize setCon and return a list of records
    public List<User> getUsers() {
        return (List<User>) setCon.getRecords();
    }
}