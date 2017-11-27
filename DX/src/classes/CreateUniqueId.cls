public class CreateUniqueId {
        public static string  generateUniqueId(dateTime dt){
            string returnstring= string.valueOf(dt).replace(':','');
            returnstring = returnstring.replace('-','');
            returnstring = returnstring.replace(' ','');
            string rand = string.valueOf(Math.round(Math.random()*10000));   
            string hashString = returnstring+rand;
            //Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
           // String hexDigest = EncodingUtil.convertToHex(hash);
            return hashString;
        }
        
        public static string   crypto(datetime dt)
        {
            String hashString = '1000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'));
            Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
            String hexDigest = EncodingUtil.convertToHex(hash);
            system.debug('##########' + hexDigest );
            return hexDigest;
        }
        
        public static string generateUniqueId(SObject sobj, Boolean isCreatedDate){
            string returnstring;
            if(isCreatedDate){
                dateTime dt =(DateTime)sobj.get('createddate');
                returnstring= string.valueOf(dt).replace(':','');
                returnstring = returnstring.replace('-','');
                returnstring = returnstring.replace(' ','');
                string rand = string.valueOf(Math.round(Math.random()*10000));
                returnstring = returnstring + rand;
            } else {
                returnstring= string.valueOf(system.now()).replace(':','');
                returnstring = returnstring.replace('-','');
                returnstring = returnstring.replace(' ','');
                string rand = string.valueOf(Math.round(Math.random()*10000));
                returnstring = returnstring + rand;
            }        
            return returnstring;
        }
    }