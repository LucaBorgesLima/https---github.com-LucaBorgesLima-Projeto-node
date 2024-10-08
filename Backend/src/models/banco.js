//conexao com banco de dados

const mysql = require('mysql2/promise');

require('dotenv').config()

const conexao = mysql.createPool({
    host : process.env.MYSQL_HOST,
    user : process.env.MYSQL_USER,
    password : process.env.MYSQL_PASSWORD,
    database : process.env.MYSQL_DB,
    connectTimeout: 20000
});

module.exports = conexao;            