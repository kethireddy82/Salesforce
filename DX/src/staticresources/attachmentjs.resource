jQuery(function(){
 
    /*Checks when the notes and attachment section is loaded and then initiates the process.*/
    var timeInterval = setInterval(function(){
        if(jQuery("div.bRelatedList[id$=RelatedNoteList]").find("div.pbHeader").find("td.pbButton").find("input[name=attachFile]").length > 0){
            addAttachButton();
            clearInterval(timeInterval);
        }
    },100);
 
 
});
 
/*Adds the drop zone div in the notes and attachment section. Event listener are added to listen when files are dropped in the zone.*/
function addAttachButton() {
 
    var attachmentDiv = jQuery("div.bRelatedList[id$=RelatedNoteList]");
    insertButton();
 
    attachmentDiv.find("div.pbHeader").find("td.pbButton").after(
        jQuery("<td>", {
            style   : "width:35%;cursor:pointer;"
        }).append(jQuery("<div>",{
                style : "height: 30px;  width: px;border-color: orange;border: 3px solid orange;border-style: dotted;border-radius: 4px;text-align: center;vertical-align: middle;line-height: 2;color: Red;font-family: monospace;font-size: 14px;",
                id : "dropDiv"
            }).append(jQuery("<span>",{id:"clickHere"}).text('Drop files here / click here!') , jQuery("<span>",{id:"uploadingMessage",style:"display:none;"}).text('Uploading your Files, please wait!'))
        )
    );
 
    jQuery("#dropDiv").on('click',function(){
        if(jQuery("#uploadingMessage:hidden").length > 0) {
            if(jQuery("#multiUploadButton").length > 0) {
                jQuery("#multiUploadButton")[0].click();
            }else {
                insertButton();
                jQuery("#multiUploadButton")[0].click();
            }
        } else {
            alert('Your files are being uploaded. Please Wait!');
        }
    });
 
    function handleFileSelect(evt) {
        evt.stopPropagation();
        evt.preventDefault();
        var files = evt.dataTransfer.files; // FileList object.
        processFiles(files);
    }    
    function handleDragOver(evt) {
        evt.stopPropagation();
        evt.preventDefault();
        evt.dataTransfer.dropEffect = 'copy'; // Explicitly show this is a copy.
    }
 
    var dropZone = document.getElementById('dropDiv');
    dropZone.addEventListener('dragover', handleDragOver, false);
    dropZone.addEventListener('drop', handleFileSelect, false);
}
 
 
function processFiles(files) {
    hideDiv();
    var insertedFilesArray = [];
    var fileInsertionCounter = 0;
 
        for(i=0;i<files.length;i++) {
                     
            var reader = new FileReader();
            reader.onload = (function(newFile,pId) {
                return function(e) {
                    var attachmentBody = e.target.result.substring(e.target.result.indexOf(',')+1,e.target.result.length);
                         
                    jQuery.ajax({
                        type: "POST",
                        url: "https://"+window.location.host+"/services/data/v33.0/sobjects/Attachment/",
                        contentType:"application/json; charset=utf-8",
                        headers: { 
                            "Authorization" : "Bearer "+getCookie('sid')
                        },
                        data    : JSON.stringify({'name':newFile.name,'body':attachmentBody,'parentId':pId,'isprivate':false})
                    }).success(function(result) {
                        fileInsertionCounter++;
                        if(fileInsertionCounter == files.length){
                            showDiv();
                        }
                    }).fail(function(err){
                        alert('Unable to Insert file \n Contact your Adminstrator with this error message \n' + JSON.stringify(err));
                        fileInsertionCounter++;
                        //if all the files are uploaded then show the zone div.
                        if(fileInsertionCounter == files.length){
                            showDiv();
                        }
                    });
                };
            })(files[i],jQuery("div.bRelatedList[id$=RelatedNoteList]").attr('id').split('_')[0]);
             
            reader.readAsDataURL(files[i]);
        }
}
 
/*Inserts the input file button. This is hidden from the view.*/
function insertButton() {
    if(jQuery("#multiUploadButton").length == 0) {
        var attachmentDiv = jQuery("div.bRelatedList[id$=RelatedNoteList]");
        attachmentDiv.find("div.pbHeader").find("td.pbButton").append(
            jQuery("<input>",
                {id     : "multiUploadButton",
                value   : "Multiple Upload",
                type    : "file",
                multiple: "multiple",
                style   : "display:none;"
                })
        );
        jQuery("#multiUploadButton").on('change',function(){
            processFiles(document.getElementById("multiUploadButton").files);
        });
    }
}
 
function hideDiv() {
    jQuery("#uploadingMessage").show();
    jQuery("#clickHere").hide();
}
 
function showDiv() {
 
    jQuery("#uploadingMessage").hide();
    jQuery("#clickHere").show();
    RelatedList.get(jQuery("div.bRelatedList[id$=RelatedNoteList]").attr('id')).showXMore(30);
}
 
function getCookie(c_name){
    var i,x,y,ARRcookies=document.cookie.split(";");
    for (i=0;i<ARRcookies.length;i++){
        x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
        y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
        x=x.replace(/^\s+|\s+$/g,"");
        if (x==c_name){
            return unescape(y);
        }
    }
}