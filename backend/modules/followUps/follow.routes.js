import express from "express";
import { verifyToken } from "../../middleware/verifyToken.js";
import { allowRole } from "../../middleware/allowRole.js";
import { changeStatus, createFollow, updateFollow, viewFollow } from "./follow.controller.js";

const router=express.Router();

router.post("/create/:leadId",verifyToken,allowRole("employee"),createFollow);
router.patch("/status/:followId",verifyToken,allowRole("employee"),changeStatus);
router.patch("/update/:followId",verifyToken,allowRole("employee"),updateFollow);
//list of follow up of a single employee
router.get("/view/employee/:employeeId",verifyToken,viewFollow);
//list of follow up of a single lead 
router.get("/view/lead/:leadId",verifyToken,viewFollow);
//list of follow up based on status
router.get("/view/status/:status",verifyToken,viewFollow);
//list of overdue/today follow up
router.get("/view/:filter",verifyToken,viewFollow);

export default router;