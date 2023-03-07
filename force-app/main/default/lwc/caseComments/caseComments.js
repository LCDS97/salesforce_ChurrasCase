import getComments from '@salesforce/apex/CaseController.getComments';
import { LightningElement, api } from 'lwc';

export default class CaseComments extends LightningElement {
  @api recordId;
  comments = [];
  currentIndex = 0;

  connectedCallback() {
    this.loadComments();
  }

  loadComments() {
    getComments({ caseId: this.recordId })
      .then(result => {
        this.comments = result.map(comment => ({
          id: comment.Id,
          body: comment.CommentBody,
          author: comment.CreatedBy.Name
        }));
      })
      .catch(error => {
        // Tratar erros de chamada Apex
      });
  }

  get currentComment() {
    return this.comments.find((comment, index) => index === this.currentIndex);
  }

  get disablePrevious() {
    return this.currentIndex === 0;
  }

  get disableNext() {
    return this.currentIndex === this.comments.length - 1;
  }

  handlePrevious() {
    if (!this.disablePrevious) {
      this.currentIndex--;
    }
  }

  handleNext() {
    if (!this.disableNext) {
      this.currentIndex++;
    }
  }
}