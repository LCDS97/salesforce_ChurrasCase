public with sharing class ClonarOrcamentoChurrasController {
    @AuraEnabled
    public static OrcamentoChurras__c clonarOrcamentoChurrasComAnexos(Id recordId) {

        OrcamentoChurras__c orcamentoChurras = [SELECT Id, Name, Contato__c FROM OrcamentoChurras__c WHERE Id =: recordId];
        List<ItemOrcamentoChurras__c> lstItensOrcamentoChurras = [SELECT Id, Valor__c, Produto__c, OrcamentoChurras__c, Quantidade__c  FROM ItemOrcamentoChurras__c WHERE OrcamentoChurras__c =: recordId];
        List<ItemOrcamentoChurras__c> cloneItensOrcamentoChurras = new List<ItemOrcamentoChurras__c>();
        List<Id> lstIdsDocument = new List<Id>();
        Id idDocument;
        String strDate = String.valueOf(Datetime.now());

        OrcamentoChurras__c orcamentoChurrasClone = new OrcamentoChurras__c();

        orcamentoChurrasClone = orcamentoChurras.clone(false,false,false,false);

        orcamentoChurrasClone.Name = orcamentoChurras.Name + ' ' + strDate;
        orcamentoChurrasClone.Contato__c = orcamentoChurras.Contato__c;
        orcamentoChurrasClone.Inicio__c = Date.today().addDays(1);
        orcamentoChurrasClone.Fim__c = Date.today().addDays(7);


        try {
            insert orcamentoChurrasClone;

            for(ItemOrcamentoChurras__c iOC : lstItensOrcamentoChurras){
                ItemOrcamentoChurras__c itemOrcamentoChurras = new ItemOrcamentoChurras__c();
                
                idDocument = iOC.Id;
                itemOrcamentoChurras = iOC.clone(false,false,false,false);
                itemOrcamentoChurras.OrcamentoChurras__c = orcamentoChurrasClone.Id;
                itemOrcamentoChurras.Quantidade__c = iOC.Quantidade__c;
                itemOrcamentoChurras.Valor__c = iOC.Valor__c;
                itemOrcamentoChurras.Produto__c = iOC.Produto__c;
                // cloneItensOrcamentoChurras.add(itemOrcamentoChuuras);
                insert itemOrcamentoChurras;
                clonarAnexos(iOc.Id,itemOrcamentoChurras.Id);
            }
            

            // for(ItemOrcamentoChurras__c itemOrcamento : cloneItensOrcamentoChurras){
            //     clonarAnexos(idDocument,itemOrcamento.Id);
            // }

            // upsert cloneItensOrcamentoChurras;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return orcamentoChurrasClone;
    }

    // public static void clonarAnexos(List<Id> lstOldIdsDocument, id newOrcamentoId){
    // public static void clonarAnexos(Id oldIdDocument, id newOrcamentoId){

    //             List<ContentVersion> newLstCversion = new List<ContentVersion>();
    //             List<ContentVersion> cloneLstCversion = new List<ContentVersion>();
    //             Set<Id> setIds = new Set<Id>();
    //             ContentVersion cVersion = [SELECT Id, PathOnClient, Title, ContentDocumentId, VersionData FROM ContentVersion WHERE FirstPublishLocationId =: oldIdDocument LIMIT 1];
    //                 ContentVersion newCVersion = new ContentVersion();
    //                 newCVersion.PathOnClient = cVersion.PathOnClient;//File name with extention
    //                 newCVersion.Title = cVersion.Title;//Name of the file
    //                 newCVersion.VersionData = cVersion.VersionData;
    //                 newCVersion.FirstPublishLocationId = newOrcamentoId;
    //                 insert newCVersion;
    //             // List<ContentVersion> lstCVersion = [SELECT Id, PathOnClient, Title, ContentDocumentId, VersionData FROM ContentVersion WHERE FirstPublishLocationId IN: lstOldIdsDocument];

    //             // for(ContentVersion cVersion : lstCVersion){
    //             //     ContentVersion newCVersion = new ContentVersion();
    //             //     newCVersion.PathOnClient = cVersion.PathOnClient;//File name with extention
    //             //     newCVersion.Title = cVersion.Title;//Name of the file
    //             //     newCVersion.VersionData = cVersion.VersionData;
    //             //     newCVersion.FirstPublishLocationId = newOrcamentoId;
    //             //     newLstCversion.add(newCVersion);
    //             // }

    //             // insert newLstCversion;

    //             // for(ContentVersion cv : newLstCversion){
    //             //     setIds.add(cv.Id);
    //             // }
        
    //             // List<ContentVersion> lstConDocument = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN: setIds];
    //             ContentVersion ConDocument = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: newCversion.Id];
    //                 ContentDocumentLink cDocLink = new ContentDocumentLink();
    //                 cDocLink.ContentDocumentId = ConDocument.Id;
    //                 cDocLink.LinkedEntityId = newOrcamentoId;  
    //             update conDocument;             

    //             // for(ContentVersion cLink : lstConDocument){
    //             //     ContentDocumentLink cDocLink = new ContentDocumentLink();
    //             //     cDocLink.ContentDocumentId = cLink.Id;
    //             //     cDocLink.LinkedEntityId = newOrcamentoId;
    //             //     cloneLstCversion.add(cLink);
    //             // }

    //             // update cloneLstCversion;
                
    // }
    public static void clonarAnexos(Id orcamentoQueried, Id orcamentoClone){
        List<ContentDocumentLink> documentsLinks = [Select Id, ContentDocumentId From ContentDocumentLink where LinkedEntityId = :orcamentoQueried];
        Set<Id> idsDocumentsLinks = new Set<Id>();
        for(ContentDocumentLink doc :documentsLinks)
            idsDocumentsLinks.add(doc.ContentDocumentId);
        
        List<ContentVersion> anexos = [SELECT ContentLocation, ContentUrl, Description, FeaturedContentDate,FileExtension,FileType, 
                                       FirstPublishLocationId,Id, NegativeRatingCount,Origin,PathOnClient,PositiveRatingCount,
                                       PublishStatus,RatingCount,ReasonForChange, TextPreview,Title,VersionData,VersionNumber
                                       FROM ContentVersion where ContentDocumentId in :idsDocumentsLinks]; 
      
        if(anexos.size() > 0){
            Map<Id, List<ContentVersion>> mapFilesByOrcamentoChurrasId = new Map<Id, List<ContentVersion>>();
           
            ContentVersion conVer;
            for(ContentVersion cv :anexos){
                conVer = new ContentVersion();
                conVer.ContentLocation = cv.ContentLocation; // S specify this document is in SF, use E for external files
                conVer.PathOnClient = cv.PathOnClient; // The files name, extension is very important here which will help the file in preview.
                conVer.Title = cv.Title; // Display name of the files
                conVer.VersionData = cv.VersionData; // converting your binary string to Blog
                
                if(mapFilesByOrcamentoChurrasId.containsKey(orcamentoClone))
                    mapFilesByOrcamentoChurrasId.get(orcamentoClone).add(conVer);
                else
                    mapFilesByOrcamentoChurrasId.put(orcamentoClone, new List<ContentVersion>{ conVer });
                
                
            }
            
            List<ContentVersion> cvtoInsert = new List<ContentVersion>();
            for(Id idCv :mapFilesByOrcamentoChurrasId.keyset())
                cvtoInsert.addAll(mapFilesByOrcamentoChurrasId.get(idCv));
            
            insert cvtoInsert;
            
            Set<Id> idsFile = new Set<Id>();
            
            for(ContentVersion cv :cvtoInsert)
                idsFile.add(cv.Id);
            
            List<ContentVersion> files = [SELECT ContentDocumentId FROM ContentVersion WHERE Id in :idsFile];
            
            List<ContentDocumentLink> documentLinksToInsert = new List<ContentDocumentLink>();
            for(ContentVersion cv :files){
                //Create ContentDocumentLink
                ContentDocumentLink cDe = new ContentDocumentLink();
                cDe.ContentDocumentId = cv.ContentDocumentId;
                cDe.LinkedEntityId = orcamentoClone; 
                documentLinksToInsert.add(cDe);
            }
            insert documentLinksToInsert;
        }
    }
}


