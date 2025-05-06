package AplicacionCine;

import java.sql.*;

public class Gestion {

    public static void verPeliculas() {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            con = ConexionMySQL.obtenerConexion();
            stmt = con.createStatement();
            String query = "SELECT p.codigo, p.titulo, p.duracion, g.nombre AS genero " +
                           "FROM pelicula p " +
                           "JOIN generos g ON p.id_genero = g.id_genero"; // Usar 'codigo' en lugar de 'id_pelicula'
            rs = stmt.executeQuery(query);

            System.out.printf("%-5s %-30s %-10s %-20s\n", "Código", "Título", "Duración", "Género");
            System.out.println("----------------------------------------------------------");

            while (rs.next()) {
                String codigo = rs.getString("codigo");
                String titulo = rs.getString("titulo");
                int duracion = rs.getInt("duracion");
                String genero = rs.getString("genero");

                System.out.printf("%-5s %-30s %-10d %-20s\n", codigo, titulo, duracion, genero);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener las películas: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Error al cerrar la conexión: " + e.getMessage());
            }
        }
    }
}


