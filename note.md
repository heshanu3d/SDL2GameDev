# type
## window
SDL_Window

## surface
SDL_Surface

## event
- SDL_Event
- SDL_KeyboardEvent
```
e.key.keysym.sym
```
## rect
- SDL_Rect

# function
## scenario
- void SDL_Init(Uint32 flags);
- void SDL_Quit();

### window
- SDL_Window * SDL_CreateWindow(const char *title, int x, int y, int w, int h, Uint32 flags);
- void SDL_DestroyWindow(SDL_Window * window);

### surface
- SDL_Surface * SDL_GetWindowSurface(SDL_Window * window);
- void SDL_FreeSurface(SDL_Surface * surface);
- int SDL_UpdateWindowSurface(SDL_Window * window);
- int SDL_FillRect(SDL_Surface * dst, const SDL_Rect * rect, Uint32 color);
- SDL_Surface* SDL_LoadBMP(file)   SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
- #define SDL_BlitSurface SDL_UpperBlit
- int SDL_UpperBlit(SDL_Surface * src, const SDL_Rect * srcrect, SDL_Surface * dst, SDL_Rect * dstrect);
- #define SDL_BlitScaled SDL_UpperBlitScaled
- int SDL_UpperBlitScaled(SDL_Surface * src, const SDL_Rect * srcrect, SDL_Surface * dst, SDL_Rect * dstrect);
- SDL_Surface *SDL_ConvertSurface (SDL_Surface * src, const SDL_PixelFormat * fmt, Uint32 flags);

## error
- const char *SDL_GetError(void);

## event
- int SDL_PollEvent(SDL_Event * event);

## img
- SDL_Surface * SDL_LoadBMP(file)   SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
- int IMG_Init(int flags);
- SDL_Surface * IMG_Load(const char *file);

## color
- Uint32 SDL_MapRGB(const SDL_PixelFormat * format, Uint8 r, Uint8 g, Uint8 b);

# enum
## event
```
typedef enum {
	SDL_QUIT           = 0x100, /**< User-requested quit */
	SDL_KEYDOWN        = 0x300, /**< Key pressed */
	SDL_KEYUP,                  /**< Key released */
```
```
typedef enum {
	SDLK_q = 'q',
    SDLK_RIGHT = SDL_SCANCODE_TO_KEYCODE(SDL_SCANCODE_RIGHT),
    SDLK_LEFT = SDL_SCANCODE_TO_KEYCODE(SDL_SCANCODE_LEFT),
    SDLK_DOWN = SDL_SCANCODE_TO_KEYCODE(SDL_SCANCODE_DOWN),
    SDLK_UP = SDL_SCANCODE_TO_KEYCODE(SDL_SCANCODE_UP),	
```