import express from "express";
import { verifyToken } from "../../middleware/verifyToken.js";
import { allowRole } from "../../middleware/allowRole.js";
import { changeStatus, createFollow, updateFollow, viewFollow } from "./follow.controller.js";

const router=express.Router();

router.post("/create/:leadId",verifyToken,allowRole("employee"),createFollow);
router.patch("/status/:followId",verifyToken,allowRole("employee"),changeStatus);
router.patch("/update/:followId",verifyToken,allowRole("employee"),updateFollow);
router.get("/view",verifyToken,viewFollow);

export default router;