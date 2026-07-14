import { createClientService, updateClientService } from "./client.service.js";

export const createClient = async (req, res) => {
  try {
    const result = await createClientService({
      ...req.body,
      userId:req.user.userId
    });
    return res.status(result.statusCode).json(result);
  }catch(error){
    console.error("Error in creating client:",error);

    return res.status(500).json({
      success:false,
      message:"Internal server error"
    });
  }
};

export const updateClient=async(req,res)=>{
  try{
    const result = await updateClientService({
      ...req.body,
      clientId:req.params.clientId
    });
    return res.status(result.statusCode).json(result);
  }catch(error){
    console.error("Error in updating client:",error);

    return res.status(500).json({
      success:false,
      message:"Internal Server error"
    });
  }
};