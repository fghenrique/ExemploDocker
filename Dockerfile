# Derivando da imagem oficial do MySQL
FROM mysql:5.7

# Adicionando variaveis para o banco de dados
ENV MYSQL_DATABASE concentrador
ENV MYSQL_ALLOW_EMPTY_PASSWORD true

# Adicionando os arquivos de configuração do MySQL para serem aplicados na criação do banco
COPY ./conf/my.cnf /etc/mysql/mysql.conf.d/my.cnf

# Adicionando os scripts SQL para serem executados na criação do banco
COPY ./db/ /docker-entrypoint-initdb.d/

EXPOSE 3306
