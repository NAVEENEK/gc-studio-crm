
import { createNoteService, updateNoteService, viewNoteService } from "./note.service.js";

export const createNote= async(req,res)=>{
  try{
  const{leadId}=req.params;
  const{employeeId}=req.user;
  const{note}=req.body;
  if(!note?.trim()){
    return res.status(400).json({
      success:false,
      message:"note is required"
    });
  }
  const result=await createNoteService(
    leadId,
    employeeId,
    note
  );

  return res.status(result.statusCode).json(result);
  }catch(error){
    console.error("Error create note:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server error"
    });
  }
};

export const viewNote=async(req,res)=>{
  try{
    const{leadId}=req.params;
  const{employeeId}=req.user;
  const result=await viewNoteService(
    leadId,
    employeeId
  );
  return res.status(result.statusCode).json(result);
  }catch(error){
    console.error("Error viewing notes:",error);

    return res.status(500).json({
      success:false,
      message:"internal server error"
    });
  }
};

export const updateNote=async(req,res)=>{
  try{
    const { note }=req.body;
    const{noteId}=req.params;
    const{employeeId}=req.user;
    const result =await updateNoteService(
      noteId,
      employeeId,
      note
    );
    return res.status(result.statusCode).json(result);
  }catch(error){
    console.error("Error in note update:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server error"
    });
  }
};