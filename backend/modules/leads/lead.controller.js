import { manualLeadService } from "./lead.service.js";

export const manualLead=async(req,res)=>{
  const {clientId}=req.user;

  const{
    campaignId,
    leadName,
    phoneNumber,
    email,
    interestedService
  }=req.body;

  const result = await manualLeadService(
    clientId,
    campaignId,
    leadName,
    phoneNumber,
    email,
    interestedService
  );
  return res.json(result);
};