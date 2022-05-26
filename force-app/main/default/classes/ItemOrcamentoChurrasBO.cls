public with sharing class ItemOrcamentoChurrasBO {
    
    public static void validarSePossuiItemDuplicado(List<ItemOrcamentoChurras__c> lstItensOrcamentosNovo){
        Set<Id> setOrcamentosId = new Set<Id>();
        Set<Id> setProdutosItemOrcamentoId = new Set<Id>();
        List<ItemOrcamentoChurras__c> lstItensOrcamentosComProduto = new List<ItemOrcamentoChurras__c>();

        for(ItemOrcamentoChurras__c item : lstItensOrcamentosNovo){
            if(item.Produto__c != null){
                setProdutosItemOrcamentoId.add(item.Produto__c);
                setOrcamentosId.add(item.OrcamentoChurras__c);
                lstItensOrcamentosComProduto.add(item);
            }
        }

        if(lstItensOrcamentosNovo.isEmpty()) return;

        List<ItemOrcamentoChurras__c> lstProdutoRepetidoItemOrcamento = ItemOrcamentoChurrasDAO.buscarItemOrcamentoPorIdEProduto(setOrcamentosId,setProdutosItemOrcamentoId);

        for(ItemOrcamentoChurras__c produto : lstItensOrcamentosComProduto){
            if(lstProdutoRepetidoItemOrcamento.size() >= 1){
                produto.Produto__c.addError('Não é possível cadastrar esse produto, pois ele ja consta em um Item de Orçamento');
            }
        }

    }

    public static void preencherValorAutomatico(List<ItemOrcamentoChurras__c> lstItensOrcamentosNovo){
        TabelaPrecosServicos__mdt valorChurrasqueiro = TabelaPrecosServicos__mdt.getInstance('ServicoChurrasqueiro');
        Decimal valorHoraChurrasqueiro = valorChurrasqueiro.ValorHoraServico__c;

        TabelaPrecosServicos__mdt valorGarcom = TabelaPrecosServicos__mdt.getInstance('ServicoGarcom');
        Decimal valorHoraGarcom = valorGarcom.ValorHoraServico__c;

        TabelaPrecosServicos__mdt valorLimpeza = TabelaPrecosServicos__mdt.getInstance('ServicoLimpeza');
        Decimal valorHoraLimpeza = valorLimpeza.ValorHoraServico__c;

        List<ItemOrcamentoChurras__c> lstItensComProduto = new List<ItemOrcamentoChurras__c>();
        List<Product2> lstProdutoTipoProduto = new List<Product2>();
        List<Product2> lstProdutoTipoServico = new List<Product2>();
        Set<Id> setIdsProdutos = new Set<Id>();
        Set<Id> setIdsOrcamentos = new Set<Id>();

        for(ItemOrcamentoChurras__c item : lstItensOrcamentosNovo){
            //if(item.Produto__c != null){
                lstItensComProduto.add(item);
                setIdsProdutos.add(item.Produto__c);
                setIdsOrcamentos.add(item.OrcamentoChurras__c);
           // }
        }

        if(lstItensComProduto.isEmpty()) return;

        List<Product2> verificarTipoRegistroProduto = Product2DAO.buscarProdutosTipoRegistro(setIdsProdutos);
        List<OrcamentoChurras__c> lstOrcamentosChurras = OrcamentoChurrasDAO.buscarOrcamentosChurras(setIdsOrcamentos);



        for(Product2 produto : verificarTipoRegistroProduto){
            if(produto.RecordTypeId == '0128a000001ANe0AAG'){  // Record Type Id = Produto
                //lstProdutoTipoProduto.add(produto);
                for(ItemOrcamentoChurras__c itemOrcamento : lstItensComProduto){
                    if(itemOrcamento.Valor__c == null && itemOrcamento.Quantidade__c == null){
                        itemOrcamento.Valor__c = 0;
                        itemOrcamento.Quantidade__c = 0;
                        itemOrcamento.Valor__c = itemOrcamento.Quantidade__c * produto.Valor__c;
                    } else {
                        itemOrcamento.Valor__c = itemOrcamento.Quantidade__c * produto.Valor__c;
                    }
                }

            }
            
             if(produto.RecordTypeId == '0128a000001ANcgAAG'){ // Record Type Id = Serviço
                for(OrcamentoChurras__c orcamento : lstOrcamentosChurras){
                    System.debug('##### Orcamento' + orcamento);
                    Long horaInicio = orcamento.Inicio__c.getTime();
                    Long horaFim = orcamento.Fim__c.getTime();
                    
                    Double horaEvento = Math.floor(horaFim - horaInicio );

                    Double mins = horaEvento / 60000;
                    Double hours = mins / 60;
                    Double remainingMins = mins - ( hours * 60);
                    Double hoursMinutes = hours + remainingMins;

                    Double horaEventoConvertida = Math.floor(hoursMinutes);

                    
                        for(ItemOrcamentoChurras__c itemOrcamento : lstItensComProduto){
                            if(produto.Servico__c == 'Churrasqueiro'){
                                itemOrcamento.Valor__c = itemOrcamento.Quantidade__c * ( valorHoraChurrasqueiro * horaEventoConvertida);
                            }
                            if(produto.Servico__c == 'Limpeza'){
                                itemOrcamento.Valor__c = itemOrcamento.Quantidade__c * ( valorHoraLimpeza * horaEventoConvertida);
                            }
                            if(produto.Servico__c == 'Garcom'){
                                itemOrcamento.Valor__c = itemOrcamento.Quantidade__c * ( valorHoraGarcom * horaEventoConvertida);
                            }

                        }
                }
            }
        }
        
    }

}
