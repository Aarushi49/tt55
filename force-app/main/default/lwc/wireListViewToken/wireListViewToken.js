import { LightningElement ,api,wire,track} from 'lwc';
import getAllOpps from '@salesforce/apex/getAllData.getAllOpps';

export default class DatatableEx12 extends LightningElement {
    @track columns = [{
            label: 'Name',
            fieldName: 'Name',
            type: 'text',
            sortable: true
        },
        {
            label: 'Organization Name',
            fieldName: 'Account.Name',
            type: 'text',
            sortable: true
        },
        {
            label: 'Email',
            fieldName: 'Email',
            type: 'Email',
            sortable: true
        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'Phone',
            sortable: true
        },
        {
            label: 'Add To Call List',
            fieldName: 'Add_To_Call_List__c',
            type: 'Boolean',
            sortable: true
        }

    ];
    @track error;
    @track data ;
    @wire(getAllOpps)
    wiredOpps({
        error,
        data
    }) {
        if (data) {
            this.data = data;
            console.log(data);
            console.log(JSON.stringify(data, null, '\t'));
        } else if (error) {
            this.error = error;
        }
    }
}