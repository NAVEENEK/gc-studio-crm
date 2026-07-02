import express from "express";
import { verifyToken } from "../../middleware/verifyToken.js";
import { manualLead,viewLeads } from "./lead.controller.js";
import { allowRole } from "../../middleware/allowRole.js";

const router=express.Router();

router.post("/create",verifyToken,manualLead);
router.get("/viewLeads",verifyToken,viewLeads)

export default router;