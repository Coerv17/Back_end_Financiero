import { Request, Response } from "express";
import { addMonths, format, lastDayOfMonth } from "date-fns";
import { createDespesaPARCELADO } from "../services/despesa.service";

// Função auxiliar para validar a data de vencimento
const validarDataVencimento = (dataVencimento: string): { data: Date; mesReferencia: string } | null => {
  const data = new Date(dataVencimento);
  if (isNaN(data.getTime())) return null;
  const mesReferencia = format(data, "yyyy-MM");
  return { data, mesReferencia };
};

export const despesaSimples = async (req: Request, res: Response): Promise<void> => {
  try {
    const { valor, dataVencimento, descricao, pessoaId, cartaoId } = req.body;

    const validacao = validarDataVencimento(dataVencimento);
    if (!validacao) {
      res.status(400).json({ message: "Data de vencimento inválida" });
      return;
    }

    const novaDespesa = {
      valor,
      dataVencimento: validacao.data,
      descricao,
      pessoaId,
      cartaoId,
      mesReferencia: validacao.mesReferencia,
    };

    console.log("Dados enviados para o service:", JSON.stringify(novaDespesa, null, 2));

    res.status(201).json(novaDespesa);
    return;
  } catch (error) {
    console.error("Erro ao criar despesa simples:", error);
    res.status(500).json({ message: "Erro interno do servidor" });
    return;
  }
};
export const despesaPARCELADO = async (req: Request, res: Response): Promise<void> => {
  try {
    const { valor, dataVencimento, descricao, pessoaId, cartaoId, quantParcelas } = req.body;
    const validacao = validarDataVencimento(dataVencimento);
    if (!validacao) {
      res.status(400).json({ message: "Data de vencimento inválida" });
      return;
    }

    const parcelas = [];
    const dataBase = new Date(dataVencimento);
    // Calcula o último dia do mês em UTC
    const ultimoDiaDoMesUTC = new Date(Date.UTC(dataBase.getUTCFullYear(), dataBase.getUTCMonth() + 1, 0)).getUTCDate();
    const isUltimoDia = dataBase.getUTCDate() === ultimoDiaDoMesUTC;

    for (let i = 0; i < quantParcelas; i++) {
      let dataParcela;
      if (isUltimoDia) {
        // Cria a data usando UTC para garantir que seja o último dia do mês
        dataParcela = new Date(Date.UTC(dataBase.getUTCFullYear(), dataBase.getUTCMonth() + i + 1, 0));
      } else {
        dataParcela = addMonths(dataBase, i);
      }
      const mesReferenciaParcela = format(dataParcela, "yyyy-MM");
      parcelas.push({ parcela: i + 1, dataParcela, valor, mesReferencia: mesReferenciaParcela });
    }

    const despesaquery = {
      valor,
      dataVencimento: validacao.data,
      descricao,
      pessoaId,
      cartaoId,
      parcelas,
      mesReferencia: validacao.mesReferencia,
    };

    console.log("Dados enviados para o service:", JSON.stringify(despesaquery, null, 2));
    const passandoService = await createDespesaPARCELADO(despesaquery);
    res.status(201).json(passandoService);
    return;
  } catch (error) {
    console.error("Erro ao criar despesa parcelada:", error);
    res.status(500).json({ message: "Erro interno do servidor" });
    return;
  }
};
