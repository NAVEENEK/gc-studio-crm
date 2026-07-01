import { employeeLoginService,agencyLoginService } from "./auth.service.js";

export const employeeLogin=async (req,res)=>{
  const {email,password}=req.body;
  const result =await employeeLoginService(
    email,password
  );
  res.json(result);
};

export const agencyLogin=async (req,res)=>{
  const {email,password}=req.body;
  const result=await agencyLoginService(
    email,password
  );
  res.json(result);
};