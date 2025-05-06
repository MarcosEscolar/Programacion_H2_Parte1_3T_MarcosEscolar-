package AplicacionCine;

import java.util.Scanner;

public class Menu {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int opcion = 0;
        
        while (opcion != 2) {
            System.out.println("Menú:");
            System.out.println("1 - Ver películas");
            System.out.println("2 - Salir");
            System.out.print("Selecciona una opción: ");
            
            try {
                opcion = Integer.parseInt(scanner.nextLine());
                
                switch (opcion) {
                    case 1:
                        Gestion.verPeliculas();
                        break;
                    case 2:
                        System.out.println("Saliendo...");
                        break;
                    default:
                        System.out.println("Opción no válida.");
                }
            } catch (NumberFormatException e) {
                System.out.println("ERROR, ingresa un número válido.");
            }
        }
        
        scanner.close();
    }
}
