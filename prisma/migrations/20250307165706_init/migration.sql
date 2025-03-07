/*
  Warnings:

  - You are about to drop the `Parcela` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Parcela" DROP CONSTRAINT "Parcela_despesaId_fkey";

-- DropTable
DROP TABLE "Parcela";
