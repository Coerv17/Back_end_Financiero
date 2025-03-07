-- CreateEnum
CREATE TYPE "TipoDespesa" AS ENUM ('SIMPLES', 'FIXO', 'PARCELADO');

-- CreateTable
CREATE TABLE "Pessoa" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(100) NOT NULL,
    "dataCriacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Pessoa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cartao" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(50) NOT NULL,
    "ultimos4Digitos" VARCHAR(4) NOT NULL,
    "dataCriacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Cartao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Despesa" (
    "id" SERIAL NOT NULL,
    "valor" DOUBLE PRECISION NOT NULL,
    "dataVencimento" TIMESTAMP(3) NOT NULL,
    "dataCriacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "descricao" TEXT,
    "pago" BOOLEAN NOT NULL DEFAULT false,
    "tipoDespesa" "TipoDespesa" NOT NULL DEFAULT 'SIMPLES',
    "quantParcelas" INTEGER,
    "mesReferencia" TEXT NOT NULL,
    "pessoaId" INTEGER NOT NULL,
    "cartaoId" INTEGER,
    "referenciaParcela" TEXT NOT NULL,

    CONSTRAINT "Despesa_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Despesa" ADD CONSTRAINT "Despesa_pessoaId_fkey" FOREIGN KEY ("pessoaId") REFERENCES "Pessoa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Despesa" ADD CONSTRAINT "Despesa_cartaoId_fkey" FOREIGN KEY ("cartaoId") REFERENCES "Cartao"("id") ON DELETE SET NULL ON UPDATE CASCADE;
