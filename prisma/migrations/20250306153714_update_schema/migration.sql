/*
  Warnings:

  - You are about to alter the column `nome` on the `Cartao` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(50)`.
  - You are about to alter the column `ultimos4Digitos` on the `Cartao` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(4)`.
  - You are about to alter the column `nome` on the `Pessoa` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - Added the required column `pessoaId` to the `Cartao` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Despesa" DROP CONSTRAINT "Despesa_cartaoId_fkey";

-- AlterTable
ALTER TABLE "Cartao" ADD COLUMN     "pessoaId" INTEGER NOT NULL,
ALTER COLUMN "nome" SET DATA TYPE VARCHAR(50),
ALTER COLUMN "ultimos4Digitos" SET DATA TYPE VARCHAR(4);

-- AlterTable
ALTER TABLE "Despesa" ALTER COLUMN "cartaoId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Pessoa" ALTER COLUMN "nome" SET DATA TYPE VARCHAR(100);

-- AddForeignKey
ALTER TABLE "Cartao" ADD CONSTRAINT "Cartao_pessoaId_fkey" FOREIGN KEY ("pessoaId") REFERENCES "Pessoa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Despesa" ADD CONSTRAINT "Despesa_cartaoId_fkey" FOREIGN KEY ("cartaoId") REFERENCES "Cartao"("id") ON DELETE SET NULL ON UPDATE CASCADE;
