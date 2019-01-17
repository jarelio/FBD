package connection;

import java.sql.*;

public class ConnectionFactory {
    
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=spotper"; // O "control" representa a minha database 
    private static final String USER = "sa";
    private static final String PASS = "123456";
    
    public static Connection conectar() { // Metodo responsavel por realizar a conexão;
        try {
            System.setProperty("jdbc.Drivers", DRIVER); // Seta a propriedade do driver de conexão;
            return DriverManager.getConnection(URL, USER, PASS); // Realiza a conexão com o banco;
        } catch (SQLException ex) {
            throw new RuntimeException("Erro na conexão ", ex);
        }
    }
    
    public static void desconectar(Connection con) { // Metodo responsavel por fechar a conexão
        if (con!=null){
            try {
                con.close(); // Fechar conexão
            } catch (SQLException ex) {
                System.err.println("Erro ao desconectar do Banco de Dados! " + ex);
            }
        }

    }
    
    public static void desconectar(Connection con, PreparedStatement stmt) { // Metodo responsavel por fechar a conexão
        if (stmt!=null){
            try {
                stmt.close(); // Fechar conexão
            } catch (SQLException ex) {
                System.err.println("Erro ao desconectar do Banco de Dados! " + ex);
            }
        }
        desconectar(con);
    }
    
    public static void desconectar(Connection con, PreparedStatement stmt, ResultSet rs) { // Metodo responsavel por fechar a conexão
        if (rs!=null){
            try {
                rs.close(); // Fechar conexão
            } catch (SQLException ex) {
                System.err.println("Erro ao desconectar do Banco de Dados! " + ex);
            }
        }
        desconectar(con, stmt);
    }
    
}