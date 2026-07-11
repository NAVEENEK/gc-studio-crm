import { text } from "express";
import { changeStatusService, createFollowService, updateFollowService, viewFollowService } from "./follow.service.js";

export const createFollow=async(req,res)=>{
  try{
  const{leadId}=req.params;
  const{employeeId}=req.user;
  const{followUpDate,task}=req.body;
  if(!task?.trim()){
    return res.status(400).json({
      success:false,
      message:"task not found"
    });
  }
  const result=await createFollowService(
    leadId,
    employeeId,
    followUpDate,
    task
  );
  return res.status(result.statusCode).json(result);
  }catch(error){
    console.error("Error creating follow ups:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server Error"
    });
  }
};

export const changeStatus= async(req,res)=>{
  try{
    const{followId}=req.params;
    const{employeeId}=req.user;
    const{followStatus}=req.body;
    const result= await changeStatusService(
      followId,
      employeeId,
      followStatus
    );
    return res.status(result.statusCode).json(result);
  }catch(error){
    console.error("Error in updating status:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server Error"
    });
  }
};

export const updateFollow =async(req,res)=>{
  try{
    const{followId}=req.params;
    const{employeeId}=req.user;
    const{followUpDate,task}=req.body;
    const result= await updateFollowService(
      followId,
      employeeId,
      followUpDate,
      task
    );
    return res.status(result.statusCode).json(result);
  }catch(error){
    console.error("Error in follow up update:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server error"
    });
  }
};

export const viewFollow=async(req,res)=>{
  try{
    const{leadId,employeeId,status,filter}=req.params;
    if(filter && filter !== "today" && filter !== "overdue"){
      return res.status(400).json({
        success:false,
        message:"Invalid filter"
      });
    }
    const{myemployeeId,clientId,role}=req.user;
    const result=await viewFollowService(
      leadId,
      employeeId,
      myemployeeId,
      clientId,
      role,
      status,
      filter
    );
    return res.status(result.statusCode).json(result);
  }catch(error){
    console.error("Error in fetching :",error);

    return res.status(500).json({
      success:false,
      message:"Internal server error"
    });
  }
};