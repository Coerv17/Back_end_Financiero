/*
  Warnings:

  - Added the required column `mesReferencia` to the `Despesa` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Despesa" ADD COLUMN     "mesReferencia" TEXT NOT NULL;
