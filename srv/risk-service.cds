using { riskmanagement as schema } from '../db/schema';


@impl : './risk-service.js'
@path : 'service/risk'
service RiskService
{
    @odata.draft.enabled
    entity Risks @(restrict: [
        {
            grant : ['READ'],
            to : [ 'RiskViewer' ]
        },
        {
            grant :  ['*'],
            to : [ 'RiskManager' ]
        }
    ]) as
        projection on schema.Risks;

    @odata.draft.enabled
    entity Mitigations @(restrict: [
        {
            grant : ['READ'],
            to : [ 'RiskViewer' ]
        },
        {
            grant :  ['*'],
            to : [ 'RiskManager' ]
        }
    ]) as
        projection on schema.Mitigations;

    @readonly
    entity BusinessPartners as 
        projection on schema.BusinessPartners;
    
}
