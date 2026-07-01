export const allowRole=(...role)=>{
  return (req,res,next)=>{
    const userRole=req.user.role;
    if(!role.includes(userRole)){
      return res.status(403).json({
        success:false,
        message:"Access denied"
      });
    }
    next();
  };
};