import express from "express";
import { agencyLogin, employeeLogin } from "./auth.controller.js";

const router=express.Router();

router.post("/employee/login",employeeLogin);
router.post("/agency/login",agencyLogin);

export default router;