import express from "express";
import { criarDespesa } from "../controllers/despesa.controller";
import { validarTipoDespesaMiddleware } from "../middlewares/Depesa.middelwares";
import { FindaAllDepesa } from "../controllers/despesa.controller";

const router = express.Router();

router.post("/", validarTipoDespesaMiddleware, criarDespesa);
router.get("/", FindaAllDepesa);

export default router;
