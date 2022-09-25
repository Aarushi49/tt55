({
    setupTable : function(component, data){
        var cols = component.get("v.columns"),
            data = component.get("v.data");
        
        this.setupColumns(component, cols);
        this.setupData(component, data);
        component.set("v.isLoading", false);
    },

    setupColumns : function(component, cols){
        var tempCols = [];
        if(cols){
            /*COLUMNS SHOULD BE IN BELOW FORMAT
            [{label: "Oppotunity Name", fieldName: "oppLink", type:"link", sortable: true, resizable: true, 
              attributes:{label:{fieldName:"Name"}, title:"Click to View(New Window)", target:"_blank"}},
             {label: "Type", fieldName: "Type", editable: true, type:"picklist", selectOptions:types},            
             {label: "Stage", fieldName: "StageName", sortable: true},                                
             {label: "Close Date", fieldName: "CloseDate", type:"date", editable: true, resizable: true}, 
             {label: "Amount", fieldName: "Amount", type:"number", editable: true, attributes:{formatter:"currency"}},
             {label: "Owner", fieldName: "ownerLink", type:"link", sortable: true, resizable: true, 
              attributes:{label:{fieldName:"ownerName"}, title:"Click to View(New Window)", target:"_blank"}}],
            */
            cols.forEach(function(col) {
                //set col values
                col.thClassName = "slds-truncate";
                col.thClassName += col.sortable === true ? " slds-is-sortable" : "";
                col.thClassName += col.resizable === true ? " slds-is-resizable" : "";
                col.style = col.width ? "width:"+col.width+"px;" : "";
                col.style += col.minWidth ? "min-width:"+col.minWidth+"px;" : "";
                col.style += col.maxWidth ? "max-width:"+col.maxWidth+"px;" : "";
                if(col.sortable === true){
                    col.sortBy = col.fieldName;
                    if(col.type === "link" && col.attributes && typeof col.attributes.label === "object")
                        col.sortBy = col.attributes.label.fieldName;
                }
                //if(!tableData) col.thClassName = "";
                tempCols.push(col);
            });
            component.set("v.columns", JSON.parse(JSON.stringify(tempCols)));
        }
    },
    
    setupData : function(component, data){        
        var tableData = [], cols = component.get("v.columns");
        component.set("v.dataCache", JSON.parse(JSON.stringify(data)));

        if(data){
            data.forEach(function(value, index) {
                var row = {}, fields = [];
                cols.forEach(function(col) {
                    //set data values
                    var field = {};
                    field.name = col.fieldName;
                    field.value = value[col.fieldName];
                    field.type = col.type ? col.type : "text";
                    if(field.type === "date"){
                        field.isViewSpecialType = true;
                    }
                    if(field.type === "number"){
                        field.isViewSpecialType = true;
                        if(col.attributes){
                            field.formatter = col.attributes.formatter;
                            field.style = col.attributes.formatter;
                            field.minimumFractionDigits = col.attributes.minimumFractionDigits ? col.attributes.minimumFractionDigits : 0;
                            field.maximumFractionDigits = col.attributes.maximumFractionDigits ? col.attributes.maximumFractionDigits : 2;
                            field.currencyCode = col.attributes.currencyCode ? col.attributes.currencyCode : "USD";
                        }
                    }
                    if (field.type === "custom-number") {
                        field.isViewSpecialType = true;
                        field.formattedValue = value[col.attributes.formattedValue];
                    }
                    if(field.type === "picklist"){
                        field.isEditSpecialType = true;
                        field.selectOptions = col.selectOptions;
                    }                        
                    if(field.type === "link"){
                        field.isViewSpecialType = true;
                        if(col.attributes){
                            if(typeof col.attributes.label === "object")
                                field.label = value[col.attributes.label.fieldName];
                            else field.label = col.attributes.label;

                            if(typeof col.attributes.title === "object")
                                field.title = value[col.attributes.title.fieldName];
                            else field.title = col.attributes.title;
                            
                            if(col.attributes.actionName){
                                field.type = "link-action";
                                field.actionName = col.attributes.actionName;
                            }                                
                            field.target = col.attributes.target;
                        }
                    }
                    if (field.type === 'avatar') {
                        field.isViewSpecialType = true;
                        field.initials = field.value.match(/\b(\w)/g).join('').toUpperCase();
                        if(typeof col.attributes.bgColor === "object")
                            field.bgColor = value[col.attributes.bgColor.fieldName];
                        else field.bgColor = col.attributes.bgColor;

                        if(typeof col.attributes.avatarUrl === "object")
                            field.avatarUrl = value[col.attributes.avatarUrl.fieldName];
                        else field.avatarUrl = col.attributes.avatarUrl;
                    }
                    if (field.type === 'avatars') {
                        field.isViewSpecialType = true;
                    }
                    if (field.type === 'badge') {
                        field.badgeData = value[col.attributes.meta.fieldName];
                        field.isViewSpecialType = true;
                        if (col.editable) {
                            field.isEditSpecialType = true;
                        }
                    }
                    field.editable = col.editable ? col.editable : false;
                    field.tdClassName = field.editable === true ? 'slds-cell-edit' : '';
                    field.mode = "view";
                    fields.push(field);
                });
                row.id = value.Id;
                row.fields = fields;
                tableData.push(row);
            });

            // handle rollups
            var rollupColumns = component.get("v.rollupColumns");
            if (rollupColumns.length > 0) {
                var row = {}, fields = [];
                rollupColumns.forEach(function(value, index) {
                    cols.forEach(function(col) {
                        var field = {};
                        field.name = col.fieldName;
                        field.type = col.type ? col.type : "text";
                        if (value === col.fieldName) {
                            field.value = data.reduce((a,b) => a + (b[value] || 0), 0);
                            if (field.type === 'custom-number') {
                                var amount = field.value;
                                if (amount >= 1.0e+6) {
                                    amount = '$' + (amount / 1.0e+6).toFixed(3) + 'M';
                                } else if (amount >= 1.0e+3) {
                                    amount = '$' + parseInt(amount / 1.0e+3) + 'K';
                                } else {
                                    amount = amount ? ('$' + amount) : "";
                                }
                                field.formattedValue = amount;
                            }
                        } else {
                            field.value = null;
                        }
                        if(field.type === "number"){
                            if(col.attributes){
                                field.formatter = col.attributes.formatter;
                                field.style = col.attributes.formatter;
                                field.minimumFractionDigits = col.attributes.minimumFractionDigits ? col.attributes.minimumFractionDigits : 0;
                                field.maximumFractionDigits = col.attributes.maximumFractionDigits ? col.attributes.maximumFractionDigits : 2;
                                field.currencyCode = col.attributes.currencyCode ? col.attributes.currencyCode : "USD";
                            }
                        }
                        field.isViewSpecialType = true;
                        field.mode = "view";
                        fields.push(field);
                    });
                });
                row.id = 'rollup-row';
                row.fields = fields;
                row.hideRowNumberColumn = true;
                tableData.push(row);
            }

            component.set("v.tableData", tableData);
            component.set("v.tableDataOriginal", JSON.parse(JSON.stringify(tableData)));
            component.set("v.updatedTableData", JSON.parse(JSON.stringify(tableData)));
        }
    },

    updateTable : function(component, rowIndex, colIndex, value){
        //Update Displayed Data
        var data = component.get("v.tableData");
        data[rowIndex].fields[colIndex].value = value;
        component.set("v.tableData", data);
        
        //Update Displayed Data Cache
        var updatedData = component.get("v.updatedTableData");
        updatedData[rowIndex].fields[colIndex].value = value;
        updatedData[rowIndex].fields[colIndex].mode = "view";
        component.set("v.updatedTableData", updatedData);
        
        //Update modified records which will be used to update corresponding salesforce records
        var records = component.get("v.modifiedRecords");
        var recIndex = records.findIndex(rec => rec.id === data[rowIndex].id);
        if(recIndex !== -1){
            records[recIndex][""+data[rowIndex].fields[colIndex].name] = value;
        }else{
            var obj = {};
            obj["id"] = data[rowIndex].id;
            obj[""+data[rowIndex].fields[colIndex].name] = value;
            records.push(obj);
        }
        component.set("v.modifiedRecords", records);

        //Update Data Cache
        var dataCache = component.get("v.dataCache");
        var recIndex = dataCache.findIndex(rec => rec.Id === data[rowIndex].id);
        var fieldName = data[rowIndex].fields[colIndex].name;
        dataCache[recIndex][fieldName] = value;
        component.set("v.dataCache", dataCache);
    },
    
    sortData : function(component, sortBy, sortDirection){
        var reverse = sortDirection !== "asc",
            data = component.get("v.dataCache");
        if(!data) return;
        
        var data = Object.assign([], data.sort(this.sortDataBy(sortBy, reverse ? -1 : 1)));
        this.setupData(component, data);
    },
    
    sortDataBy : function (field, reverse, primer) {
        var key = primer
        ? function(x) { return primer(x[field]) }
        : function(x) { return x[field] };
        
        return function (a, b) {
            var A = key(a);
            var B = key(b);
            return reverse * ((A > B) - (B > A));
        };
    },
    
})