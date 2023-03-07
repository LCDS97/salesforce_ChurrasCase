public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static List<CaseComment> getComments(String caseId) {
        List<CaseComment> resultados = new List<CaseComment>();
        resultados = [SELECT Id, CommentBody, CreatedBy.Name FROM CaseComment WHERE ParentId = :caseId];
        System.debug('Resultados: ' + resultados);

        return resultados;
    }
}
