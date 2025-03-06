import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

interface Despesa {
  valor: number;
  dataVencimento: Date;
  descricao?: string;
  pessoaId: number;
  cartaoId?: number;
  mesReferencia: string;
}

export const despesaService = {
  async criarDespesaSimples(despesa: Despesa) {
    return await prisma.despesa.create({
      data: despesa,
    });
  },

  async criarDespesaParcelada(despesas: Despesa[]) {
    return await prisma.$transaction(
      despesas.map((despesa) => prisma.despesa.create({ data: despesa }))
    );
  },
};

export const findAllService = async (): Promise<any[]> => {
  try {
    const despesas = await prisma.despesa.findMany();
    return despesas;
  } catch (error) {
    throw error;
  }
};
