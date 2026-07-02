import { manualLeadService,viewLeadsService } from "./lead.service.js";

export const manualLead=async(req,res)=>{
 try{
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
 }catch(error){
  console.error("manual lead error:",error);

  return res.status(500).json({
    success:false,
    message:"Internal server Error "
  });
 }
};

export const viewLeads=async(req,res)=>{
 try{
   const{employeeId,clientId,role}=req.user;

  const result= await viewLeadsService(
    employeeId,
    clientId,
    role
  );
  return res.json(result);
 }catch(error){
  console.error("view leads error:",error);

  return res.json(500).json({
    success:false,
    message:"internal server error"
  });
 }
};