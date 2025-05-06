package AplicacionCine;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionMySQL {
    
    // Método estático que devuelve una conexión a la base de datos
    public static Connection obtenerConexion() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/Cine_MarcosEscolar";
        String user = "root";
        String password = "1234"; 
        
        return DriverManager.getConnection(url, user, password);
    }

    public static void main(String[] args) {
        // Llamada al método obtenerConexion para verificar la conexión
        try {
            Connection conexion = obtenerConexion();
            System.out.println(" Conexión exitosa a MySQL");
            conexion.close();
        } catch (SQLException e) {
            System.out.println(" Error al conectar: " + e.getMessage());
        }
    }
}

