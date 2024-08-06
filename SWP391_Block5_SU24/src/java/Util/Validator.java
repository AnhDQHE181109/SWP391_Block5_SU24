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
        public static boolean validatePassword(String password) {
            if (password == null) {
                return false;
            }

            password = password.trim(); // Trim the password

            // Check if the password is more than 8 characters
            if (password.length() <= 8) {
                return false;
            }

            boolean hasDigit = false;
            boolean hasUppercase = false;

            for (char c : password.toCharArray()) {
                if (Character.isWhitespace(c)) {
                    return false; // Return false if there are any spaces
                }
                if (Character.isDigit(c)) {
                    hasDigit = true;
                }
                if (Character.isUpperCase(c)) {
                    hasUppercase = true;
                }
            }

            return hasDigit && hasUppercase;
        }
}
