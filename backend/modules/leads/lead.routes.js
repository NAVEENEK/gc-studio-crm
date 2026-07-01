import express from "express";
import { verifyToken } from "../../middleware/verifyToken.js";
import { manualLead } from "./lead.controller.js";

const router=express.Router();

router.post("/create",verifyToken,manualLead);

export default router;