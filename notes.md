cd ~/llvm-obfuscator && \
echo "=== ORIGINAL ===" && ./original && \
echo -e "\n=== OBFUSCATED L3 ===" && ./obfuscated_level3 && \
echo -e "\n=== OBFUSCATED L5 ===" && ./obfuscated_level5 && \
echo -e "\n\n========== REPORTS ==========" && \
echo "--- Level 3 Report ---" && cat report_level3.txt && \
echo -e "\n--- Level 5 Report ---" && cat report_level5.txt