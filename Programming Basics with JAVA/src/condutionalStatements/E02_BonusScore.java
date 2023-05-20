package condutionalStatements;

import java.util.Scanner;

public class E02_BonusScore {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        int number = Integer.parseInt(scanner.nextLine());

        double bonus = 0;
        if (number <= 100) {
            bonus = 5;
        } else if (number > 1000){
            bonus = number * 0.1;
        } else {
            bonus = number * 0.2;
        }

        if (number % 2 == 0) {
            bonus += 1;
        } else if (number % 10 == 5) {
            bonus += 2;
        }

        System.out.printf("%.1f%n", bonus);
        System.out.printf("%.1f", number + bonus);
    }
}
