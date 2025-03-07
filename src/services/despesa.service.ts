import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const createDespesaPARCELADO = async (despesaquery: any) => {
  return await prisma.$transaction(async (prisma) => {
    // Criando a despesa principal
    const despesaCriada = await prisma.despesa.create({
      data: {
        valor: despesaquery.valor,
        dataVencimento: despesaquery.dataVencimento,
        descricao: despesaquery.descricao,
        pessoaId: despesaquery.pessoaId,
        cartaoId: despesaquery.cartaoId,
        tipoDespesa: "PARCELADO",
        quantParcelas: despesaquery.parcelas.length,
        mesReferencia: despesaquery.parcelas[0].mesReferencia, // Pegando do primeiro mês
      },
    });

    return despesaCriada;
  });
};
