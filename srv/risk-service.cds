using { riskmanagement as schema } from '../db/schema';

@path: 'service/risk'
service RiskService @(impl: './risk-service.js') {

    entity Risks as projection on schema.Risks;
    annotate Risks with @odata.draft.enabled;
    
    entity Mitigations as projection on schema.Mitigations;
    annotate Mitigations with @odata.draft.enabled;
    
}