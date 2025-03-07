import express from "express";
import { despesaPARCELADO, despesaSimples } from "../controllers/despesa.controller";
import { validarTipoDespesaMiddleware } from "../middlewares/Depesa.middelwares";
//import { FindaAllDepesa } from "../controllers/despesa.controller";

const router = express.Router();

router.post("/", despesaPARCELADO);
//router.get("/", FindaAllDepesa);

export default router;
