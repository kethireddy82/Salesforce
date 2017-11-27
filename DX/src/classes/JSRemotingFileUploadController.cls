public class JSRemotingFileUploadController {
    
    @RemoteAction
    public static String processChunk(String parentId, String attachmentId, String attachmentName, String base64ChunkPayload) {
        if(parentId != null) {
            Account account = getAccount(parentId);
            if(account != null) {
                if(base64ChunkPayload != null) {
                    Attachment attachment = getAttachment(attachmentId);
                    String newBody = '';
                    if(attachment.Body != null) {
                        newBody = EncodingUtil.base64Encode(attachment.Body);
                    }
                    newBody += base64ChunkPayload;
                    attachment.Body = EncodingUtil.base64Decode(newBody);
                    if(attachmentId == null) {
                        attachment.Name = attachmentName;
                        attachment.parentId = account.Id;
                    }
                    upsert attachment;
                    return attachment.Id;
                } else {
                    return 'Attachment Body was null';
                }
            } else {
                return 'Parent record could not be found';
            }
        } else {
            return 'Parent Id was null';
        }
    }

    private static Attachment getAttachment(String attachmentId) {
        List<Attachment> attachments = [SELECT Id, Body
                                        FROM Attachment 
                                        WHERE Id =: attachmentId];
        if(attachments.isEmpty()) {
            Attachment a = new Attachment();
            return a;
        } else {
            return attachments[0];
        }
    }
    
    private static Account getAccount(String accountId) {
        List<Account> accounts = [SELECT Id, Name
                                  FROM Account
                                  WHERE Id =:accountId];
        if(accounts.isEmpty()) {
            return null;
        } else {
            return accounts[0];
        }
    }
}