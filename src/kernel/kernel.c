void print_string(char* str) {
    char* video_memory = (char*) 0xb8000;
    
    for (int i = 0; str[i] != '\0'; i++) {
        video_memory[i * 2] = str[i];
        video_memory[i * 2 + 1] = 0x0f;
    }
}

int main(void) {
    char *str = "Hello World!";
    print_string(str);
    
    return 0;
}