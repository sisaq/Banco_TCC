@echo off
:: Armazenar o diretório original (onde o script está sendo executado)
set original_dir=%cd%
 
:: Exibir o diretório armazenado (opcional, apenas para verificação)
echo Diretório original: %original_dir%
 
:: Mudar para o diretório do MySQL
cd /d C:\xampp\mysql\bin
 
:: Rodar o MySQL e importar o database.sql (ajuste a senha se necessário)
mysql -u root < "%original_dir%\scripts\database\banco_TCC.sql"
 
:: Voltar para o diretório original
cd /d %original_dir%
 
:: Exibir uma mensagem de sucesso
echo Retornado ao diretório original: %original_dir%
echo Tabelas criadas com sucesso!
pause