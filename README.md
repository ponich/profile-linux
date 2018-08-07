#### Putty проблема с шрифтами

 - [качаем и устанавливаем шрифты](https://github.com/powerline/fonts/tree/master/DejaVuSansMono)

 - `Putty` -> `Window` -> `Appearance` -> `Fonts settings`, установим шрифт **_DejaVu Sans Mono_**

 - `Putty` -> `Window` -> `Translation` -> установим кодировку **_UTF-8_**

 - `Putty` -> `Connection` -> `Data` -> `Terminal-type string` зададим **_xterm-256color_** 
 
 
#### Tmux проблема с шрифтами powerline

[открыть решения](https://github.com/wernight/powerline-web-fonts/issues/8)

В конец вашего `.bashrc` || `.zshrc`:

```bash
export LANG=ru_RU.UTF-8
export LC_CTYPE=ru_RU.UTF-8
```

