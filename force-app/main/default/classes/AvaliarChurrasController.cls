public with sharing class AvaliarChurrasController {
    @AuraEnabled
    public static ResponseTO buscarAvalicoesPorOrcamentoChurras(Id idOrcamentoChurras){
        return AvaliacaoBO.buscarAvaliacoesPorOrcamentoChurras(idOrcamentoChurras);
    }
}
