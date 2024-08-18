#include <stdio.h>
#include <ft2build.h>
#include FT_FREETYPE_H

int main() {
    // Initialize FreeType library
    FT_Library library;
    if (FT_Init_FreeType(&library)) {
        fprintf(stderr, "Could not initialize FreeType library\n");
        return 1;
    }

    // Load a font face
    FT_Face face;
    if (FT_New_Face(library, "/path/to/your/font.ttf", 0, &face)) {
        fprintf(stderr, "Could not load font\n");
        FT_Done_FreeType(library);
        return 1;
    }

    // Set the font size
    FT_Set_Pixel_Sizes(face, 0, 48);

    // Load a glyph (in this case, the letter 'H')
    if (FT_Load_Char(face, 'H', FT_LOAD_RENDER)) {
        fprintf(stderr, "Could not load glyph\n");
        FT_Done_Face(face);
        FT_Done_FreeType(library);
        return 1;
    }

    // Print a basic message
    printf("Hello, World!\n");

    // Clean up
    FT_Done_Face(face);
    FT_Done_FreeType(library);

    return 0;
}

