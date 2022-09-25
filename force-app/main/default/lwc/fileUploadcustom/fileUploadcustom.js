import { LightningElement, api } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import sheetjs from '@salesforce/resourceUrl/xlsx';
import insertRecords from '@salesforce/apex/fileUploadCustomClass.insertRecords';

let XLS = {};

export default class FileUploadExample extends LightningElement {
    dataFinal= [];

    connectedCallback() {
        Promise.all([
            loadScript(this, sheetjs)
        ]).then(() => {
            XLS = window.XLSX;
            //this.readFromFile()
        })
    }

    get acceptedFormats() {
        return ['.xlsx', '.csv'];
    }

    openfileUpload(event) {
        alert('good 22');
        const file = event.target.files[0]
        var reader = new FileReader()
        reader.onload = () => {
            alert('yesssssssss');
            var data = reader.result
            var workbook = XLS.read(data, {
                type: 'binary'
            }); 
            alert('22');
            console.log('workbook.Sheets---',workbook.Sheets)
            console.log('workbook.SheetNames---',workbook.SheetNames)

            let arrayNew = [];
            workbook.SheetNames.forEach(function (sheetName) {
                let rowObj = XLS.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
                arrayNew[sheetName] = rowObj;
            })

            const jsonString = JSON.stringify(Object.assign({}, arrayNew))

            console.log('this.dataFinal--',jsonString);
            this.dataFinal = jsonString;
         
            console.log('33--',this.dataFinal);
        }
        reader.readAsBinaryString(file)
    }
    

    handleClick() {
        console.log('44--',this.dataFinal);
        insertRecords({ finalData: this.dataFinal })
        .then((result) => {
            alert('Sent');

        })
        .catch((error) => {
            alert('Not Sent');

        });
    }
}