import { Request, Response } from "express";
import { addMonths, format } from "date-fns";
import { createDespesaPARCELADO } from "../services/despesa.service";

// Função auxiliar para validar a data de vencimento
const validarDataVencimento = (dataVencimento: string): { data: Date; mesReferencia: string } | null => {
  const data = new Date(dataVencimento);
  if (isNaN(data.getTime())) return null;
  const mesReferencia = format(data, "yyyy-MM");
  return { data, mesReferencia };
};

export const despesaPARCELADO = async (req: Request, res: Response): Promise<void> => {
  try {
    const { valor, dataVencimento, descricao, pessoaId, cartaoId, quantParcelas } = req.body;
    const validacao = validarDataVencimento(dataVencimento);
    if (!validacao) {
      res.status(400).json({ message: "Data de vencimento inválida" });
      return;
    }

    const despesas = [];
    const dataBase = new Date(dataVencimento);
    // Verifica se o dia da data base é o último dia do mês
    const ultimoDiaDoMesUTC = new Date(Date.UTC(dataBase.getUTCFullYear(), dataBase.getUTCMonth() + 1, 0)).getUTCDate();
    const isUltimoDia = dataBase.getUTCDate() === ultimoDiaDoMesUTC;

    for (let i = 0; i < quantParcelas; i++) {
      let dataParcela;
      if (isUltimoDia) {
        // Se for o último dia, sempre busca o último dia do mês correspondente
        dataParcela = new Date(Date.UTC(dataBase.getUTCFullYear(), dataBase.getUTCMonth() + i + 1, 0));
      } else {
        dataParcela = addMonths(dataBase, i);
      }
      const mesReferencia = format(dataParcela, "yyyy-MM");

      despesas.push({
        valor,
        dataVencimento: dataParcela,
        descricao,
        pessoaId,
        cartaoId,
        mesReferencia,
      });
    }

    console.log("Dados enviados para o service:", JSON.stringify(despesas, null, 2));
    //const passandoService = await createDespesaPARCELADO(despesas);
    //res.status(201).json(passandoService);
    return;
  } catch (error) {
    console.error("Erro ao criar despesa parcelada:", error);
    res.status(500).json({ message: "Erro interno do servidor" });
    return;
  }
};
