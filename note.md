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
e.key.repeat == 0
```
- SDL_Texture
- SDL_Renderer

## rect
- SDL_Rect

## color
- SDL_Color

- SDL_Joystick
- Mix_Music
- Mix_Chunk


# function
## scenario
- void SDL_Init(Uint32 flags);
- void SDL_Quit();

### window
- SDL_Window * SDL_CreateWindow(const char *title, int x, int y, int w, int h, Uint32 flags);
- void SDL_DestroyWindow(SDL_Window * window);
- void SDLCALL SDL_SetWindowTitle(SDL_Window * window, const char *title);
- int SDLCALL SDL_SetWindowFullscreen(SDL_Window * window, Uint32 flags);
- int SDLCALL SDL_GetWindowDisplayIndex(SDL_Window * window);

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
- SDL_Surface * SDL_ConvertSurface (SDL_Surface * src, const SDL_PixelFormat * fmt, Uint32 flags);
- SDL_Surface * IMG_Load(const char *file);
- SDL_Surface * TTF_RenderText_Solid(TTF_Font *font, const char *text, SDL_Color fg);

## texture
- SDL_bool SDL_SetHint(const char *name, const char *value)
- SDL_Texture * SDL_CreateTextureFromSurface(SDL_Renderer * renderer, SDL_Surface * surface);
- void SDL_DestroyTexture(SDL_Texture * texture);
- int SDL_SetTextureColorMod (SDL_Texture * texture, Uint8 r, Uint8 g, Uint8 b);
- int SDL_SetTextureBlendMode(SDL_Texture * texture, SDL_BlendMode blendMode);
- int SDL_SetTextureAlphaMod (SDL_Texture * texture, Uint8 alpha);

## render
- SDL_Renderer * SDL_CreateRenderer(SDL_Window * window, int index, Uint32 flags);
- int SDL_SetRenderDrawColor(SDL_Renderer * renderer, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
- void SDL_DestroyRenderer(SDL_Renderer * renderer);
- int SDL_RenderClear(SDL_Renderer * renderer);
- void SDL_RenderPresent(SDL_Renderer * renderer);
- int SDL_RenderCopy(SDL_Renderer * renderer, SDL_Texture * texture, const SDL_Rect * srcrect, const SDL_Rect * dstrect);
- int SDL_RenderCopyEx(SDL_Renderer * renderer, SDL_Texture * texture, const SDL_Rect * srcrect, const SDL_Rect * dstrect, const double angle, const SDL_Point *center, const SDL_RendererFlip flip);
- int SDL_RenderFillRect(SDL_Renderer * renderer, const SDL_Rect * rect);
- int SDL_RenderDrawRect(SDL_Renderer * renderer, const SDL_Rect * rect);
- int SDL_RenderDrawLine(SDL_Renderer * renderer, int x1, int y1, int x2, int y2);
- int SDL_RenderDrawPoint(SDL_Renderer * renderer, int x, int y);
- int SDL_RenderSetViewport(SDL_Renderer * renderer, const SDL_Rect * rect);

## TTF
- int TTF_Init(void);
- void TTF_Quit(void);
- TTF_Font * TTF_OpenFont(const char *file, int ptsize);
- void SDLCALL TTF_CloseFont(TTF_Font *font);
- SDL_Surface * TTF_RenderText_Solid(TTF_Font *font, const char *text, SDL_Color fg);

## timer
- Uint32 SDL_GetTicks(void);
- void SDL_Delay(Uint32 ms);

## audio
- int SDLCALL SDL_GetNumAudioDevices(int iscapture);
- const char *SDLCALL SDL_GetAudioDeviceName(int index, int iscapture);
- int Mix_OpenAudio(int frequency, Uint16 format, int channels, int chunksize);
- void Mix_Quit(void);
- Mix_Music * Mix_LoadMUS(const char *file);
- Mix_Chunk * Mix_LoadWAV(const char *file);
- void Mix_FreeChunk(Mix_Chunk *chunk);
- int Mix_PlayChannel(int channel, Mix_Chunk *chunk, int loops);
- int Mix_PlayingMusic(void);
- int Mix_PlayMusic(Mix_Music *music, int loops);
- int Mix_PausedMusic(void);
- void Mix_PauseMusic(void);
- void Mix_ResumeMusic(void);
- int Mix_HaltMusic(void);

## error
- const char *SDL_GetError(void);

## event
- int SDL_PollEvent(SDL_Event * event);
- const Uint8 *SDL_GetKeyboardState(int *numkeys);

## keyboard
- SDL_Keymod SDLCALL SDL_GetModState(void);

## io
- SDL_RWops *SDLCALL SDL_RWFromFile(const char *file, const char *mode);
- size_t SDLCALL SDL_RWwrite(SDL_RWops *context, const void *ptr, size_t size, size_t num);
- int SDLCALL SDL_RWclose(SDL_RWops *context);
- size_t SDLCALL SDL_RWread(SDL_RWops *context, void *ptr, size_t size, size_t maxnum);

## joystick
- int SDL_NumJoysticks(void);
- SDL_Joystick *SDL_JoystickOpen(int device_index);
- SDL_GameController *SDL_GameControllerOpen(int joystick_index);
- SDL_bool SDL_GameControllerHasRumble(SDL_GameController *gamecontroller);
- int SDL_JoystickIsHaptic(SDL_Joystick * joystick);
- SDL_Haptic *SDL_HapticOpenFromJoystick(SDL_Joystick *joystick);
- int SDL_HapticRumbleInit(SDL_Haptic * haptic);
- int SDL_GameControllerRumble(SDL_GameController *gamecontroller, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble, Uint32 duration_ms);
- int SDL_HapticRumblePlay(SDL_Haptic * haptic, float strength, Uint32 length );

## img
- int IMG_Init(int flags);
- void IMG_Quit(void);
- SDL_Surface * SDL_LoadBMP(file)   SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
- SDL_Surface * IMG_Load(const char *file);

## color
- Uint32 SDL_MapRGB(const SDL_PixelFormat * format, Uint8 r, Uint8 g, Uint8 b);
- int SDL_SetColorKey(SDL_Surface * surface, int flag, Uint32 key);
- int SDL_SetTextureColorMod(SDL_Texture * texture, Uint8 r, Uint8 g, Uint8 b);

## clipboard
- int SDLCALL SDL_SetClipboardText(const char *text);
- char * SDLCALL SDL_GetClipboardText(void);



# enum
## event
```
typedef enum {
	SDL_QUIT           = 0x100, /**< User-requested quit */
	SDL_KEYDOWN        = 0x300, /**< Key pressed */
	SDL_KEYUP,                  /**< Key released */
    SDL_MOUSEMOTION    = 0x400, /**< Mouse moved */
    SDL_MOUSEBUTTONDOWN,        /**< Mouse button pressed */
    SDL_MOUSEBUTTONUP,          /**< Mouse button released */
	SDL_JOYAXISMOTION  = 0x600, /**< Joystick axis motion */
```
```
typedef enum {
	SDLK_q = 'q',
    SDLK_RIGHT = SDL_SCANCODE_TO_KEYCODE(SDL_SCANCODE_RIGHT),
    SDLK_LEFT = SDL_SCANCODE_TO_KEYCODE(SDL_SCANCODE_LEFT),
    SDLK_DOWN = SDL_SCANCODE_TO_KEYCODE(SDL_SCANCODE_DOWN),
    SDLK_UP = SDL_SCANCODE_TO_KEYCODE(SDL_SCANCODE_UP),	
```
```
SDL_JoyAxisEvent
SDL_JoyBallEvent
```
## SDL_RendererFlip
```
typedef enum
{
    SDL_FLIP_NONE = 0x00000000,     /**< Do not flip */
    SDL_FLIP_HORIZONTAL = 0x00000001,    /**< flip horizontally */
    SDL_FLIP_VERTICAL = 0x00000002     /**< flip vertically */
} SDL_RendererFlip;
```

## SDL_Scancode
```
    SDL_SCANCODE_RIGHT = 79,
    SDL_SCANCODE_LEFT = 80,
    SDL_SCANCODE_DOWN = 81,
    SDL_SCANCODE_UP = 82,
```
