import jwt from "jsonwebtoken";
import db from "../config/db.js";

export const verifyToken = (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader) {
      return res.status(401).json({
        success: false,
        message: "Token missing"
      });
    }
    const token = authHeader.split(" ")[1];
    const decoded = jwt.verify(
      token, process.env.JWT_SECRET
    );

    const[rows]=await db.query(
      `select employee_status
      from employees
      where employee_id=?`,
      [decoded.employeeId]
    );
    if(rows.length===0){
      return res.status(401).json({
        success:false,
        message:"Employee not found"
      });
    }
    if(rows[0].employee_status !== "active"){
      return res.status(403).json({
        success:false,
        message:"Account is inactive"
      });
    }
    req.user = decoded

    next();
  } catch (error) {
    return res.status(401).json({
      success: false,
      message: "Invalid or expired token "
    });
  }
}