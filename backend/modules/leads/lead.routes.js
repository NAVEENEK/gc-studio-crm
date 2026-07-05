import express from "express";
import { verifyToken } from "../../middleware/verifyToken.js";
import { manualLead,viewLeads,leadInfo, changeStatus, assignEmployee, updateLead } from "./lead.controller.js";
import { allowRole } from "../../middleware/allowRole.js";

const router=express.Router();

router.post("/create",verifyToken,manualLead);
router.get("/viewLeads",verifyToken,viewLeads);
router.get("/info/:leadId",verifyToken,leadInfo);
router.patch("/status/:leadId",verifyToken,allowRole("employee"),changeStatus);
router.patch("/assign/:leadId",verifyToken,allowRole("manager"),assignEmployee);
router.put("/update/:leadId",verifyToken,allowRole("employee"),updateLead);

export default router;