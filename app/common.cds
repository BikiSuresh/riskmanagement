using {riskmanagement as schema} from '../db/schema';


annotate schema.Risks with {
    ID           @(title: 'Risk',
                   Common : {
                    Text: Title,
                    TextArrangement : #TextOnly,
                   });
    Title         @title: 'Title';
    Owner         @title: 'Owner';
    Description   @title : 'Description';
    to_Mitigation @(title : 'Mitigation',
                    Common: {
                        Text : to_Mitigation.Description,
                        TextArrangement : #TextOnly,
                    });
    to_BP @(title : 'Business Partner',
            Common : {
                Text: to_BP.FirstName,
                TextArrangement : #TextOnly,
                 } );
    Priority      @title: 'Priority';
    Impact        @(title: 'Impact');
};

annotate schema.Mitigations with {
    ID @(title : 'Mitigation',
          Common :{
            Text : Description,
            TextArrangement : #TextOnly,
          });
    Description @title: 'Description';
    Owner  @title : 'Owner';
    Timeline @title : 'Timeline';
    to_Risks @title : 'Risk'
};

annotate schema.Risks with {
    to_Mitigation @(
        Common: {
            ValueList :  {
                Label: 'Mitigations',
                CollectionPath : 'Mitigations',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : to_Mitigation_ID,
                        ValueListProperty : 'ID'
                    },
                    {
                        $Type : 'Common.ValueListParameterFilterOnly',
                        ValueListProperty : 'Description'
                    }
                ]
            }
        }
    );
    to_BP @(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                Label : 'Business Partner',
                CollectionPath : 'BusinessPartners',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty: to_BP_BusinessPartner,
                        ValueListProperty: 'BusinessPartner'
                    },
                    {
                        $Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'LastName'
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'FirstName'
                    }
                ]
            },
        }
    );
} ;

