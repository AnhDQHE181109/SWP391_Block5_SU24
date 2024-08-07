/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Util;

/**
 *
 * @author Long
 */
public class Validator {
        public static int validatePassword(String password) {
            if (password == null) {
                return 1;
            }
            // 1 for invalid
            password = password.trim(); // Trim the password

            // Check if the password is more than 8 characters
            if (password.length() <= 8) {
                return 2;
            }
            //2 for too short
            boolean hasDigit = false;
            boolean hasUppercase = false;

            for (char c : password.toCharArray()) {
                if (Character.isWhitespace(c)) {
                    return 1; // Return 1 if there are any spaces
                }
                if (Character.isDigit(c)) {
                    hasDigit = true;
                }
                if (Character.isUpperCase(c)) {
                    hasUppercase = true;
                }
            }

            if(hasDigit && hasUppercase){return 0;};
            //0 for valid password
            return 3;
            //3 for password don't fufill condition.
        }
}
