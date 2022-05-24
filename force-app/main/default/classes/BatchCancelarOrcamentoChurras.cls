public class BatchCancelarOrcamentoChurras  implements Database.Batchable<SObject> {



        public Database.QueryLocator start(Database.BatchableContext bc){
            return Database.getQueryLocator([SELECT
                                                Id,
                                                Fim__c,
                                                Status__c 
                                            FROM 
                                                OrcamentoChurras__c
                                            WHERE
                                                Fim__c < LAST_N_DAYS:1 
                                            AND 
                                                (   Status__c = 'Agendado'
                                                OR
                                                    Status__c = 'Novo'
                                                )
                                            ]);
        }
    
        public void execute(Database.BatchableContext bc, List<OrcamentoChurras__c> lstOrcamentos){

            for(OrcamentoChurras__c orcamento : lstOrcamentos){
                orcamento.Status__c = 'Cancelado';
            }
    
            update lstOrcamentos;
            
        }
    
        public void finish(Database.BatchableContext bc){
    
        }
    
    
    
    
    
}
