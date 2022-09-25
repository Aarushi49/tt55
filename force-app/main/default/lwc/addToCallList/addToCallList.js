import { LightningElement, api, wire, track } from 'lwc';
import getAllLeads from '@salesforce/apex/getAllData.getAllLeads';
import getAllConts from '@salesforce/apex/getAllData.getAllConts';
import getAllAccts from '@salesforce/apex/getAllData.getAllAccts';


export default class DatatableEx12 extends LightningElement {
    value = 'Lead';
    columns;
    error;
    data;
    isLoading = false;
    searchString;


    get options() {
        return [
            { label: 'Lead', value: 'Lead' },
            { label: 'Contact', value: 'Contact' },
            { label: 'Organization', value: 'Organization' },
        ];
    }


    connectedCallback() {
        this.isLoading = true;
        this.setLeadData();
    }

    handleChange(event) {
        this.isLoading = true;

        this.value = event.detail.value;

        if (this.value == 'Lead') {
            this.setLeadData();
        } else if (this.value == 'Contact') {
            this.setContactData();
        } else if (this.value == 'Organization') {
            this.setOrganizationData();
        }
    }

    handleSearch(event) {
        this.isLoading = true;
        this.searchString = event.detail.value;
        if (this.value == 'Lead') {
            this.setLeadData();
        } else if (this.value == 'Contact') {
            this.setContactData();
        } else if (this.value == 'Organization') {
            this.setOrganizationData();
        }
    }


    setLeadData() {
        this.columns = [{
            label: 'Name',
            fieldName: 'Name',
            type: 'text',
            sortable: true
        },
        {
            label: 'Organization Name',
            fieldName: 'Company',
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
            type: 'Checkbox',
            sortable: true
        }

        ];

        getAllLeads({ SearchKey: this.searchString })
            .then(result => {
                this.data = result;
                this.isLoading = false;

            })
            .catch(error => {
                this.error = error;
                this.isLoading = false;
            });

    }

    setContactData() {
        this.columns = [{
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
            type: 'boolean'
        }

        ];

        getAllConts({ SearchKey: this.searchString })
            .then(result => {
                this.data = result;
                this.isLoading = false;

            })
            .catch(error => {
                this.error = error;
                this.isLoading = false;

            });


    }

    setOrganizationData() {

        this.columns = [{
            label: 'Name',
            fieldName: 'Name',
            type: 'text',
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
            type: 'Checkbox',
            sortable: true
        }

        ];


        getAllAccts({ SearchKey: this.searchString })
            .then(result => {
                this.data = result;
                this.isLoading = false;

            })
            .catch(error => {
                this.error = error;
                this.isLoading = false;

            });

    }


    handleclick() {
        this.isLoading = true;
        var el = this.template.querySelector('lightning-datatable');
        console.log(el);
        var selected = el.getSelectedRows();
        console.log(selected);
        this.isLoading = false;
    }

}