#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <string.h>

unsigned char put_in_channel(int value, int max)
{
    return ((float)max/255.0f)*value;
}

void remove_slashes(char* destiny, char* filename, int num_excluded_end_characters)
{
    int size = strlen(filename);
    int current_pos = 0;

    for(int i = 0; i < size - num_excluded_end_characters; ++i)
    {
        destiny[current_pos] = filename[i];
        ++current_pos;

        if(filename[i] == '/' || filename[i] == '\\')
        {
            current_pos = 0;
        }
    }

    destiny[current_pos] = '\0';
}

int main()
{
    int width, height, padding, bitcount, size;
    unsigned char *data = 0;
    unsigned char info[54] = { 0 };
    char filename[400];

    printf("BMP Sprite: ");
    scanf("%s", filename);

    int filename_size = strlen(filename);
    if(
        filename[filename_size - 3] != 'b' ||
        filename[filename_size - 2] != 'm' ||
        filename[filename_size - 1] != 'p'
    )
    {
        printf("[ERRO] Not a .bmp file.");
        return -1;
    }

    FILE *file = fopen(filename, "rb");
    if(!file)
    {
        printf("[ERROR] File Not Found.\n");
        return -1;
    }

    // Get BMP Informations
    fread(info, 1, 54, file);
    width = *(int*)(info + 18);
    height = *(int*)(info + 22);
    bitcount = *(int*)(info + 28);
    size = ((width * bitcount + 31) / 32) * 4 * height;
    padding = width % 4;

    if(bitcount != 24)
    {
        printf("\n[ERROR] Not is a 24 bits channel.\n");
        return -1;
    }

    printf("width = %d, height = %d, bitcount = %d, size = %d bytes\n\n", width, height, bitcount, size);

    // Get Filename with ".s"
    char filename_saved[filename_size];
    strcpy(filename_saved, filename);
    filename_saved[filename_size - 3] = 's';
    filename_saved[filename_size - 2] = '\0';

    // Creating File
    FILE* saved_file = fopen(filename_saved, "w");
    if(!saved_file)
    {
        printf("[Error] File to be saved not created.\n");
        return -1;
    }

    // Creating File Label
    char image_label[400];
    remove_slashes(image_label, filename_saved, 2);

    fprintf(saved_file, "%s: ", image_label);

    // Starting file definition
    fprintf(saved_file, ".word %d, %d\n.byte\n", width, height);

    // Inserting pixels
    data = (unsigned char*)malloc(size);
    fread(data, 1, size, file);

    int col_counter = 0;
    for(int row = height - 1; row >= 0; row--)
    {
        for(int col = 0; col < width; col++)
        {
            int p = (row * width + col) * 3 + row * padding;

            // Bit Aspect: (BBGGGRRR)
            fprintf(saved_file, "%d,",
                (put_in_channel(data[p + 0], 3) << 6) |      // R
                (put_in_channel(data[p + 1], 7) << 3) | // G
                (put_in_channel(data[p + 2], 7))   // B
            );

            ++col_counter;
            if(col_counter == 16)
            {
                fprintf(saved_file, "\n");
                col_counter = 0;
            }
        }
    }

    printf("[INFO] File saved in '%s'\n", filename_saved);
    
    fclose(saved_file);
    fclose(file);
    free(data);

    return 0;
}