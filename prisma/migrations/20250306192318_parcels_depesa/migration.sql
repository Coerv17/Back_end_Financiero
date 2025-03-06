/*
  Warnings:

  - You are about to drop the column `repetir` on the `Despesa` table. All the data in the column will be lost.
  - You are about to drop the `ParcelaDespesa` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "ParcelaDespesa" DROP CONSTRAINT "ParcelaDespesa_despesaId_fkey";

-- AlterTable
ALTER TABLE "Despesa" DROP COLUMN "repetir";

-- DropTable
DROP TABLE "ParcelaDespesa";

-- CreateTable
CREATE TABLE "Parcela" (
    "id" SERIAL NOT NULL,
    "numero" INTEGER NOT NULL,
    "valor" DOUBLE PRECISION NOT NULL,
    "vencimento" TIMESTAMP(3) NOT NULL,
    "pago" BOOLEAN NOT NULL DEFAULT false,
    "mesReferencia" TEXT NOT NULL,
    "despesaId" INTEGER NOT NULL,

    CONSTRAINT "Parcela_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Parcela" ADD CONSTRAINT "Parcela_despesaId_fkey" FOREIGN KEY ("despesaId") REFERENCES "Despesa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
