import { LightningElement, api, track } from 'lwc';

import buscarAvaliacoesPorOrcamentoService from '@/salesforce/apex/AvaliarChurrasController.buscarAvalicoesPorOrcamentoChurras';

export default class AvaliarOrcamentoChurras extends LightningElement {

    @api recordId;

    @track lstAvalicaoes = [];
    @track lstAvalicaoesFiltradas = [];
    @track apresentarAvaliacoes = true;

    connectedCallback(){
        this.carregarAvaliacoes(this.recordId);
    }

    carregarAvaliacoes(idOrcamentoChurras){
        buscarAvaliacoesPorOrcamentoService({ idOrcamentoChurras })
            .then(response => {
                if(!response.sucesso || response.lstObject.length == 0){
                    this.apresentarAvaliacoes = false;

                }

                this.lstAvalicaoes = response.lstAvalicaoes;
                this.lstAvalicaoesFiltradas = response.lstObject;
            })
            .catch(response => {
                console.log(error);
            })
    }


}