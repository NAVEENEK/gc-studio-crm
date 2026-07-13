import { createClientService } from "./client.service.js";

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