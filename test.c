#include <stdio.h>
#include <string.h>

void greet(const char* name) {
    printf("Hello, %s!\n", name);
    printf("Welcome to the obfuscation test.\n");
}

int calculate(int a, int b) {
    if (a > b) {
        return a + b;
    } else if (a < b) {
        return a * b;
    } else {
        return a - b;
    }
}

int factorial(int n) {
    int result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}

int complex_logic(int x, int y, int z) {
    int result = 0;
    if (x > 10) {
        if (y < 5) {
            result = x + y;
        } else {
            result = x - y;
        }
    } else {
        if (z == 0) {
            result = x * y;
        } else {
            result = x / z;
        }
    }
    return result;
}

int main() {
    const char* secret = "SecretPassword123";
    greet("User");
    int num1 = 15;
    int num2 = 20;
    printf("Calculation result: %d\n", calculate(num1, num2));
    printf("Factorial of 5: %d\n", factorial(5));
    printf("Complex logic: %d\n", complex_logic(12, 3, 2));
    if (strcmp(secret, "SecretPassword123") == 0) {
        printf("Access granted!\n");
    } else {
        printf("Access denied!\n");
    }
    return 0;
}
