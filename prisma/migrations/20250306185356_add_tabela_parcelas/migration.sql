/*
  Warnings:

  - You are about to drop the column `pessoaId` on the `Cartao` table. All the data in the column will be lost.
  - The `tipoDespesa` column on the `Despesa` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "TipoDespesa" AS ENUM ('SIMPLES', 'FIXO', 'PARCELADO');

-- DropForeignKey
ALTER TABLE "Cartao" DROP CONSTRAINT "Cartao_pessoaId_fkey";

-- AlterTable
ALTER TABLE "Cartao" DROP COLUMN "pessoaId";

-- AlterTable
ALTER TABLE "Despesa" ADD COLUMN     "repetir" BOOLEAN NOT NULL DEFAULT false,
DROP COLUMN "tipoDespesa",
ADD COLUMN     "tipoDespesa" "TipoDespesa" NOT NULL DEFAULT 'SIMPLES';

-- CreateTable
CREATE TABLE "ParcelaDespesa" (
    "id" SERIAL NOT NULL,
    "despesaId" INTEGER NOT NULL,
    "numeroParcela" INTEGER NOT NULL,
    "valor" DOUBLE PRECISION NOT NULL,
    "dataVencimento" TIMESTAMP(3) NOT NULL,
    "mesReferencia" TEXT NOT NULL,

    CONSTRAINT "ParcelaDespesa_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ParcelaDespesa" ADD CONSTRAINT "ParcelaDespesa_despesaId_fkey" FOREIGN KEY ("despesaId") REFERENCES "Despesa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
