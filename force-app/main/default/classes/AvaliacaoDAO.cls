public with sharing class AvaliacaoDAO {
    
    public static List<Avaliacao__c> buscarAvaliacoesPorIdOrcamentoChurras(Id idOrcamentoChurras){
        return [
                SELECT
                    Id,
                    Nota__c,
                    Observacoes__c,
                    Avaliador__c,
                    Avaliador__r.Name
                FROM
                    Avaliacao__c
                WHERE
                    OrcamentoChurras__c
                =:
                    idOrcamentoChurras
        ];
    }
}
