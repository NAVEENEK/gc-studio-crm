import { employeeLoginService,agencyLoginService } from "./auth.service.js";

export const employeeLogin=async (req,res)=>{
  try{
    const {email,password}=req.body;
  const result =await employeeLoginService(
    email,password
  );
  if(!result.success){
    return res.status(result.statusCode).json(result);
  }
  res.status(200).json(result);
  }catch(error){
    console.error("Employee login controller error:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server error "
    });
  }
};

export const agencyLogin=async (req,res)=>{
  try{
    const {email,password}=req.body;
  const result=await agencyLoginService(
    email,password
  );
  if(!result.success){
    return res.status(result.statusCode).json(result);
  }
  res.status(200).json(result);
  }catch(error){
    console.error("Agency login controller error:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server error "
    });

  }
};