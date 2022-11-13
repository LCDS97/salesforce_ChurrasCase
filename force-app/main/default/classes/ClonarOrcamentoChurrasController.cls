public with sharing class ClonarOrcamentoChurrasController {
    @AuraEnabled
    public static OrcamentoChurras__c clonarOrcamentoChurrasComAnexos(Id recordId) {

        OrcamentoChurras__c orcamentoChurras = [SELECT Id, Name, Contato__c FROM OrcamentoChurras__c WHERE Id =: recordId];
        List<ItemOrcamentoChurras__c> lstItensOrcamentoChurras = [SELECT Id, Valor__c, Produto__c, OrcamentoChurras__c, Quantidade__c  FROM ItemOrcamentoChurras__c WHERE OrcamentoChurras__c =: recordId];
        List<ItemOrcamentoChurras__c> cloneItensOrcamentoChurras = new List<ItemOrcamentoChurras__c>();
        List<Id> lstIdsDocument = new List<Id>();
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
                ItemOrcamentoChurras__c itemOrcamentoChuuras = new ItemOrcamentoChurras__c();
                
                lstIdsDocument.add(iOC.Id);
                itemOrcamentoChuuras = iOC.clone(false,false,false,false);
                itemOrcamentoChuuras.OrcamentoChurras__c = orcamentoChurrasClone.Id;
                itemOrcamentoChuuras.Quantidade__c = iOC.Quantidade__c;
                itemOrcamentoChuuras.Valor__c = iOC.Valor__c;
                itemOrcamentoChuuras.Produto__c = iOC.Produto__c;
                cloneItensOrcamentoChurras.add(itemOrcamentoChuuras);
            }
            insert cloneItensOrcamentoChurras;

            for(ItemOrcamentoChurras__c itemOrcamento : cloneItensOrcamentoChurras){
                clonarAnexos(lstIdsDocument,itemOrcamento.Id);
            }

            update cloneItensOrcamentoChurras;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return orcamentoChurrasClone;
    }

    public static void clonarAnexos(List<Id> lstOldIdsDocument, id newOrcamentoId){

                List<ContentVersion> newLstCversion = new List<ContentVersion>();
                List<ContentVersion> cloneLstCversion = new List<ContentVersion>();
                Set<Id> setIds = new Set<Id>();
                List<ContentVersion> lstCVersion = [SELECT Id, PathOnClient, Title, ContentDocumentId, VersionData FROM ContentVersion WHERE FirstPublishLocationId IN: lstOldIdsDocument];

                for(ContentVersion cVersion : lstCVersion){
                    ContentVersion newCVersion = new ContentVersion();
                    newCVersion.PathOnClient = cVersion.PathOnClient;//File name with extention
                    newCVersion.Title = cVersion.Title;//Name of the file
                    newCVersion.VersionData = cVersion.VersionData;
                    newCVersion.FirstPublishLocationId = newOrcamentoId;
                    newLstCversion.add(newCVersion);
                }

                insert newLstCversion;

                for(ContentVersion cv : newLstCversion){
                    setIds.add(cv.Id);
                }
        
                List<ContentVersion> lstConDocument = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN: setIds];

                for(ContentVersion cLink : lstConDocument){
                    ContentDocumentLink cDocLink = new ContentDocumentLink();
                    cDocLink.ContentDocumentId = cLink.Id;
                    cDocLink.LinkedEntityId = newOrcamentoId;
                    cloneLstCversion.add(cLink);
                }

                update cloneLstCversion;
                
    }
}


