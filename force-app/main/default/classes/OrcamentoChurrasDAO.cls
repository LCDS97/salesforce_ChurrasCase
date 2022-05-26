public with sharing class OrcamentoChurrasDAO {
        public static List<OrcamentoChurras__c> buscarOrcamentosChurras(Set<Id> setIdOrcamentos){
            return [
                    SELECT 
                        Id,
                        Fim__c,
                        Inicio__c
                    FROM
                        OrcamentoChurras__c
                    WHERE
                        Id
                    =:
                        setIdOrcamentos
            ];
        }
    }
    
