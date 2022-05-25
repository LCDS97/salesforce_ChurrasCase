import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import buscarAvaliacoesPorOrcamentoService from '@salesforce/apex/AvaliarChurrasController.buscarAvaliacoesPorOrcamentoChurras';

export default class AvaliarOrcamentoChurras extends LightningElement {

    @api recordId;

    @track lstAvaliacoes = [];
    @track lstAvaliacoesFiltradas = [];
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

                this.lstAvaliacoes = response.lstAvaliacoes;
                this.lstAvaliacoesFiltradas = response.lstObject;
            })
            .catch(error => {
                console.log(error);
            })
    }

    handleSuccess(event){
        this.showToast();
    }

    showToast() {
        const event = new ShowToastEvent({
            title: 'Sucesso!',
            message: 'Sua avaliação foi inserida com sucesso!',
        });
        this.dispatchEvent(event);
    }


}