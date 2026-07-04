import { manualLeadService,viewLeadsService,leadInfoService,changeStatusService, assignEmployeeService } from "./lead.service.js";

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
  if(!result.success){
    return res.status(result.statusCode).json(result);
  }
  return res.status(201).json(result);
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
  if(!result.success){
    return res.status(result.statusCode).json
      (result);
  }
  return res.status(200).json(result);


 }catch(error){
  console.error("view leads error:",error);

  return res.status(500).json({
    success:false,
    message:"internal server error"
  });
 }
};

export const leadInfo=async(req,res)=>{
  try{
    const{leadId}=req.params;
    const{employeeId,clientId,role}=req.user;

    const result= await leadInfoService(
      leadId,
      clientId,
      employeeId,
      role
    );
    if(!result.success){
      return res.status(result.statusCode).json(result);
    }
    return res.status(200).json(result);
  }catch(error){
    console.error("Lead info controller error:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server error"
    });
  }
};

export const changeStatus= async(req,res)=>{
  try{
    const {leadId}=req.params;
    const {employeeId,role}=req.user;
    const {status}=req.body;

    const result= await changeStatusService(
      leadId,
      employeeId,
      role,
      status
    );
    if(!result.success){
      return res.status(result.statusCode).json(result);
    }
    return res.status(result.statusCode).json(result);
  }catch(error){
    console.error("change status controller error:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server error "
    });
  }
};

export const assignEmployee= async(req,res)=>{
  try{
    const{leadId}=req.params;
    const{employeeId}=req.body;
    const result = await assignEmployeeService(
      leadId,
      employeeId
    );

    return res.status(result.statusCode).json(result);

  }catch(error){
    console.error("Error assign lead:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server error"
    });
  }
};