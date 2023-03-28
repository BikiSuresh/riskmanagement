using RiskService as service from '../../srv/risk-service';


annotate service.Risks with @(UI : {

    //Header information
    HeaderInfo  : {
        TypeName : 'Risk',
        TypeNamePlural : 'Risks',
        Title : {
            $Type : 'UI.DataField',
            Value : Title
        },
        Description : {
            $Type : 'UI.DataField',
            Value : Description
        }
    },

    //Selection Fields
    SelectionFields  : [
        Impact,
    ],

    // List Report 
    LineItem  : [
        {Value : ID},
        {Value : to_Mitigation_ID },
        {Value : Owner },
        {Value: to_BP_BusinessPartner },
        {   
            Value : Priority  ,
            Criticality : criticality 
        },
        {
            Value : Impact,
            Criticality : criticality
        }
    ],

    //Overview Page
    HeaderFacets  : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Priority',
            ID : 'Priority',
            Target: '@UI.DataPoint#Priority'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Impact',
            ID : 'Impact',
            Target: '@UI.DataPoint#Impact'
        },

    ],

    DataPoint #Priority : {
        Value : Priority,
        Criticality : criticality,
        Title : 'Priority'
    },

    DataPoint #Impact : {
        Value : Impact,
        Criticality : criticality,
        Title : 'Impact'
    },

    // Header Facet
    Facets  : [
        // {
        //     $Type : 'UI.CollectionFacet',
        //     Label : 'General',
        //     ID : 'General',
        // },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'History',
            ID : 'General',
            Target: '@UI.FieldGroup#History'
        },
        {
            $Type :'UI.ReferenceFacet',
            Label : 'Risk Data',
            Target : '@UI.FieldGroup#Risk'
        }
    ],

    FieldGroup #History : {
       Data : [
            {
                Value : createdAT,
                Label : 'Created At'
            },
            {
                Value : createdBy,
                Label : 'Created By'
            },
            {
                Value : modifiedAT,
                Label : 'Last Changed at'
            },
            {
                Value : modifiedBy,
                Label : 'Last Changed By'
            }
       ]
        
    },

    FieldGroup #Risk : {
        Data : [
            {
                Value : to_Mitigation_ID,
            },
            {
                Value : Title,
            },
            {
                Value : Owner,
            },
            {
                Value : to_BP_BusinessPartner,
            },
            {
                Value : Description,
            },
            {
                Value : Priority,
            },
            {
                Value : Impact,
            }
        ]
    },
});
